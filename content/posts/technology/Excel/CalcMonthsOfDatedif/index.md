---
title: "Excel计算两个日期之间的月数"
date: 2024-04-25T17:35:36+08:00
draft: false
# weight: 2
tags: ["first"]
# author: ["Me", "You"] # multiple authors
showToc: true
TocOpen: true
hidemeta: false
comments: false
canonicalURL: "https://canonical.url/to/page"
disableHLJS: true # to disable highlightjs
disableShare: false
hideSummary: false
searchHidden: false
ShowBreadCrumbs: true
ShowPostNavLinks: true
UseHugoToc: false
ShowCodeCopyButtons: true
thumbnail: "images/ExcelFuntion.png"
description: "使用Excel的函数计算两个日期之间的月数，感觉很简单，可是用的函数不对的话，计算会差别很大"
---

#### 使用Excel计算两个日期之间的月数

在单元格中输入开始日期和终止日期，计算这两个日期之间的月数(这里假设开始日期在m2单元格，终止日期在m3单元格)

* 分段式计算月数

  ```
  #两个日期的年份之差+开始日期的年份中的剩余月数+终止日期中的当前月数
  =IF(m2<=m3, (YEAR(m3) - YEAR(m2) - 1) * 12 + (12 - MONTH(m2)) + MONTH(m3), "错误：开始日期必须早于或等于结束日期")
  ```

  

* 合并式计算月数

  ```
  =IF(m2<=m3, (YEAR(m3) - YEAR(m2)) * 12 + MONTH(m3) - MONTH(m2), "错误：开始日期必须早于或等于结束日期")
  ```

  

很早的时候，使用pb写了一个小程序，用来计算两个日前之间的月数，时间长了不记得详细的算法了，这里使用电子表格重新实现，记录备忘。
