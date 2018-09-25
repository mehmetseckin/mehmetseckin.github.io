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

<script src="https://gist.github.com/seckin92/3629d5f54d8f25955a9926b1c5991a51.js"></script>