# Diagnostic Scripts

These PowerShell scripts automate collection of system information used during the HP Victus Audio Kernel Crash investigation.

Run PowerShell as Administrator whenever possible.

Each script prints information to the console and can optionally be redirected to a text file.

Example:

```powershell
.\collect-driver-info.ps1 > driver-info.txt
