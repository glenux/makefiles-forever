# Makefiles Forever

A drop-in collection of makefiles libraries for your projects

## Description

* plantuml.makefile — Build [plantuml](https://plantuml.com/) diagrams
* dot.mk — Build [graphviz](https://graphviz.org/) graph diagrams
* mocodo.mk — Build [mocodo](http://mocodo.wingi.net/) entity-relation and logical diagrams

## Usage

Add this repository as a GIT submodule of your project

```shell-session
$ git submodule add https://github.com/glenux/makefiles-forever .makefiles
```

Include needed features in the end of your makefile

```makefile
# [...]

-include .makefiles/featureA.mk
-include .makefiles/featureB.mk  
```

Declare API variables (ex: `*_SRC_DIR`, `*_DEST_DIR`) for each module

```makefile
# Configuration for featureA from Makefiles Forever
FEATUREA_SRC_DIR=/path/to/somewhere
FEATUREA_DEST_DIR=/some/other/path

# Configuration for featureB from Makefiles Forever
FEATUREA_SRC_DIR=/another/path
FEATUREB_DEST_DIR=/a/different/one
```

Use pre-defined targets as dependencies of your targets:

```makefile
build: featureA-build
build: featureB-build

clean: featureA-clean
clean: featureB-clean
```

Feature files usually define more targets than just build and clean, and you
can use those too!


## Good practices for coding .mk files

* Keep task parallelism in mind
  * Make all targets available from root makefile 
  * Do not descend in subdirectories


