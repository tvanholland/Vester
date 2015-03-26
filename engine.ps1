#Requires -Version 4.0

# Map the various jobs into a hashtable
# Code credit to cdituri
$jobMap = [Ordered]@{
  "DNS"    = "\VMware\set-dns.ps1";
  "NTP"    = "\VMware\set-ntp.ps1";
  "SSH"    = "\VMware\set-ssh.ps1";
  "DRS"    = "\VMware\set-drs.ps1";
  "Syslog" = "\VMware\set-syslog.ps1";
  "Media"  = "\VMware\remove-media.ps1"
}

# Collect data and send to dashboard
# Code credit to cdituri
$jobMap.Keys | % {
  $scriptPath = Join-Path $PSScriptRoot $jobMap[$_]
  Start-Job -Name "$($_)" -ScriptBlock { Invoke-Expression $args[0] } -ArgumentList $scriptPath
}

Get-Job | Wait-Job | ft -AutoSize
Get-Job | Remove-Job | ft -AutoSize