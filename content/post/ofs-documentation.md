+++
tags = ["Organisation", "Architecture"]
date = "2017-01-07T14:33:46Z"
title = "Internal Documentation"
series = "Organising for Success"
draft = true

+++

It's everyone's least favourite task and universally accepted as a complete waste of time.

You write something down in the morning and by lunch some inconsiderate developer has deployed 
a change that makes your 5 page PDF with attached flow diagram completely obsolete.

Yep, that does sound like a waste of time.
<!--more-->
In fact it's no big revelation to go a step further and say that
this kind of documentation is down right harmful. We know how difficult it is to get our heads
round a project, without being misled by dodgey diagrams. It can also prevent teams
from wanting to improve applications ("If I change this, then I'll have to edit those awful docs!").
 
## Avoiding Documentation

Where possible, we should do our best to avoid writing documentation.
This might seem like a cop-out, but it's not as easy as just "not doing it". We still have to
provide teams with the information they need to run, develop or interact with our systems. 

So how can we avoid it?

### Application Readme

Okay, so this is sort of documentation. But it's simple, easy to find, easy to write and every
git repository should have one. Below are a few suggestions on what to put in your readme:

* What is this?       (Synopsis)
* Why do I need this? (Motivation)
* How do I use it?    (Example)
* How do I run it locally?    (Installation)
* How do I test it?           (Testing)
* Who's responsible for this? (Contributors)
* Where can I find out more?  (Resources)

### Automation

Reducing the number of steps a team member has to take to complete a task reduces the amount of documentation 
you need to write to support it.

If you have a section in your readme for "Installation" and there are 7 commands to run, you should consider 
condensing that into a single command.

A useful thing to do is to include a `Makefile` in your application. 
[Make](https://www.gnu.org/software/make/) is a tool available by default on most unix platforms. It's capable
of managing complex build tasks, but it's also useful for running our simple commands.

Let's say your readme suggests the following build process for a PHP application:

~~~
composer install --dev           # Install deps

php install_db.php               # Create the database

php generate_fixtures.php        # Create test data

php -S localhost:8080 server.php # Run a local dev server
~~~

You could instead create a `Makefile` in your project folder containing the following:

~~~
run:
	composer install --dev
	php install_db.php
	php generate_fixtures.php
	php -S localhost:8080 server.php
~~~

Now your readme need only ask the developer to run one command to spin up a local development environment.

    make run

So much cleaner!

### Consistency

This leads on nicely from the point above. The idea is that teams should be able to work on 
any project without needing to re-learn how to build it or how to get its tests to run. Importantly,
you don't have to document the setup for every application individually.

Github have a requirement that their applications support a common build pattern, which they have
captured in their "[Scripts to Rule Them All](https://github.com/github/scripts-to-rule-them-all)"
project.

While this is one way to do it, we can keep things simple and just extend our `Makefile`. 
By requiring all our project Makefiles to support a few common targets, we will have a consistent pattern.

    make build   # Pull and build all project dependencies
    make run     # Run the project locally (E.g. start a local server)
    make test    # Run the application tests
    make deploy  # Deploy the app to our server (E.g. SCP, Docker, AWS)

A file for a PHP application may look like this:

~~~
build:
	composer install --dev
	php install_db.php
	php generate_fixtures.php

run:
	php -S localhost:8080 server.php

test:
	vendor/bin/phpunit --coverage-html ./coverage ./tests

deploy:
	scp -r dist/ deploy@example.com:/data/www/app/
~~~

Without this file, each of these tasks would require documentation and when the process changes the chances
are that your documentation would fall out of step. Now, you can freely change your processes and your makefile
will prevent the need to change your docs!

### Open Source

I won't speculate as to the psychology behind it, but for whatever reason we can't seem to help ourselves when it 
comes to re-inventing the wheel and building custom solutions to problems the community has solved 100 times already.

> "Yeah, we built our own message queue because.... blah blah blah"

Just stop it. Put the keyboard down and go home.

Forfeiting the use of community supported, open source solutions means that you are going to have to write documentation
to explain how to install, integrate and operate your custom solution. Or as is more often the case, don't write any
documentation at all and leave it for your colleagues to figure out how it works for themselves.

## When You Can't Avoid Documentation

There are scenarios where documentation *is* appropriate and should be encouraged.

### Make it Easy and Consistent

Don't have people passing around word documents or PDFs by email. Find a decent cloud documentation 
platform like [confluence](https://www.atlassian.com/software/confluence) and take some time to set up the 
right spaces and hierarchies for your organisation.

Creating templates for different types of documents will maintain consistency and save time.

### Make it Clear What Documentation is Expected

Be explicit about what type of documents you expect to be present and hold team members accountable for making sure it's
completed.

Some ideas for things you may wish to spend time documenting:

##### High-level Architectural Diagrams

The integration points between systems can be hard to map. Even harder is finding a responsible 
person to keep them up-to-date. If you have a "Chief-Architect" or similar position, then this may be an ideal
task for them. It requires communication and collaboration with every team in your organisation.

Avoiding unnecessary detail here is important, so this could be nothing more than a few labelled boxes with 
lines between them. Adding links to code repositories will allow teams to drill in for more information.

##### Proposals / RFCs

Initiatives that will affect other teams or the whole company will most likely need to be discussed with representatives
from those teams. Writing down your proposal will help to clarify your own thoughts, while allowing people to consider
your ideas ahead of the discussion and share any outcomes with their team.

##### Organisational Policies (E.g. App Security, Data Retention)

In my opinion this is probably the most important thing to capture in writing. Lots of organisations have "unspoken" 
policies and best practices, but without a clear document to reference, these practices are likely to mutate and 
meander over time. Trying new techniques and developing ideas is an absolute necessity to keep ahead of competition, 
but too much unchecked variation can cause serious problems.

##### Meeting Agendas, Notes and Action Points

Writing down topics for discussion ahead of meetings can avoid those awful meandering sessions where the point of the
meeting is lost. Formalising action points is a great way to ensure the time spent in meetings isn't wasted.

##### Incident Reports



##### Complex Investigations


