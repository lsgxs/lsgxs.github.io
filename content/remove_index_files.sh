#!/bin/bash

# 递归查找并删除所有 _index.md 文件
find . -type f -name "_index.md" -exec rm -f {} \;

echo "所有 _index.md 文件已删除"