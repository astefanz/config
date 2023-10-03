# setup
Personal configuration files and provisioning scripts. I use Arch btw.

Based on Arch Linux, inspired by Luke Smith's [LARBS](larbs.xyz) and heavily reliant on [suckless.org](https://suckless.org).

I use this repository to iterate on my computing setup.
***
```

                   -`                    pilot@dakota 
                  .o+`                   ------------ 
                 `ooo/                   OS: Arch Linux x86_64 
                `+oooo:                  Host: LIFEBOOK P728 
               `+oooooo:                 Kernel: 6.5.5-arch1-1 
               -+oooooo+:                Uptime: 13 mins 
             `/:-:++oooo+:               Packages: 473 (pacman) 
            `/++++/+++++++:              Shell: bash 5.1.16 
           `/++++++++++++++:             Resolution: 1920x1080 
          `/+++ooooooooooooo/`           WM: dwm 
         ./ooosssso++osssssso+`          Theme: Adwaita [GTK3] 
        .oossssso-````/ossssss+`         Icons: Adwaita [GTK3] 
       -osssssso.      :ssssssso.        Terminal: Neovim Terminal 
      :osssssss/        osssso+++.       CPU: Intel i7-8650U (8) @ 4.200GHz 
     /ossssssss/        +ssssooo/-       GPU: Intel UHD Graphics 620 
   `/ossssso+/:-        -:/+osssso+-     Memory: 852MiB / 15828MiB 
  `+sso+:-`                 `.-/+oso:
 `++:.                           `-/+/
 .`                                 `/  
```

# Installation 2023.10.02.1

Last installation broke when I moved the SSD into my laptop.

I retried the same thing but with GRUB as bootloader. It still breaks, but telling GRUB to start using
fallback initramfs from Advanced Options works.

#### Touchpad setup
Install the `xf86-input-synaptics` package:
```bash
synclient # to see current settings
synclient TapButton1=1 # tap-to-click for left click
synclient TapButton2=3 # tap-to-click for right click with two fingers 
# (finger vertical scrolling came enabled by default after installing the package)
```

#### Bluetooth
See https://wiki.archlinux.org/title/Bluetooth
```bash
# Assuming bluez and bluez-utils are installed (pacman)
# Enable daemon:
systemctl enable bluetooth.service
systemctl start bluetooth.service

# Use CLI to pair to devices:
bluetoothctl
# (in CLI:)
scan on
# (find MAC address of your device)
pair MAC_ADDRESS_OF_DEVICE
```

#### Install `yay` and AUR
See: makeuseof.com/install-and-use-yay-arch-linux/
```bash
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

#### Arduino IDE
See https://wiki.archlinux.org/title/Arduino

Install `arduino-ide-bin` for 2.x release of the IDE **using `yay`, not `pacman`**

Add user to the `uucp` group for serial access:
```bash
sudo usermod -aG uucp $USER
```

#### Dark theme
```bash
# Assuming lxappearance is installed
# Assuming yay is set up
yay yaru-gtk-theme
yay yaru-icon-theme
yay xcursor-breeze
# Set these using lxappearance
```

# Installation 2023.09.30.6

hello from chrooted pilot@dakota

Started using Luke Smith's *Install Artix or Arch Linux (Encrypted system)* video
https://www.youtube.com/watch?v=dI3bGeT31Bo

Installing off of existing `mango@dakota` installation, into a new drive.

Decided to try `archinstall` off of `mango@dakota` Arch into a new drive,
connected externally.

```bash
# Reinstall archinstall because the default one is no good
pacman -S archinstall
```

Saved `archinstall` configuration in this repository's `archinstall/` directory.

#### You can download the Arch wiki
```bash
sudo pacman -S arch-wiki-lite # for terminal
sudo pacman -S arch-wiki-docs # For HTML version
# Access HTML version by opening /usr/share/arch-wiki/html/en/Main_page.html
```


#### From LS video

- Install `extra/arch-install-scripts`
> `lsblk` to look for target disk

> `ls /sys/firmware/efi/efivars` and if something comes out you are in a
> UEFI system, instead of a legacy boot system.


***
# New System Setup

https://wiki.archlinux.org/title/installation_guide

Using Arch Linux from the installation ISO with `archinstall`

#### Boot into a live Arch installer

#### Connect to the internet

Use either ethernet or `iwctl`

```bash
# For WiFi
iwctl
# (inside iwctl terminal)
station wlan0 connect SSID
# (enter password)
exit # exit iwctl
```

Confirm you're connected

```bash
ip link
ping archlinux.org
```


##### Confirm the clock is synchronized

Will happen automatically when online

```bash
timedatectl
# check that the clock is synchronized
```

##### Confirm `pacman` is done initializing

https://bbs.archlinux.org/viewtopic.php?id=283075

This is an example way to have a provisioning script wait until the initialization is complete before trying to use `pacman` or its wrappers:

```bash
echo "waiting for pacman keyring init to be done"

while ! systemctl show pacman-init.service | grep SubState=exited; do
    systemctl --no-pager status -n0 pacman-init.service || true
    sleep 1
done
```
#### Update keyring
```bash
pacman -Sy archlinux-keyring
```


#### Install with `archinstall`

```bash
pacman -Sy archinstall
archinstall
# Or, if you have a configuration file, like the ones
# in this repository's archinstall/ directory
archinstall --config user_configuration.json
# i.e. the path to the .json file to use ^
```

##### Packages to install with `archinstall` (system-level)

```bash
## TO INSTALL WITH ARCHINSTALL
# Critical
neofetch figlet
man-pages man-db texinfo openssh openssl lvm2
git base-devel
neovim zsh rsync htop
zip unzip gnupg
arch-wiki-lite
arch-wiki-docs
lynx
wget
xdg-tools
gparted

