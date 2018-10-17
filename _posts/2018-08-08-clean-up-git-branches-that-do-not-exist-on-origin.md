---
layout: post
title: Clean up git branches that do not exist on origin
---

{{ page.title }}
================

<p class="meta">08 August 2018, Birmingham, UK</p>

After our team worked on a git repository for a while, we accumulated a lot of useless branches that are no longer being used. We've removed these branches regularly from the origin, but the local branches remained in everyone's workstations like zombies.

It was time to do something.

That's when we decided to combine the powers of `git fetch --prune` and shell scripting to forge a PowerShell function that will kill the zombie branches in our local repositories.

The script simply uses `git fetch --all --prune` to update all remote references (`--all`) and drop deleted ones (`--prune`).

After this, it filters out the local branches that do not exist on the origin by scraping the output of `git branch -vv`, and deletes the zombie local branches.

Here's the whole thing:

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
