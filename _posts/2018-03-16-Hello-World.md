---
layout: post
title: First post!
description: >
  Bloggin' in the 21st century using jekyll
tags: [blog]
---

Welcome! This is my attempt at a new blog, and a proper personal website. Scroll on down to the [about page](https://photocyte.github.io/about/) to learn more about me. 

I think I started a blog way back in 2013 or so, with the whole effort of buying a domain + server space and installing all the software, but it turned out that I only posted a few posts & the blog lapsed to the sands of time after I forgot to pay the server fee...  Hopefully, this blog will be more robust and more frequently updated 🙂. Certainly this method (using jekyll and hosting on github), seems much more straightforward, and cheaper!

-Tim

P.S. I've also decided that I will use this page to keep track of the software that I'm using to edit this blog.

* The ["hydejack"](https://github.com/qwtel/hydejack) template/project I forked to make this blog
* Markdown editing: [MacDown](http://macdown.uranusjr.com)
* Syncing between Github & local copy: git command line
* Serving a local copy: "bundle exec jekyll serve" while in local copy directory. *note: while hosting jekyll will automatically update when you save a file. Nice!*
* The jekyll posts have to be named with dashes '-' not underscores '_'
* The "_drafts" folder is a great option to store posts in progress, and this jekyll command will serve it properly to a public IP: 
>bundle exec jekyll serve -H 192.168.0.13 -D --future --unpublished
* [ImageMagick](https://imagemagick.org) is a great way to quickly resize & reencode images. I installed it with macports, and used this [bash script] to resize things (misc_files/post1/resize.sh)
* If you need to encrypt a file in a non obtrusive way (like for example, my CV) zip command line works pretty well:
>zip -ej FILE_NAME.zip FILENAME
