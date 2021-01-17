# miniCRAN CLI

## Overview

A simple wrapper of a couple aspects of the miniCRAN R library. The CLI can create a local repo
and it can add packages to an existing local repo. Requires that miniCRAN and argparse R packages are installed.

I built this because my work servers are offline which means I need to build my repository on my own machine and
transfer to the work machine so I can install and manage my libraries.

## Installation

1. Add the "minicran" file to your /usr/local/bin/ folder.
2. Test the command by typing `minicran`
3. If you've successfully installed it then you should receive an error prompting you to provide a list of packages.

## Examples

Example for an already created miniCRAN repo:

`minicran --pkgs tidyverse purrr tidymodels --repo ./repo`

The above example is if your repo is a sub-directory within your current directory.

Example if you don't have a miniCRAN repo:

`minicran --pkgs tidyverse purrr tidymodels --repo ./repo --create TRUE --rversion 4.0.3`

If you want to create a repo then you will need to use the repo argument to specify the location.
In the example above, `./repo` tells the CLI to build the repository in a folder contained within
the current directory labeled 'repo'. Lastly, you'll have to pass in the rversion.
