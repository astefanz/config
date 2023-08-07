# setup
Personal configuration files and provisioning scripts. I use Arch btw.

Based on Arch Linux, inspired by Luke Smith's [LARBS](larbs.xyz) and heavily reliant on [suckless.org](https://suckless.org).

I use this repository to iterate on my computing setup.

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

# Graphics
[xorg and video drivers]
xorg xorg-xinit

arandr ttf-inconsolata ttf-linux-libertine ttf-dejavu
libxinerama libxft # <- for dwm

# Sound
[pipewire]

# Networking
[network drivers (NetworkManager)]

# For future installations
archinstall arch-install-scripts pam-u2f
```



# Post-installation tasks

##### Copy `.ssh` directory for github access and import own repositories

```bash
# Put id_ed25519 and id_ed25519.pub in ~/.ssh

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
[latex and jupyter latex]

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

#### Create user

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



