+++
title = "Node Rage"
date = "2016-12-20T21:02:31Z"
tags = ["React", "Front End", "Node"]
+++

Front end development has changed. Again. Now we’ve got Angular 2. And React. And you can use ES6. And TypeScript. And ES2015. And ES2016. And ES2017. It seems like a lot, but it’s okay, there’s tooling; you can “just install it with npm”

    npm install babel-core babel-loader babel-preset-es2015 babel-preset-react --save

Aaaand 15 minutes later...

![NPM](/images/node-rage/npm-terminal.png)

...I’m still watching this spinning thing, with no idea what the fuck is going on.

Fuck you nodejs. You ruin everything. I’m going to make a coffee while I try to calm my incandescent rage.

I’m back and npm has finally agreed to release the 8 cores it’s been holding hostage for the last 15 minutes while installing the 4 packages I’ve asked for. Now I can start my project! Like Alice, I dive further in this rabbit hole of chaos and “webpack” my single solitary .jsx project file (The webpack config file itself is already the size and complexity of a medium sized application. Note to self: refactor config file). 

    ./node_modules/.bin/webpack

Nope.

    ERROR in Cannot find module 'babel-runtime/helpers/typeof'

Great. Another coffee I think.

Back again. The shaking hasn’t stopped yet, but with caffeine fueled conviction I open google and hunt down my elusive module.

Ahh, some success! Others have had this error, and provided sound advice:

> “Reinstall babel-loader”
>
> *https://github.com/babel/babel-loader/issues/39#issuecomment-78185333*

Oh god no, not another 15 minutes watching that shit spinner! I’ll just read further and make sure this is definitely the cause of my issue...

> “Most likely. npm is really weird most of the time.”
>
> *https://github.com/babel/babel-loader/issues/39#issuecomment-78188663*

Well, with indisputable facts like that...

For good measure, I’ve decided to upgrade my version of node and npm too. Thankfully it’s been a month or so since I’ve been forced to use them, so they’ll be out of date. Probably by about 23 major versions.

After another npm install and yet another coffee, my index file has been webpacked. Whatever that is. Maybe I’ll take a look in the “transpiled” file it built to see if I can spot my few lines of code.

I can’t. 

But what I can spot is 21,788 lines of JavaScript, in a file that’s 731Kb. Are you shitting me? How am I supposed to deliver that to the users? On a fucking memory stick?

Anyway, I opened it in my browser and it worked. Fucking brilliant.


![NPM](/images/node-rage/todo-app-shot.png)


