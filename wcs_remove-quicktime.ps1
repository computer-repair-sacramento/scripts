<#	
	.NOTES
	===========================================================================
	 Original script by:    The Immortal - https://community.spiceworks.com/topic/1560779-silent-uninstall-script-for-quicktime
	 Updated on:            20200131
	 Updated by: 	        Computer Repair Sacramento
	 Filename:     	        wcs_remove-quicktime.ps1
     CAUTION: distributed freely without any warranty or guarantee of suitability of fitness for any purpose! Use at your own risk!

	===========================================================================
	.DESCRIPTION
		Powershell script to uninstall quicktime. Report result to dashboard.
#>


$qtVer = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall  |
    Get-ItemProperty |
        Where-Object {$_.DisplayName -match "quicktime" } |
            Select-Object -Property DisplayName, UninstallString

if ($qtVer -ne $null)

{

    ForEach ($ver in $qtVer) {

        If ($ver.UninstallString) {

            $uninst = $ver.UninstallString
            $uninst = $uninst -replace "/I", "/x "
            Start-Process cmd -ArgumentList "/c $uninst /quiet /norestart" -NoNewWindow
            Write-Host "Removed: QuickTime $ver"
        }
    }

}

Else

{
    Write-Host "QuickTime not found"
}
