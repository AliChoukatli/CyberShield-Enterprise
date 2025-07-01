
#---------------------------------------------------------[Initialisations]--------------------------------------------------------
Param (
    [switch]$InstallOffice365 = $False,
    [switch]$SuppressReboot = $False,
    [Switch]$Force = $False,
    [switch]$RunAgain = $False,
    [int]$SecondsToReboot = 60
)
#----------------------------------------------------------[Declarations]----------------------------------------------------------
$SaRA_URL = "https://aka.ms/SaRA_CommandLineVersionFiles"
$SaRA_ZIP = "$env:TEMP\SaRA.zip"
$SaRA_DIR = "$env:TEMP\SaRA"
$SaRA_EXE = "$SaRA_DIR\SaRAcmd.exe"
$Office365Setup_URL = "https://github.com/Admonstrator/msoffice-removal-tool/raw/main/office365-installer"
#-----------------------------------------------------------[Functions]------------------------------------------------------------
Function Invoke-OfficeUninstall {
    if (-Not (Test-Path "$SaRA_DIR")) {
        New-Item "$SaRA_DIR" -ItemType Directory | Out-Null
      }
    
}

Function Invoke-SaRADownload {    
    Start-BitsTransfer -Source "$SaRA_URL" -Destination "$SaRA_ZIP" 
    if (Test-Path "$SaRA_ZIP") {
        Write-Host "Unzipping ..."
        Expand-Archive -Path "$SaRA_ZIP" -DestinationPath "$SaRA_DIR" -Force
        if (Test-Path "$SaRA_DIR\DONE") {
            Move-Item "$SaRA_DIR\DONE\*" "$SaRA_DIR" -Force
            if (Test-Path "$SaRA_EXE") {
                Write-Host "SaRA downloaded successfully."
            }
            else {
                Write-Error "Download failed. Program terminated."
                Exit 1
            }
        }
    }
}

Function Remove-SaRA {  
    if (Test-Path "$SaRA_ZIP") {
        Remove-Item "$SaRA_ZIP" -Force
    }

    if (Test-Path "$SaRA_DIR") {
        Remove-Item "$SaRA_DIR" -Recurse -Force
    }
}
 
Function Stop-OfficeProcess {
    Write-Host "Stopping running Office applications ..."
    $OfficeProcessesArray = "lync", "winword", "excel", "msaccess", "mstore", "infopath", "setlang", "msouc", "ois", "onenote", "outlook", "powerpnt", "mspub", "groove", "visio", "winproj", "graph", "teams"
    foreach ($ProcessName in $OfficeProcessesArray) {
        if (get-process -Name $ProcessName -ErrorAction SilentlyContinue) {
            if (Stop-Process -Name $ProcessName -Force -ErrorAction SilentlyContinue) {
                Write-Output "Process $ProcessName was stopped."
            }
            else {
                Write-Warning "Process $ProcessName could not be stopped."
            }
        } 
    }
}

Function Invoke-SaRA {
    $SaRAProcess = Start-Process -FilePath "$SaRA_EXE" -ArgumentList "-S OfficeScrubScenario -AcceptEula -CloseOffice -OfficeVersion All" -Wait -PassThru -NoNewWindow
    switch ($SaRAProcess.ExitCode) {
        0 {
            Write-Host "Uninstall successful!"
            Set-CurrentStage 2
            Break
        }
    
        7 {
            Write-Host "No office installations found."
            Set-CurrentStage 2
            Break
        }

        8 {
            Write-Error "Multiple office installations found. Program need to be run in GUI mode."
            Set-CurrentStage 4
            Exit 2
        }

        9 {
            Write-Error "Uninstall failed! Program need to be run in GUI mode."
            Set-CurrentStage 4
            Exit 3
        }
    }
}



Function Invoke-RebootInSeconds($Seconds) {
    if (-not $SuppressReboot) {
        Start-Process -FilePath "$env:SystemRoot\system32\shutdown.exe" -ArgumentList "/r /c `"Reboot needed. System will reboot in $Seconds seconds.`" /t $Seconds /f /d p:4:1"
    }
}

Function Set-CurrentStage($StageValue) {
    if (-not (Test-Path "HKLM:\Software\OEM\Singleton-Factory-GmbH\M365\Install")) {
        New-Item -Path "HKLM:\Software\OEM\Singleton-Factory-GmbH\M365\Install" -Force | Out-Null
    }
    New-ItemProperty -Path "HKLM:\Software\OEM\Singleton-Factory-GmbH\M365\Install" -Name "CurrentStage" -Value $StageValue -PropertyType String -Force | Out-Null
}

Function Invoke-Intro {   
Write-Host "  __ _             _      _                  ___          _                   "
Write-Host " / _(_)_ __   __ _| | ___| |_ ___  _ __     / __\_ _  ___| |_ ___  _ __ _   _ "
Write-Host " \ \| | '_ \ / _' | |/ _ \ __/ _ \| '_ \   / _\/ _' |/ __| __/ _ \| '__| | | |"
Write-Host " _\ \ | | | | (_| | |  __/ || (_) | | | | / / | (_| | (__| || (_) | |  | |_| |"
Write-Host " \__/_|_| |_|\__, |_|\___|\__\___/|_| |_| \/   \__,_|\___|\__\___/|_|   \__, |"
Write-Host "             |___/                                                      |___/ "
Write-Host "Microsoft Office Removal Tool"
Write-Host "by Aaron Viehl (Singleton Factory GmbH)"
Write-Host "singleton-factory.de"
Write-Host ""
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------

# Check if -Force is set
if (-Not $Force) {
    do {
        $YesOrNo = Read-Host "Are you sure you want to remove Office from this PC? (y/n)"
    } while ("y", "n" -notcontains $YesOrNo)

    if ($YesOrNo -eq "n") {
        exit 1
    }
}

Invoke-Intro

if (-not ($RunAgain)) {
    if (Test-Path "HKLM:\Software\OEM\Singleton-Factory-GmbH\M365\Install") {
        $CurrentStageValue = (Get-ItemProperty "HKLM:\Software\OEM\Singleton-Factory-GmbH\M365\Install").CurrentStage
        Switch ($CurrentStageValue) {
            1 {
                Write-Host "Resuming Stage 1: Uninstalling Office ..."
                Invoke-OfficeUninstall 
                Remove-SaRA
                Invoke-RebootInSeconds $SecondsToReboot
            }

            2 {
                Write-Host "Office already uninstalled. Nothing more to do."
                Remove-SaRA
            }

            3 {
                Write-Host "Resuming Stage 3: Cleaning up ..."
                Remove-SaRA
            }

            4 {
                Write-Host "Script already completed."
                exit 0
            }

            default {
                Write-Host "Uninstalling Office ..."
                Invoke-OfficeUninstall 
                Remove-SaRA
                Invoke-RebootInSeconds $SecondsToReboot
            }
        }
    }
    else {
        Invoke-Intro
        Stop-OfficeProcess
        Invoke-OfficeUninstall 
        Invoke-RebootInSeconds $SecondsToReboot
    }
}
else {
    Invoke-Intro
    Stop-OfficeProcess
    Invoke-OfficeUninstall 
    Invoke-RebootInSeconds $SecondsToReboot
}
