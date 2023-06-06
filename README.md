kali-setup
=========

Setup script made for configuring Kali Linux virtual machines on Hyper-V.

Information
-----------

This script was initally created to fix an error I encountered while trying to configure Hyper-V enhanced sessions in Kali Linux. You may not get the same error message, in which case you might be able to configure enhanced sessions for Hyper-V without any issues.

Normally, you would do this by using the kali-tweaks menu:
```bash
kali-tweaks
```
You would then select 'Virtualization', then 'Configure' to configure the system for enhanced sessions in Hyper-V.

Error message:
```
Couldn't install the following package(s): 'pulseaudio-module-xrdp xrdp'
```

Run the following command to fix the error message before proceeding to installation:
```bash
sudo apt-get remove -y libc6-dev
```

Installation
------------

Since this script is meant to be ran immediately after installing the OS, it is assumed that the GitHub CLI has not been installed yet. To install GitHub CLI, enter the following into the terminal:
```bash
sudo apt-get install -y gh
```

Next, login to GitHub using GitHub CLI:
```bash
gh auth login
```

Clone the repository and make the setup script executable:
```bash
gh repo clone crypt0lith/kali-setup
sudo chmod +x $HOME/kali-setup/kali-setup.sh
```

Run the setup script:
```bash
sudo ./kali-setup/kali-setup.sh
```

The script will perform the following steps:

1. Add a udev rule for the memory subsystem.
    * Without this rule, GRUB bootloader will freeze during the boot process while trying to calculate memory allocation. This is because GRUB is unaware that it is a VM using dynamic memory allocation.
3. Install XRDP and configure it.
4. Create and configure the polkit file.
    * This polkit file is required to enable Hyper-V enhanced mode, but it does not exist.
6. Enable Hyper-V enhanced mode.
7. Install Python and dependencies.
8. Install Cargo.
9. Install Maltego.
    * Useful intel gathering (passive and active) application for Ethical Activities. 
10. Configure PATH variables for pyenv and Cargo.

During the setup process, you will be prompted to paste the contents of the `path-config` file into the terminal. Follow the instructions provided.
  * My speedrun strategy is `Ctrl+A`, `Ctrl+C`, `Alt+F4`, `Ctrl+Shift+V`, `Enter`.

After the script completes, reinitialize the shell by entering this in the terminal:
```bash
exec $SHELL
```

In the reinitialized shell, run the following to execute the second script and install `pyenv`
```bash
source ${HOME}/kali-setup/kali-setup2.sh
```

Shut down the Kali Linux virtual machine:
```bash
sudo shutdown -h now
```

Finally, open PowerShell as administrator and run the following command, replacing `'YOUR VM NAME'` with the name of your Kali Linux virtual machine:
```powershell
Set-VM "('YOUR VM NAME')" -EnhancedSessionTransportType HVSocket
```
  * For example, if your VM was named `'kali-client'`, you would run the command:
  ```powershell
  Set-VM "kali-client" -EnhancedSessionTransportType HVSocket
  ```





