#!/bin/bash

# Add udev rule for memory subsystem
echo 'SUBSYSTEM=="memory", ACTION=="add", ATTR{state}="online"' | tee /etc/udev/rules.d/100-balloon.rules >/dev/null
udevadm trigger

# Install XRDP and configure it
apt update
apt install -y xrdp
systemctl enable --now xrdp

# Create and configure polkit file
mkdir -p /etc/polkit-1/localauthority/50-local.d/
tee /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla >/dev/null <<EOF
[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.*
ResultAny=no
ResultInactive=no
ResultActive=yes
EOF

# Enable Hyper-V enhanced mode
/usr/lib/kali_tweaks/helpers/hyperv-enhanced-mode enable

# Install Python
apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python3-openssl git

# Install Cargo
apt-get update
apt-get install -y cargo

# Install Maltego
apt-get install maltego

chmod +x $HOME/kali-setup/kali-setup2.sh

function path-config-instruct() {
echo "PATH variables can only be permanently configured by editing the ZSH config file as a user." 
echo "( '$HOME/.zshrc' )"
sleep 2
echo "The terminal will now open a new file view window." 
sleep 2
echo "To continue the setup, copy the contents of 'path-config' and paste it here in the terminal."
sleep 2
echo "Opening 'path-config'..."
sleep 1
}

path-config-instruct &
wait

sudo mousepad kali-setup/path-config
