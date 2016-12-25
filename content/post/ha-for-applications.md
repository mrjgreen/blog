+++
title = "Deploying an HA Application"
date = "2017-01-02T00:02:32Z"
tags = ["HA", "Architecture"]
draft = true
+++

When we talk about HA, we are usually discussing a service which must guarantee
some operational continuity. Often this is expressed as a percentage
of given period of time for which the service must be "up".

## Example

If our API must guarantee 99.99% (four 9s) "uptime" per year, we could use that
to calculate how much "down time" we are allowed before we miss our SLA 
(it's not unusual for the business to be required to compensate users for a missed SLA).

~~~
Required Uptime (%):      99.99%
Allowed Downtime (mins):  365 * 24 * 60 * 0.0001 = 52.56
~~~

This means we can have only 1 hour of downtime per year, or just under 5 minutes 
per month.

## Challenges?

Well first of all there is the obvious problem of defining what our application
looks like when it's "down". There are a multitude of things that could go wrong
*without* the application actually being completely down. E.g.:

* Some percentage of users get 500 errors, while others do not
* The application doesn't work for users in the US, but UK is fine
* I can view data within the service, but I can't update it
* A newly released feature doesn't work as expected
* New DNS lookups aren't resolving correctly

 > TODO - finish defining broken application

So now we have started to consider what a broken application might look like
we should think about what kinds of things could cause these errors.



5 minutes doesn't give us a lot of time to work out where our problem is if something
goes wrong, and it also doesn't give us time to roll back failed deployments