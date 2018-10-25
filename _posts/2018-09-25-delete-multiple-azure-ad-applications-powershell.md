---
layout: post
title: Delete multiple Azure Active Directory applications via PowerShell
---

{{ page.title }}
================

<p class="meta">25 September 2018, Birmingham, UK</p>

Recently, I needed a quick way to delete multiple Azure Active Directory applications. This is unfortunately not possible through the Azure portal, so it was time for a little PowerShell magic.

I came up with a little command named `Remove-AzureADApplications`, which will present a list of applications on your tenant and delete the selected applications. It also features a silent execution mode (`-Force` parameter) and a `display name begins with` filter option (`-SearchString` parameter).

Check it out:

```powershell
<#
  .SYNOPSIS
  Delete multiple Azure AD applications based on a search criteria.
  
  .DESCRIPTION
  The Remove-AzureADApplications cmdlet displays a list of all applications registered in the Azure Active Directory, and deletes specified applications from Azure Active Directory (AD).
  
  .PARAMETER SearchString
  The service principal search string.

  .PARAMETER Force
  Forces the command to run without asking for user confirmation. This will remove all applications that match the filter criteria specified by the SearchString parameter, without displaying a list and waiting for the user to specify which applications are going to be deleted. If the SearchString parameter is omitted, this will attempt to delete all application registrations without confirmation. Use with caution.

  .EXAMPLE
  Remove-AzureADApplications

  Displays the list of all applications registered in the Azure Active Directory, and deletes selected applications.
  
  .EXAMPLE
  Remove-AzureADApplications -SearchString "deleteme" -Force

  Remove applications whose names start with "deleteme" without displaying a list for the user to select.
#>
function Remove-AzureADApplications 
{
    [CmdletBinding()]
    param
    (
        [Parameter(HelpMessage = "The service principal search string.")]
        [string]
        $SearchString = "",    
        [Parameter(HelpMessage ="Forces the command to run without asking for user confirmation. This will remove all applications that match the filter criteria specified by the SearchString parameter. If the SearchString parameter is omitted, this will attempt to delete all application registrations without confirmation. Use with caution.")]
        [Switch]
        $Force
    )

    Import-Module "AzureAD";

    if ($SearchString) {
        $apps = (Get-AzureADApplication -SearchString $SearchString)
    }
    else {
        Write-Warning "No search string specified. Fetching all applications."
        $apps = (Get-AzureADApplication -All $true)
    }

    if($Force)
    {
        $selectedApps = $apps;
    }
    else
    {
        $selectedApps = $apps | Out-GridView -Title "Please select applications to remove..." -OutputMode Multiple;
    }

    $selectedApps | ForEach-Object {
    
        $displayName = $_.DisplayName;
        $objectId = $_.ObjectId;
        try {
            Remove-AzureADApplication -ObjectId $objectId
            Write-Host "Removed $displayName..." -ForegroundColor Green;
        }
        catch {
            Write-Host "Failed to remove $displayName..." -ForegroundColor Red;
        }
    }
}
```