#* =================================== 
#* ============ Variables ============ 
#* =================================== 
$userFolder = "YOUR_USER_FOLDER"
$userPath = "C:\Users\$userFolder"
$scriptPath = "$userPath\Documents\workspace\personal\backup_script"
# Both storage and external would have docs subfolders and entire pics folder backing up to them
#* Drives
# backup location storage drive
$storageDrive = "D:\Backups\Documents & Pictures"
# backup location external drive
$externalDrive = "F:\Backups\Documents & Pictures"

#* Config Backup
# backup location config backup
$configBackupPath = "$userPath\Documents\config_backup"
# # Included config folders to copy
# $includedConfigs = @(
#     "Documents\workspace\personal\glazeWM_restart\glazeWM_kill.bat", 
#     ".glzr\glazewm\config.yaml", 
#     "AppData\Local\nvim", 
#     "Documents\Obsidian\.obsidian", 
#     "stelbent-compact.minimal.omp.json", 
#     "Documents\PowerShell\Microsoft.PowerShell_profile.ps1", 
#     "AppData\Roaming\SyncTrayzor\config.xml", 
#     "AppData\Roaming\Code\User"
# )

#* Documents & Pictures
# Documents location
$documentsPath = "$userPath\Documents"
# # Included Documents folders to copy
# $includedDocuments = @(
#     "Misc", 
#     "Obsidian", 
#     "Obsidian_Backups", 
#     "My Games", 
#     "Official Documents"
# )
# Pictures location
$picturesPath = "$userPath\Pictures"

# #* Hashes
# # MD5 Hashes of files to be backed up
# $documentsHashFile = "$scriptPath\MD5_document_hashes.txt"
# $picturesHashFile = "$scriptPath\MD5_picture_hashes.txt"
# $configHashFile = "$scriptPath\MD5_config_hashes.txt"

# #* Error messages
# $errorMessages = @()

#* =================================== 
#* ============ Functions ============ 
#* =================================== 

#* =================================== 
#* ============== Logic ============== 
#* =================================== 
# Launch check
Write-Host "Backup initiated!"
Write-Host "userFolder is: $userFolder, scriptPath is: $scriptPath"

# =================================== 
# ===== Backup to storage drive =====
# =================================== 
Write-Host "Backing up $picturesPath to $storageDrive\Pictures..."
Copy-Item $picturesPath -Destination $storageDrive\Pictures -Recurse -Force

Write-Host "Backing up $documentsPath to $storageDrive\Documents..."
# Backup Misc
Copy-Item "$documentsPath\Misc" -Destination $storageDrive\Documents -Recurse -Force
# # Backup My Games
Copy-Item "$documentsPath\My Games" -Destination $storageDrive\Documents -Recurse -Force
# # Backup Obsidian
Copy-Item "$documentsPath\Obsidian" -Destination $storageDrive\Documents -Recurse -Force
# # Backup Obsidian_Backups
Copy-Item "$documentsPath\Obsidian_Backups" -Destination $storageDrive\Documents -Recurse -Force
# # Backup Official Documents
Copy-Item "$documentsPath\Official Documents" -Destination $storageDrive\Documents -Recurse -Force

# =================================== 
# ===== Backup to external drive ====
# =================================== 
# Check that the drive is connected
if (Test-Path -Path $externalDrive) {
    Write-Host "Backing up $picturesPath to $externalDrive\Pictures..."
    Copy-Item $picturesPath -Destination $externalDrive\Pictures -Recurse -Force

    Write-Host "Backing up $documentsPath to $externalDrive\Documents..."
    # Backup Misc
    Copy-Item "$documentsPath\Misc" -Destination $externalDrive\Documents -Recurse -Force
    # Backup My Games
    Copy-Item "$documentsPath\My Games" -Destination $externalDrive\Documents -Recurse -Force
    # Backup Obsidian
    Copy-Item "$documentsPath\Obsidian" -Destination $externalDrive\Documents -Recurse -Force
    # Backup Obsidian_Backups
    Copy-Item "$documentsPath\Obsidian_Backups" -Destination $externalDrive\Documents -Recurse -Force
    # Backup Official Documents
    Copy-Item "$documentsPath\Official Documents" -Destination $externalDrive\Documents -Recurse -Force
}
else {
    Write-Host "External Drive not connected. Skipping backup to external drive."
}

# =================================== 
# ========== Config Backup ==========
# =================================== 
Write-Host "Performing config backup..."
# Copy Obsidian config
Copy-Item "$userPath\Documents\Obsidian\.obsidian" -Destination $configBackupPath -Recurse -Force
# Copy Neovim config
Copy-Item "$userPath\AppData\Local\nvim" -Destination $configBackupPath -Recurse -Force
# Copy VSCode config
Copy-Item "$userPath\AppData\Roaming\Code\User" -Destination $configBackupPath -Recurse -Force
# Copy SyncTrayzor config
Copy-Item "$userPath\AppData\Roaming\SyncTrayzor\config.xml" -Destination $configBackupPath -Force #-Recurse
# Copy GlazeWM config
Copy-Item "$userPath\.glzr\glazewm\config.yaml" -Destination $configBackupPath -Force #-Recurse
# Copy PowerShell 7 config
Copy-Item "$userPath\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Destination $configBackupPath -Force #-Recurse
# Copy Oh-My-Posh config
Copy-Item "$userPath\stelbent-compact.minimal.omp.json" -Destination $configBackupPath -Force #-Recurse


# =================================== 
# =========== Git Backup ============
# =================================== 
$currentDate = Get-Date -Format "dd-MM-yyyy"
$commitConfigBackup = @"
git add -A
git commit -m '$currentDate backup'
git push
"@
# Open shell in config_backup after, git add -A; git commit -m "${backupDate} backup" ready to git push
Start-Process pwsh.exe -ArgumentList "-NoExit", "-Command", $commitConfigBackup -WorkingDirectory "$configBackupPath"

# Open shell in choc_dactyl after, git add -A; git commit -m "${backupDate} backup" ready to git push
Start-Process pwsh.exe -ArgumentList "-NoExit", "-Command", $commitConfigBackup -WorkingDirectory "C:\Users\aodha\Documents\qmk_firmware\keyboards\handwired\choc_dactyl"

# Open shell in qmk_firmware after, git add -A; git commit -m "${backupDate} backup" ready to git push
Start-Process pwsh.exe -ArgumentList "-NoExit", "-Command", $commitConfigBackup -WorkingDirectory "C:\Users\aodha\Documents\qmk_firmware"
