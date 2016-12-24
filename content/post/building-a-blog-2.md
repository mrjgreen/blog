+++
title = "Building a Blog - Part 2"
date = "2016-12-24T00:02:31Z"
tags = ["Blog", "Tools", "Architecture"]
series = "Building a Blog"
+++

Last time, we discussed setting up a blog using [Hugo](https://gohugo.io), a static site generator.

Today, I'm going to add to the project with some terraform configuration and a simple
build and deploy process.

> TL;DR - I added terraform files in the "resources" folder to create an S3 bucket 
and a Makefile with a few canned commands for deploying.