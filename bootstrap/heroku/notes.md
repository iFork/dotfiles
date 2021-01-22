
Heroku Usage
=============

`heroku help <command>` 

# Basic steps

```bash
heroku login
heroku create
	# adds (additional) git remote named heroku to your git repo
# add Procfile
git push heroku master
	# push to the remote named heroku
heroku ps:scale web=1
	# Ensuring that at least one instance of the app is running:
heroku open
	# visit app url
heroku logs --tail
	# view logs
```

# Pushing to heroku

**NB** If you are deploying from a git repository where your code is not on the master branch you will need to run `git push heroku HEAD:master`. If you have already done a push to heroku, you may need to run `git push heroku HEAD:master --force`.

> `git push <remote> <refspec>` where resfspec is of format 
> `<source object/branch>:<destination ref/branch>`
> From git help push:
> The <src> is often the name of the branch you would want to push, but it can be any arbitrary "SHA-1 expression", such as master~4 or HEAD (see gitrevisions(7)).
> The <dst> tells which ref on the remote side is updated with this push. Arbitrary expressions cannot be used here, an actual ref must be named.
> If git push [<repository>] without any <refspec> argument is set to update some ref at the destination with <src> with remote.<repository>.push configuration variable, :<dst> part can be omitted — such a push will update a ref that <src> normally updates without any <refspec> on the command line. Otherwise, missing :<dst> means to update the same ref as the <src>.

## Using git subtree

### Pushing subtree as its own project

