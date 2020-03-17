---
title: Why did I set up a Jekyll blog?
date: 2018-06-08 00:00:00 +0000
categories: [Miscellaneous]
tags: [jekyll, blog, quickstart]
seo:
  date_modified: 2020-03-17 00:40:12 +0000
---

I rarely blog, and often lose track of the blogging engines I've set up, and lose my -already rare- blog posts into the void. Therefore, I decided to set up a [Jekyll](https://github.com/mojombo/jekyll) blog, inspired by [Tom Preston-Werner](http://tom.preston-werner.com).

Instead of forking his repository and just editing, I tried to do this from scratch. After a few failed attemps, it was trivial to set the development environment up and start fiddling with the templates.

There's already [a wonderful tutorial](https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/) on this, but for this post's sake, here's what I did so far:

 * Install Ruby
 * Install `bundler` (via running `gem install bundler`)
  * Create a Gemfile and declare `jekyll` as a dependency
 * Install `jekyll` (via running `bundler install`)
 * Run `bundle exec jekyll serve`

At this point, jekyll was already watching my directory structure and files, and automatically rebuilding my site, so all I had to do is make changes, and test them in my browser at `http://localhost:4000`.

Next step will be integrating a comments facility, probably at some point in the following decade!