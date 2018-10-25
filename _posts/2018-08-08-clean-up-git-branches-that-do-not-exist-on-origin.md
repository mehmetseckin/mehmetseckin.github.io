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