[How can I deploy/push only a subdirectory of my git repo to Heroku? - Stack Overflow](https://stackoverflow.com/questions/7539382/how-can-i-deploy-push-only-a-subdirectory-of-my-git-repo-to-heroku)

Pushing part of a git repo into another git repo as a root dir.

```
git subtree push --prefix <subtree's dir> <remote> (<remote branch> | <refspec>)
# e.g. git subtree push --prefix output heroku master
```

Or first creating subtree using `split` command and putting it in its own branch:
my example

```
$ git subtree split --prefix part3/practice --annotate='(split) ' -b practice-notes-deploy
Created branch 'practice-notes-deploy'

$ git push heroku practice-notes-deploy:master
```

or with rejoin

```
$ git subtree split -P part3/practice -b practice-notes-deploy2 --rejoin --annotate='(split) '
Merge made by the 'ours' strategy.
See "git help gc" for manual housekeeping.
warning: The last gc run reported the following. Please correct the root cause
and remove .git/gc.log.

Created branch 'practice-notes-deploy2'
```

But to achieve effect of <refspect> of the form <source branch>:<destination branch> use instead:

> if you want to push a specific tag or branch in combination with subtree? Like 'git push heroku yourbranch:master'?
> In this case you cannot use the subtree push shortcut and have to chain commands youself. For example: 

```bash
git push heroku `git subtree split --prefix web yourbranch`:master
```

> https://stackoverflow.com/a/34871620/2916845
> If you want to push a subtree of a branch to become your master, you can use something like:

```bash
git push --force heroku `git subtree split --prefix web HEAD`:master
```

> I successfully pushed the output folder that was only present on my develop branch to the heroku master branch without the need of specifying develop:master, so apparently it pushes to the target branch you specify *from your currently checked out branch*.

> https://stackoverflow.com/questions/7539382/how-can-i-deploy-push-only-a-subdirectory-of-my-git-repo-to-heroku

### Example from git-subtree manual

[manual](https://raw.githubusercontent.com/git/git/master/contrib/subtree/git-subtree.txt), git help subtree

```bash
git subtree split --prefix=gitweb --annotate='(split) ' \
  	0a8f4f0^.. --onto=1130ef3 --rejoin \
  	--branch gitweb-latest
gitk gitweb-latest
git push git@github.com:whatever/gitweb.git gitweb-latest:master
```

If gitweb had originally been merged using 'git subtree add' (or a previous split had already been done with --rejoin specified) then you can do all your splits without having to remember any weird commit ids:

```bash
git subtree split --prefix=gitweb --annotate='(split) ' --rejoin \
	--branch gitweb-latest2
```

And you can merge changes back in from the upstream project just as easily:

```bash
git subtree pull --prefix=gitweb \
	git@github.com:whatever/gitweb.git master
```

### Updating upstream subtree and merging downstream

```
# on <source branch>
# branch from which subtree is to be split into a new 'deploy' branch

git subtree split -P part3/practice -b deploy --annotate="(split) "

	# commit chnages to the prefix directory on <source branch>
```


merge upstream changes when upstream is a 'super-repo'
(not a dedicated repo of our subtree)
split in-place 'super-repo' with the same 'annotation'
to create source matching our target subtree


```
# when in a 'super-repo' / on a 'super-branch'
git subtree merge -P <dir prefix> \
	`git subtree split -P <same dir prefix> <source branch/commit> \
	--annotate="(split) "`
```

```
git checkout <branch of subtree created by subtree split command>
# when on a (dedicated) branch of the subtree
git merge \
	`git subtree split -P part3/practice --annotate='(split) ' practice `

```

In this case no prior --rejoin (in prior split command) was required.
When not creating split in-line but merging just a source branch, whole source branch is merged, not just the files from prefix dir.
This latter (merging whole source branch) happens only when --rejoin was specified in the initial split (and therfore source branch remembers about a split). Otherwise merge is refused due to 'unrelated histories' and subtree merge command rejects 'allow-unrelated-histories' flag. 

### Other Articles
[The power of Git subtree - Atlassian Developer Blog](https://blog.developer.atlassian.com/the-power-of-git-subtree/)

# Build and Deploy Script (move out?)

- [] move out to npm script notes file 
 - [] will it belong to 'bootstrap notes' or into a joplin/snippets/npm?


```
    "start": "node index.js",
    "dev": "nodemon index.js",
    "test": "echo \"Error: no test specified\" && exit 1",
    
	"build:ui": "echo removing build && rm -rf build && echo cd to frontend && cd ../../part2/practice && pwd && echo build frontend && npm run build --prod && echo copy build back && cp -r build $OLDPWD",
    
	"deploy": "git checkout practice-notes-deploy && echo cd to top level of the working tree for the git subtree merge && cd ../../ && git merge `git subtree split -P part3/practice practice --annotate='(split) '` && git push heroku practice-notes-deploy:master",
    
	"deploy:full": "git checkout practice && npm run build:ui && echo commit build to backend && git add build && echo commit if there is a change && (git diff-index --quiet --cached HEAD || git commit -m UI-build) && echo deploying...  && npm run deploy",

	"logs:prod": "heroku logs -t"
```



Note that this code uses `&` instead of `&&`. The former means to run the script in the background, meaning that they execute in parallel and their output is shuffled together. The latter would mean to execute the _next_ command only if the _current_ command exits without an error code.



# git branches instead of subfolders (move out?)

- [] move out to git notes ?
 - [] will it belong to bootstrap notes or joplin/git/Some (stared) usage note ?

You could also use git branches instead of subfolders. If you have git 1.7.2 or newer, you can simply do git checkout --orphan android to create a branch that is disconnected from your master branch (assumed here to be the web folder). Once you have checked out the orphan branch, run git rm -rf . to remove existing files before copying in your android-specific files to the now empty root directory.

# Issues of Heroku as a git, Deploy script for heroku
[credit](https://stackoverflow.com/a/35010691/2916845)
> **just because Heroku uses a git repository as a deployment mechanism, you should not treat it as a git repository**

> it could have been rsync just as well, they went for git, don't get distracted because of this
> 
> if you do so, you open up yourself to all kinds of hurt. All of the aforementioned solutions fail miserably somewhere:
> 
> it requires something to be done every time, or periodically, or unexpected things happen (pushing submodules, syncing subtrees, ...)
> if you use an engine for example to modularize your code, Bundler will eat you alive, it's impossible to describe the amount of frustration I've had with that project during the quest to find a good solution for this
> you try to add the engine as git repo link + bundle deploy - fail, you need to bundle update every time
> you try to add the engine as a :path + bundle deploy - fail, the dev team considers :path option as "you're not using Bundler with this gem option" so it'll not bundle for production
> also, every refresh of the engine wants to update your rails stack 
> only solution I've found is to use the engine as a /vendor symlink in development, and actually copy the files for production
> **The solution**
> The app in question has 4 projects in git root:
> 
> - api - depending on the profile will run on 2 different heroku hosts - upload and api
> - web - the website
> - web-old - the old website, still in migration
> - common - the common components extracted in an engine
> All of the projects have a vendor/common symlink looking at the root of the common engine. When compiling source code for deployment to heroku we need to remove the symlink and rsync it's code to physically be in the vendor folder of each separate host.
> 
> accepts a list of hostnames as arguments
> runs a git push in your development repo and then runs a clean git pull in a separate folder, making sure no dirty (uncommited) changes are pushed to the hosts automatically
> deploys the hosts in parallel - every heroku git repo is pulled, new code is rsynced into the right places, commited with basic push information in the git commit comment,
> in the end, we send a ping with curl to tell the hobby hosts to wake up and tail the logs to see if all went wine
> plays nice with jenkins too :D (automatic code push to test servers after successful tests)
> Works very very nice in the wild with minimal (no?) problems 6 months now
> 
> Here's the script https://gist.github.com/bbozo/fafa2bbbf8c7b12d923f




# Procfile

Use a Procfile, a text file in the root directory of your application, to explicitly declare what command should be executed to start your app.

## Example for node application:

```
web: node index.js
```

This declares a single process type, `web`, and the command needed to run it. The name web is important here. It declares that this process type will be attached to the HTTP routing stack.

# Processes and dynos

```bash
heroku ps
	# check how many dynos are running 
heroku ps:scale web=1
	# Ensuring that at least one instance of the app is running:

heroku ps:restart web.1
	# restart process web.1
```

> For abuse prevention, scaling a non-free application to more than one dyno requires account verification.


# [Managing config vars](https://devcenter.heroku.com/articles/config-vars#managing-config-vars)

Whenever you set or remove a config var using any method, your app is restarted and a new [release](https://devcenter.heroku.com/articles/releases) is created.

Config var values are persistent–they remain in place across deploys and app restarts. Unless you need to change a value, you only need to set it once.

## Using the Heroku CLI

The `heroku config` commands of the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) makes it easy to manage your app’s config vars.

View current config var values


```term
heroku config 
GITHUB_USERNAME: joesmith 
OTHER_VAR: production

heroku config:get GITHUB_USERNAME
joesmith
```

Set a config var

```term
heroku config:set GITHUB_USERNAME=joesmith
Adding config vars and restarting myapp... done, v12
GITHUB_USERNAME: joesmith
```

Remove a config var


```
heroku config:unset GITHUB_USERNAME 
Unsetting GITHUB_USERNAME and restarting myapp... done, v13
```

