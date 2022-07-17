# yx-env

YX-Env: A personal scripts in Node/Shell/Dos for projects

## Node Scripts

### Node: NVM switch node version

```shell script
nvm use 12.16.1
```

### Node: Run es6 file script

```shell script
"node: run js": "node assets/scripts/run-test.js",
```

### Node Run bash

```shell script
# "git:push": "node run-script.js --fileName=git-push.sh",
# node run-script.js --fileName=git-push.sh
# node ./assets/scripts/add-timestamp.js file=. && cd ../yx-env && npm run git:push -- --1=blog
# cd ../yx-env && npm run git:push -- --1=blog --2=clean
```

## Git Scripts

### Shell: Git pull rebase for the parent folder's sub-folder repos

[git-pull-rebase.sh](.assets/shell/git-pull-rebase.sh)

### Shell: Set git's global user

[git-global-user.sh](.assets/shell/git-global-user.sh)

### Shell: Set git's local user for the parent folder's sub-folder repos

[git-local-user.sh](.assets/shell/git-local-user.sh)

### Shell: Set registry with Tao bao

[git-registry-taobao.sh](.assets/shell/git-registry-taobao.sh)

### Shell: Set remote template (@daybyday/npm-template)

[git-remote-template.sh](.assets/shell/git-remote-template.sh)

### Shell: git auto commit + push, comment with filenames and change types

[git-push.sh](.assets/shell/git-push.sh)

```metadata json
"scripts": {
   "git-push": "cd ../yx-env && git-push.sh exam-app"
}
```

### Shell: git merge remote repo

[git-merge-remote.sh](.assets/shell/git-merge-remote.sh)

```metadata json
"scripts": {
   "git-merge-remote": "cd ../yx-env && git-merge-remote.sh yx-jd https://github.com/xxx/xxx.git"
}
```

## Dos script

### View port 80's using info

[dos-netstat-80.bat](.assets/bat/dos-netstat-80.bat)
