#!/usr/bin/env bash

# get config
npm config get registry

# set config: 淘宝镜像
npm config set registry https://registry.npm.taobao.org
