+++
tags = ["Organisation", "Architecture"]
date = "2017-01-22T14:33:46Z"
title = "Version Control"
series = "Organising for Success"
draft = true

+++


It's been a long time since I've found myself selling the benefits of keeping application code in 
version control. This is good news, but we're not out of the woods yet.

Too often we need to recreate an application stack or rebuild a failed system and it's a weeks work
trying to figure out what packages to install, or what the correct configuration values are.

Imagine if we could start up a QA environment with a single command! Imagine if failed systems could be
rebuild at the click of a button!

I'd like to use this post to investigate some techniques we can use to make sure that every part of our
platform can be committed to version control along with our application.

## Automation

A prerequisite of being able to commit your platform to version control, is capturing every element
in a static file; config files and bootstrap scripts are a simple way of automating a platform set-up,
but we will discuss some other appropriate alternatives for each part of the system.

### Infrastructure (Servers, DNS Records, Cloud Platform Resources)

(terraform)

### Server Configuration

(Chef / Ansible)

I would recommend wrapping as many of the specifics of your application up in a,
 docker container along with your application.

### Application Stack and Required Packages

(docker)

### Jenkins Pipeline


## Other Considerations

### Environment Variables and Secrets
