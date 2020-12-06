#!/usr/bin/env bash

# 解决中文文件在 commit 信息中显示乱码的问题；
git config --global core.quotepath false

# 设置 Git 全局的用户名和邮箱
  # 1. “. [file-name].sh”
. git-global-user.sh

  # 2. “. [file-name].sh”
  # ./source 等价，copy 目标文件内容到当前 shell 中进行执行；
  #source git-global-user.sh

  # 3. 开启新的 shell 进程执行目标文件；
  #sh git-global-user.sh
