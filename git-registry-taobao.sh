#!/usr/bin/env bash

# get config
npm config get registry

# set config: 淘宝镜像
npm config set registry https://registry.npm.taobao.org

# default config (can be reset after set with taobao)
#npm config set registry https://registry.npmjs.org
