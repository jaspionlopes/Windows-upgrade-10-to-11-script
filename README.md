# Windows 10 to 11 Upgrade Script

A PowerShell script with a graphical interface to quickly and easily upgrade from Windows 10 to Windows 11. 
It allows you to select a Windows 11 ISO, applies hardware bypasses (TPM, CPU, RAM, Secure Boot), and automatically starts the upgrade process.

## Instructions
1. Download the files `upgrade.bat` and `10to11.ps1`.
2. Run `upgrade.bat` as administrator.
3. Select the Windows 11 ISO image downloaded from Microsoft
and click **OK** on next window to start the upgrade

Windows11 official ISO repositories to download:
- **English version:** [Download Windows 11](https://www.microsoft.com/en-us/software-download/windows11)
- **Brazilian Portuguese version:** [Download Windows 11](https://www.microsoft.com/pt-br/software-download/windows11)

## Key Features
- ISO selection through a GUI.
- Mounts the ISO and runs `setup.exe`.
- Applies bypasses for compatibility requirements.
- Automatically starts the upgrade with EULA acceptance.
- Visual feedback on success or errors.

## Warning
- Use at your own risk; modifies Windows registry.
- Always back up your data before upgrading.

## Requirements
- Windows 10.
- PowerShell 5.1 or higher.
- Administrator permissions.

**Tested on:** Windows 10 22H2 with a Windows 11 24H2 ISO image.

