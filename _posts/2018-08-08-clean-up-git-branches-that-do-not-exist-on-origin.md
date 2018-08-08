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

Here it goes:

<script src="https://gist.github.com/seckin92/45e866885b6c6bfde46180e34e29b83e.js"></script>