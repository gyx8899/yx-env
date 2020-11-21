# yx-env
YX-Env: A personal scripts in Node/Shell/Dos for projects

## Node Scripts

##### Node: NVM switch node version

```shell script
nvm use 12.16.1
```

## Git Scripts

##### Shell: Git pull rebase for the parent folder's sub-folder repos
[git-pull-rebase.sh](./git-pull-rebase.sh)

##### Shell: Set git's global user
[git-global-user.sh](./git-global-user.sh)

##### Shell: Set git's local user for the parent folder's sub-folder repos
[git-local-user.sh](./git-local-user.sh)

##### Shell: Set registry with Tao bao
[git-registry-taobao.sh](./git-registry-taobao.sh)

##### Shell: Set remote template (@daybyday/npm-template)
[git-remote-template.sh](./git-remote-template.sh)

##### Shell: git auto commit + push, comment with filenames and change types
[git-push.sh](./git-push.sh)

```metadata json
// Demo script in exam-app
"scripts": {
   "git-push": "cd ../yx-env && git-push.sh exam-app"
}
```

##### Shell: git merge remote repo
[git-merge-remote.sh](./git-merge-remote.sh)

```metadata json
// Demo script in yx-jd
"scripts": {
   "git-merge-remote": "cd ../yx-env && git-merge-remote.sh yx-jd https://github.com/lxk0301/jd_scripts.git"
}
```

## Dos script

##### View port 80's using info
[dos-netstat-80.bat](./dos-netstat-80.bat)
