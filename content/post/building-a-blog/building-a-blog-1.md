+++
title = "Building a Blog - Part 1"
date = "2016-12-20T21:02:31Z"
tags = ["Blog", "Tools", "Architecture"]
series = "Building a Blog"
+++

For now the content can wait - first item on the list: **choose a blogging platform** :)

<!--more-->

> TL;DR - I settled on [Hugo](https://gohugo.io), a static site generator which
allows me to keep the site in version control on github, and deploy to an S3 bucket
managed via terraform.

## Requirements

Before I started looking at solutions, I wanted to write down some simple requirements
so I'd know when I found the right one.

#### Easy Setup

I wanted to get writing straight away. I didn't want to have to wade through pages of documentation,
or spend 4 hours working out which database fixtures to apply.

#### Low maintenance

I spend my working days designing and building robust, HA platforms with complex deployment
pipelines, detailed monitoring/alerting systems and comprehensive back-up routines.

I didn't want this blog to be another maintenance task to add to my list.

#### Version Controlled

Everything should be in version control; not just the code, but the infrastructure and content too.

#### Markdown Support

I'd like to be able to write using markdown, for a few reasons:

1. it fast and flexible
1. allows me to work offline
1. content is portable

#### Robust, Scalable and "Performant"

While it's unlikely that this blog is going to see any real volume of traffic, it is going to be
a public representation of my work and I'd like it to have solid up-time, with low cost.
This means it has to run efficiently on a platform that can scale up if traffic demands it.


## Blogging Platforms I Considered

### Wordpress

Just kidding.

### Grav CMS

**Website:** https://getgrav.org/

Grav is a "flat file CMS" written in PHP. I downloaded the Grav system with the admin plugin
and ran it quickly using PHP's builtin web server:

~~~bash
curl -fsSL "https://github.com/getgrav/grav/releases/download/1.1.11/grav-admin.zip" > grav-admin.zip
unzip grav-admin.zip
cd grav-admin
php -S localhost:8888 system/router.php
~~~

I really like Grav. The themes and the admin system look great and are very easy to use.
It runs out of the box without any initial configuration and is easy to customise with
loads of nice themes available.

The system itself seems a bit bulky and complex and diving into the application further,
I found lots of nested YAML files for advanced configuration. Despite not having a database,
there seems to be a lot of moving parts, and it has a deep, complex caching layer, which is built up
at runtime.

It's clear that this is a very capable system and will offer stacks of functionality, over and
above a blogging platform.

### Hugo

**Website:** https://gohugo.io

Hugo is a "site generation tool" written in Go. It's intended to be similar to Jekyll.

As a site generation tool, it operates on a directory of flat files, and uses config
files to produce a rich, themed, static HTML website that can be deployed directly.

It's a single command to install, easy to configure and blisteringly
quick at rendering content. It comes with a built in tool for rendering and displaying
your content locally while you write. It also supports [themes](http://themes.gohugo.io/),
and happily lots of the Grav themes have been ported for Hugo.

Install on MacOS (for other systems just [download the correct release from here](https://github.com/spf13/hugo/releases)):

    brew install hugo

Create a new site skeleton:

    hugo new site my-new-site
    cd my-new-site

Choose a theme from http://themes.gohugo.io/ and install. E.G.:

    git clone https://github.com/spf13/hyde.git themes/hyde
    echo 'theme = "hyde"' >> config.toml

Create your first post:

    hugo new post/hello.md

Run the local server (and show draft posts with -D):

    hugo server -D

You can now view your first post by pointing your browser at `http://localhost:1313`

Add some "lipsum" content to your post?

    curl -fsSL "https://baconipsum.com/api/?type=meat-and-filler&paras=2&format=text" >> content/post/hello.md

With your browser still open, you should see the content magically update
(It's not magic, it's websockets).


## Next Time

Next time, we will use terraform to configure an S3 bucket to host the static site
generated from this post.
