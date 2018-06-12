---
layout: post
title: A Simple CGI Phone Book Application
---

{{ page.title }}
================

<p class="meta">10 December 2012, Antakya, Turkey</p>

w00t! Hello all,

This is my first blogging experience, ever. So this post will also mean "Hello, blogging world!".

This will be about a homework given by our Perl lecturer Asst. Prof. Dr. S. Yildirim. He asked us to create a CGI Phonebook script that reads Name, Address and Phone info from a file, And make an interactive script to search or navigate in the phonebook.

In the beginning, I thought I'd read all the info into three different hashes, then I'd navigate/search or do whatever I want in them. While I was implementing, something weird has occured. My hashes had anonymous hashes as keys, instead of the integer "ID" value I read from the text file earlier. In order to catch up with the deadline, I gave up with that hashes stuff, and I decided to just read the file again when I'm searching or listing or whatever I'm doing.

Feel free to take a look at the [source](https://github.com/seckin92/cgi-phonebook).

That’s all for now. See you.