# Graphics
[xorg and video drivers]
xorg xorg-xinit xorg-server
xwallpaper xdotool xcape arandr
xf86-input-synaptics
lxappearance
pcmanfm # file manager

slock

arandr ttf-inconsolata ttf-linux-libertine ttf-dejavu
libxinerama libxft # <- for dwm

scrot # screenshots

# Sound
pipewire
[pipewire packages]

# Bluetooth
bluez bluez-util

# Networking
networkmanager
nm-connection-editor
[network drivers (NetworkManager)]

# For future installations
archinstall arch-install-scripts pam-u2f

# Tools (1)
jupyter-notebook
python-numpy
python-pandas
python-matplotlib
python-scikit-learn
python-pytorch # why tf is this 5GB
python-gpgme

# Tools (2)
krita inkscape blender docker yt-dlp brave-browser firefox freecad # [...]

# Tools (3)
dolphin-emu
virtualbox # with virtualbox-host-modules-arch 
virtualbox-guest-iso
```


# Post-installation tasks

##### Copy `.ssh` directory for github access and import own repositories

```bash
# Put id_ed25519 and id_ed25519.pub in ~/.ssh
# See ssh/deploykeys.sh in this repository
```

```bash
# Once SSH keys have been ported over and added to the SSH agent
git clone git@github.com:astefanz/setup.git
git clone git@github.com:astefanz/dwm.git
git clone git@github.com:astefanz/st.git
git clone git@github.com:astefanz/dmenu.git
```



### Setup graphical environment
Install Xorg packages, `dwm` dependencies and fonts
May also have been installed in the `archinstall` step
```bash
pacman -S xorg xorg-xinit libxinerama libxft ttf-inconsolata ttf-linux-libertine \
    ttf-dejavu

```



#### Post-setup packages (user level)

```bash
## TO INSTALL POST INSTALLATION INTO USER
doas [docker stuff]

# Basic
[virtualbox stuff] [jupyter and python packages]
# Latex:
texlive-plaingeneric
[more latex and jupyter latex]


[compilers]
[extended fonts]

yt-dlp ffmpeg

# Software tools:
krita blender freecad inkscape xournalpp brave [firefox or librewolf]
[email and calendar] [music] vlc

```
## Setup scripts
[...]

***
# Other stuff

### Other things

#### To create an user

```bash
# Here "mango" is the username
useradd --create-home --shell /usr/bin/zsh --groups wheel mango

# Then set mango's password with:
passwd mango

# Edit /etc/sudoers to allow all users in the wheel
# group to use sudo
#
# in vim, incomment the line with the following:
# %wheel ALL=(ALL) ALL
vim /etc/sudoers
```

Add to `wheel` and later `docker` group

Make superuser

Set `zsh` as shell

Give it a `home` directory etc.



# Things to figure out to make this usable

- lock screen with timeout and shortcut
- decryption screen that isn't trash with P728
- (~) backups and data synchronization


# Things to figure out

- .vimrc and nvim packages, mine and LS
- zsh configuration files
- /etc/sudoers

- Backups
- Decryption and login that isn't trash
- Automatic lock
- Sound and bluetooth
- Touchscreen and graphics drivers
- Automatically deal with new monitors and remember old ones
- Calibrate touchscreen to not be trash when a monitor is connected
- Compartmentalization
- FoSS Virtualization
- Videogame emulation
- Torrenting
- My Vim configs. `vim` vs `nvim`?
- How to download videos and convert videos and audio.. and trim audio
- How to burn audio CDs
- What to take from LS configs
    - `remaps`
    - `setbg`
- Email and Calendar with synchronization and backups
- Put everything in provisioning scripts
- Fonts
- rEFInd? What is the most secure possible way to encrypt a laptop drive?
- How to download documentation esp. Wikipedia, Arch Wiki and Stack Exchange
- Searx, integrated with my own archives
- Refactor storage and make Dropbox and iCloud obsolete
- Layered encryption
- New encryption scheme





# Repositories to fork

dwm

dmenu

dwmblocks

tabbed

st

larbs



***

### Archiving
- Consider `git-annex`: https://git-annex.branchable.com/install/
- But `rsync` will probably do
- Use Git for writing and code
  - Overleaf supports Git integration

-

### Keeping source code

https://stackoverflow.com/questions/4468447/how-to-download-source-code-with-pacman-on-arch-linux



### Security

- https://wiki.archlinux.org/title/Data-at-rest_encryption
- https://wiki.archlinux.org/title/List_of_applications/Security#Privilege_elevation
- https://wiki.archlinux.org/title/General_recommendations



### `nvim` is better than `vim`

https://www.baeldung.com/linux/vim-vs-neovim

https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html



### Simple pomodoro timing

See https://superuser.com/questions/224265/

Make this into a script

```bash
# Wait 1500s (25min) and send a notification to take a break:
sleep 1500 && notify-send "break"

# Same as above but with a dialog box you have to click OK on to remove:
sleep 1500 && zenity --warning --text="25 minutes passed"
```

### Remapping pen and touch sensor to laptop screen with multiple monitors
https://askubuntu.com/questions/51445/
```bash
# For "dakota" Fujitsu P728
xinput # find id of input device. For me it's 13 for pen and 9 for finger
xrandr # find name of laptop display. For me it's eDP1
xinput map-to-output  9 eDP1 # Fix finger touch
xinput map-to-output 13 eDP1 # Fix pen touch
```
