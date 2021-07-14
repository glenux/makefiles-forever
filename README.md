# Makefiles Forever

A drop-in collection of makefiles libraries for your projects

## Description

* plantuml.makefile — Build [plantuml](https://plantuml.com/) diagrams
* dot.mk — Build [graphviz](https://graphviz.org/) graph diagrams
* mocodo.mk — Build [mocodo](http://mocodo.wingi.net/) entity-relation and logical diagrams

## Usage

* Add this repository as a GIT submodule of your project
  ```
  git submodule add https://github.com/glenux/makefiles-forever .makefiles
  ```
* Include needed features in the end of your makefile
  ```
  # [...]

  -include .makefiles/featureA.mk
  -include .makefiles/featureB.mk  
  ```
## Good practices

* Keep task parallelism in mind
  * Make all targets available from root makefile 
  * Do not descend in subdirectories


