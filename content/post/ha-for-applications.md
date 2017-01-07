+++
title = "Deploying HA Applications - Introduction"
date = "2017-01-02T00:02:32Z"
tags = ["HA", "Architecture"]
series = "HA Applications"
draft = true
+++

When we talk about HA, we are offering a guarantee that our service has
some operational continuity. Often this is expressed as a percentage
of given period of time for which the service must be "up".

## Example

If our API must guarantee 99.99% (four 9s) "uptime" per year, we could use that
to calculate how much "downtime" we are allowed before we miss our SLA 
(it's not unusual for the business to be required to compensate users for a missed SLA).

~~~
Required Uptime (%):      99.99%
Allowed Downtime (mins):  365 * 24 * 60 * 0.0001 = 52.56
~~~

This means we can have only 1 hour of downtime per year, or just under 5 minutes 
per month.

## What can cause Downtime?

Imagine a simple static web site, hosted on a single machine. 
What sort of failures could prevent users accessing this site?

* DNS lookup fails to resolve
* Network issue between user and host machine
* Web server misconfiguration
* Application / Software updates or server restarts
* Application failure, E.G. page is missing (404), or application error (500)

The root cause of these issues is not always something within your direct control, 
for example a network fault within you co-located hosting, or cloud provider isn't
something you can fix, but it is something you should expect and can prepare for.

Other problems, like 


Some of these failures can be mitigated by reducing Single Points Of Failure (SPOF) and
some can be countered by implementing organizational processes 
(E.g. testing, in the case of the 404).


### Removing SPOF


...............

Well first of all there is the obvious problem of defining what our application
looks like when it's "down". There are a multitude of things that could go wrong
*without* the application actually being completely down. E.g.:

* Some percentage of users get 500 errors, while others do not
* The application doesn't work for users in the US, but UK is fine
* I can view data within the service, but I can't update it
* A newly released feature doesn't work as expected


> Why does it matter so much how we decide when our app is broken? Well, firstly
we need some metrics with which to measure the "uptime", and secondly we are
definitely going to need some automated monitoring if we want to hit that four 9s
goal!

So now we have started to consider what a broken application might look like
we should think about what kinds of things could cause these issues.

* Server Failure
* Downtime during deployment/rollback
* Server maintenance



5 minutes doesn't give us a lot of time to work out where our problem is if something
goes wrong, and it also doesn't give us time to roll back failed deployments