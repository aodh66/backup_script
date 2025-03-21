# Backup PowerShell Script

This is a powershell script that I made to automate my weekly system backups.

If you want to use this yourself, take `backupEXAMPLE.ps1` and rename it to `backup.ps1`. Next fill in the `userFolder` variable at the top of the file with your user folder name (You can find it at `C:\Users\userFolder`). After that you need to fill in the `scriptPath` variable with the location of the install folder you have cloned this repo into. You would also need to define the path(s) that you want to back up to. I have the paths of my storage and external drive listed under `storageDrive` and `externalDrive`.


<!-- If you want to use it or modify it yourself, you will need to define your user folder's name and change the path to where you cloned this folder to in `define_userEXAMPLE.ps1` and run it to generate an XML file with the user folder in the file.

After that run the `define_user.ps1` script and it will generate your `userFolder.xml` file to feed the userFolder variable into the main `backup.ps1` script. -->