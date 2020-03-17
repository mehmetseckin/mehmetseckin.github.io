---
title: Show TFS branch name in Visual Studio Window Title
date: 2017-07-10 00:00:00 +0000
categories: [Software Engineering, Tips]
tags: [visual studio, tfs, branch]
seo:
  date_modified: 2020-03-17 00:40:12 +0000
---

If you’ve been working with Visual Studio, TFS and have multiple branches in your project, you probably felt lost at times.

Visual Studio doesn’t hint us about the active branch we’re working on unless we explicitly check the local folders. So, it can quickly become a pain to use Visual Studio when working with different branches, especially you need them open simultaneously (often doing a merge), because there’s no way to tell which branch is active on which instance.

This simple, yet effective feature has actually been suggested to and rejected by the VS team.

![The rejected feature suggestion on Microsoft Connect]({{ "/assets/img/posts/connect-add-branch-name-to-vs-title-suggestion.png" | relative_url }})
*The rejected feature suggestion on Microsoft Connect*

As a workaround, I used an extension called [Customize Visual Studio Window Title](https://marketplace.visualstudio.com/items?itemName=mayerwin.RenameVisualStudioWindowTitle), and tweaked its options to show branch names, it’s quite effective.

This extension allows you to include a variety of information in the Visual Studio window title.

Combining parentPath, which represents the physical path to the solution you’re working on, with the depth options, allowed me to strip out the branch folder name. Here’s how it looks:

![Visual Studio Window Title]({{ "/assets/img/posts/vs-window-title-blurred.png" | relative_url }})
*The active TFS branch names are visible on the Visual Studio window titles*

![Visual Studio Taskbar Titles]({{ "/assets/img/posts/vs-taskbar-titles-blurred.png" | relative_url }})
*The branch names also become visible on the Taskbar titles*

Configuring this extension separately for each solution is possible, however, it requires you to have an accompanying configuration xml file next to your .sln file.

I’m currently using the following options globally:

|                              |                                              |
|------------------------------|----------------------------------------------|
| Closest parent folder depth  | `3`                                          |
| Farthest parent folder depth | `3`                                          |
| Pattern                      | `(⎇ [parentPath]) [solutionName] – [ideName]`|

![Extension Settings]({{ "/assets/img/posts/vs-rename-title-settings.png" | relative_url }})
*My current settings to achieve the titles seen above. The folder depth may vary for your appliance*
