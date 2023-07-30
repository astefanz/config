#!/bin/sh
# Decrypt GitHub private OpenSSL key in this directory
# and place it and the public key in ~/.ssh
#
# See: https://devconnected.com/how-to-encrypt-file-on-linux/
# They key was encrypted using GnuPG like this:
# gpg -c ./id_ed25519
#
# Can also use an encrypted .zip archive:
# zip -r --encrypt encrypted_archive.zip dir_to_encrypt
# zip -r --encrypt encrypted_archive.zip file_or_files_to_encrypt

PRIVATEKEY_DECRYPTED=id_ed25519
PRIVATEKEY_ENCRYPTED=id_ed25519.gpg
PUBLICKEY=id_ed25519.pub
SSH_DIR=~/.ssh/

# Welcome message
echo "SSH key deployment script."
echo "NOTE that it is better to have a key with a passphrate"
echo "Implement this in the future"
echo "Ensure openssh is installed and the ssh-agent is running"
eval `$(ssh-agent -s)`
echo "[Press Enter to continue]"
read

# Decrypt key:
echo "Decrypting $PRIVATEKEY_ENCRYPTED"
gpg -d $PRIVATEKEY_ENCRYPTED > $PRIVATEKEY_DECRYPTED

# Move keys to ~/.ssh
echo "Moving keys to $SSH_DIR"
mkdir -p $SSH_DIR
cp $PUBLICKEY $SSH_DIR
mv $PRIVATEKEY_DECRYPTED $SSH_DIR

# Add message to ssh-agent
echo "Adding keys to ssh-agent"
ssh-add $SSH_DIR/$PRIVATEKEY_DECRYPTED
ssh-add -l
