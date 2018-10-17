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
Remove local git branches that are deleted from the origin.

.DESCRIPTION
Removes local git branches that are deleted from the origin using `git fetch --prune` and `git branch -[dD]`.

.PARAMETER Force
Switch to to force removal using `git branch -D` instead of `git branch -d`.

.EXAMPLE
Remove-DeletedGitBranches
Removes merged non-existing branches.

.EXAMPLE
Remove-DeletedGitBranches -Force
Removes all non-existing branches.

.NOTES
This cmdlet uses `git fetch --prune`, so it will delete references to non-existing branches in the process. Use with caution.
#>
function Remove-DeletedGitBranches
{
    param
    (
        [Parameter()]
        [Switch]
        $Force
    )

    $null = (git fetch --all --prune);
    $branches = git branch -vv | Select-String -Pattern ": gone]" | ForEach-Object { $_.toString().Split(" ")[2] };
    if($Force)
    {
        $branches | ForEach-Object {git branch -D $_};
    }
    else 
    {        
        $branches | ForEach-Object {git branch -d $_};        
    }
}

Set-Alias -Name "rmdelbr" -Value Remove-DeletedGitBranches
```