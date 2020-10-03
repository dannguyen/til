---
title: |
    How easy it is to set up a repo's default branch as "main" instead of "master"
date:   2020-10-02 20:35:00 -0500
categories:
    - github
---

    
Earlier today I created this blog's repo at [dannguyen/til](https://github.com/dannguyen/til) and didn't notice anything different in the copy-paste command-line instructions for initializing and doing a first push to Github:

    
        # …or create a new repository on the command line

        echo "# til" >> README.md
        git init
        git add README.md
        git commit -m "first commit"
        git remote add origin git@github.com:dannguyen/til.git
        git push -u origin master


But I created a new repo just 10 minutes ago and noticed a new `git branch` command that force-moves (i.e. `--force --move`) the `master` branch into `main`:

        echo "# csvmedkit" >> README.md
        git init
        git add README.md
        git commit -m "first commit"
        git branch -M main
        git remote add origin git@github.com:dannguyen/csvmedkit.git
        git push -u origin main

And it just works:

<img src="{{'/files/images/github-main-branch.png' | relative_url }}" alt="github-main-branch.png">

Seems great to me. Besides the ugly historical connotations of "master", it also just didn't feel like an accurate nor concise descriptor of the branch meant to be a "default". And "main" is fewer characters to type – seems like a win all around. 

Read Github's lengthy reasoning and reflection here: [Renaming the default branch from master](https://github.com/github/renaming) 


### Addendum: changing this repo's default branch from master to main

Just for the fun of it, I wanted to see how easy/hard it'd be to retroactively change the default branch from `master` » `main` for my TIL blog repo. 

First, delete/rename master to main locally. Then push `main` to the `origin` remote:

```sh
$ git branch -M master main
$ git push -u origin main
```

However, as far as I can tell, there was no way for me to get past Github's refusal to force-delete `master`...at least via the command line:

```sh
$ git push origin -fd master
To github.com:dannguyen/til.git
 ! [remote rejected] master (refusing to delete the current branch: refs/heads/master)
error: failed to push some refs to 'git@github.com:dannguyen/til.git'
```

Turns out I had to the `settings/branches` page of my repo and manually set `main` to be the default branch:

<img src="{{'files/images/github-switch-main-default.png' | relative_url}}" alt="github-switch-main-default.png">

And then my CLI `push` command was good to go:

```sh
$ git push origin -fd master
To github.com:dannguyen/til.git
 - [deleted]         master
```
