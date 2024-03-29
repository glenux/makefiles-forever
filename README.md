<!--
# SPDX-License-Identifier: LGPL-3.0-or-later
#
# SPDX-FileCopyrightText: 2023 Glenn Y. Rolland <glenux@glenux.net>
# Copyright © 2023 Glenn Y. Rolland <glenux@glenux.net>
-->

[![Build Status](https://cicd.apps.glenux.net/api/badges/glenux/makefiles-forever/status.svg)](https://cicd.apps.glenux.net/glenux/makefiles-forever)
![License LGPL3.0-or-later](https://img.shields.io/badge/license-LGPL3.0--or--later-blue.svg)
[![Donate on patreon](https://img.shields.io/badge/patreon-donate-orange.svg)](https://patreon.com/glenux)

> :information_source: This project is available on our self-hosted server and
> on CodeBerg and GitHub as mirrors. For the latest updates and comprehensive
> version of our project, please visit our primary repository at:
> <https://code.apps.glenux.net/glenux/makefiles-forever>. 

# Makefiles Forever

A drop-in collection of makefiles libraries for your projects

## Description

* plantuml.mk — Automate the building [plantuml](https://plantuml.com/) diagrams.
* graphviz.mk — Streamline the creation of [graphviz](https://graphviz.org/) graph diagrams.
* mocodo.mk — Facilitate the development of [mocodo](http://mocodo.wingi.net/) entity-relation and logical diagrams.
* mypaint.mk - Automate the conversion of [mypaint](https://mypaint.app/) openraster images to usual image formats.

## Usage

### Adding to your project

To include 'Makefiles Forever' in your project, add this repository as a GIT
submodule:

```shell-session
$ git submodule add https://github.com/glenux/makefiles-forever .makefiles
```

### Configuring your makefiles

In your project's makefile, include the necessary modules. __The `include` instructions must be located
after your existing targets__.

```makefile
# [...variable definitions...]

# Include as many Makefiles Forever features as your want
include .makefiles/plantuml.mk
include .makefiles/mocodo.mk
# [...include as many modules as you want...]

# [...targets definitions...]
```

Declare API variables (ex: `*_SRC_DIR`, `*_DEST_DIR`) for each module

```makefile
# PlantUML Configuration
PLANTUML_SRC_DIR=/path/to/plantuml/files
PLANTUML_DEST_DIR=/path/to/output/directory

# Mocodo Configuration
MOCODO_SRC_DIR=/path/to/mocodo/files
MOCODO_DEST_DIR=/path/to/output/directory

# [...you the external variables of the modules you included...]

# [ ... etc ...]
```

Use pre-defined targets in your build process, as dependencies of your existing
targets:

```makefile

build: plantuml-build mocodo-build graphviz-build

clean: plantuml-clean mocodo-clean graphviz-clean
```

Feature files usually define more targets than just build and clean, and you
can use those too!


## Best practices used in our .mk modules

* Parallel Execution: We ensure targets are available from the root makefile and avoid descending into subdirectories for parallel execution.
* Modular Design: We keep our makefiles modular for easy maintenance and scalability.
* Documentation: We comment our makefiles for clarity and ease of use by others.

## Contributing

Contributions are what make the open-source community such an amazing place to
learn, inspire, and create. Any contributions you make are **greatly
appreciated**.

## Troubleshooting and Support

If you encounter any issues or need support, please open an issue in 
[the project's issue tracker](https://code.apps.glenux.net/glenux/makefiles-forever/issues). 
We strive to be responsive and helpful.

## License

Distributed under the LGPL-3.0-or-later License. See `LICENSE` file for more
information.

## Acknowledgments

* A special thanks to all contributors and users of this project for their
  valuable feedback and support.


