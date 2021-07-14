# Makefiles forever

A collection of makefiles for every imaginable use

## Description

* plantuml.makefile — Build [plantuml](https://plantuml.com/) diagrams
* dot.mk — Build [graphviz](https://graphviz.org/) graph diagrams
* mocodo.mk — Build [mocodo](http://mocodo.wingi.net/) entity-relation and logical diagrams

## Usage

* Add this repository as a GIT submodule of your project
  ```
  git submodule add 
  ```
* Include needed features in your makefile
  ```
  -include path/to/makefiles-forever/feature.mk
  ```
## Good practices

* Keep task parallelism in mind
  * Make all targets available from root makefile 
  * Do not descend in subdirectories


