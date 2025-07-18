---
title: "page bundle"
date: 2022-11-22T22:12:51+08:00
draft: true
tags: ["Page Resources","page bundle"]
showToc: true
TocOpen: true
draft: false
comments: false
description: "Desc Text."
canonicalURL: "https://canonical.url/to/page"
UseHugoToc: false
ShowCodeCopyButtons: true
cover:
    image: "<image path/url>" # image path/url
---

#### [Hugo Page Resource](https://gohugo.io/content-management/image-processing/)这段内容来自hugo官方文档

## Image Resources 

To process an image, you must access the image as either a page resource or a global resource.

### Page Resources 

A page resource is a file within a [page bundle](https://gohugo.io/content-management/page-bundles/). A page bundle is a directory with an `index.md` or `_index.md` file at its root.

```text
content/
└── posts/
    └── post-1/           <-- page bundle
        ├── index.md
        └── sunset.jpg    <-- page resource
```

### Global Resources 

A global resource is a file:

- Within the `assets` directory, or
- Within any directory [mounted](https://gohugo.io/hugo-modules/configuration/#module-config-mounts) to the `assets` directory, or
- Located on a remote server accessible via `http` or `https`

```text
assets/
└── images/
    └── sunset.jpg    <-- global resource
```

To access a local image as a global resource:

```go-html-template
{{ $image := resources.Get "images/sunset.jpg" }}
```

To access a remote image as a global resource:
