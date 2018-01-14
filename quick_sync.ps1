#!powershell

<#
.SYNOPSIS
Quick and dirty syncing script.

.DESCRIPTION
PowerShell wrapper script for Robocopy. Syncs the source directory to the destination directory. Generates a log
file from Robocopy and writes over logs which each sync. Intended to be used with Task Scheduler.

.EXAMPLE
> .\quick_sync.ps1
#>

$Source = ""
$Destination = ""
$LogOutput = ""

Function Sync-Files($Source, $Destination, $LogOutput) {
	ROBOCOPY $Source $Destination /MIR /LOG:$LogOutput 
	if ($LastExitCode -ge 2) {
		return $False
	}
	else {
		return $True
	}
}

function main() {
	Write-Host "=========="
	Write-Host "Quick Sync"
	Write-Host "=========="
	Write-Host "This script makes a local backup copy of your documents, pictures, etc."
	Write-Host "From: $Source"
	Write-Host "To: $Destination"
	Write-Host "Depending on how many files you've added, this may take several minutes."
	Write-Host ""
	
	$CopyResult = Sync-Files $Source $Destination $LogOutput
	
	if ($CopyResult -eq $False) {
		Write-Host "Sync may have failed. Check $LogOutput for more details."
	}
	else {
		Write-Host "Backup complete!"
	}
}

main