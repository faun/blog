---
title: Cross-compiling Golang Applications for Synology 1513+
date: 2015-02-17 16:10 PST
tags: golang, compiler, go, programming, synology, nas
---

To compile a Golang application project for Synology NAS architecture, first let's take a look at the list of Synology boxes by [architecture](http://forum.synology.com/wiki/index.php/What_kind_of_CPU_does_my_NAS_have). Looking at that chart, we can determine that the Synology 1513+ is running on a `x86 cedarview` processor and has a listed architecture of `x86_64`. Ok, so let's tell Go to compile for `x86_64` on Mac OS with Go installed via Homebrew:

```
cd $(brew --prefix go)/libexec/src
GOOS=linux GOARCH=amd64 CGO_ENABLED=0 ./make.bash --no-clean
```

Now `cd` in to your project directory and run:

```
GOOS=linux GOARCH=amd64 go build
```

That's it. You should have a linux x86_64 compiled binary in your current working directory.

HFGL!
