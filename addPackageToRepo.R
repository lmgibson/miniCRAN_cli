#!/usr/bin/env Rscript
# Author: Landon Gibson
# Date: 10/20/2020
#
# Purpose:
#   This script adds packages to an EXISTING miniCRAN repo on the local machine. That means
#   that a miniCRAN repo should have already been configured at a given location. Then this
#   script can be used to add additional packages into the repo.
#
# Commands:
#   --help: gives you information on how to use the script.
#   --pkgs: Tells the script what packages you would like to install. Is used like the
#           following example: script --pkgs pkg1 pkg2 pkg3. Any number of packages can be
#           defined and they will be installed to your repo along with their dependencies
#           and imports
#   --repo: Gives the location of the local miniCRAN repo.
#-------------------------------------------------------------------------------------------#
library("utils")
library("miniCRAN")
library("argparse")

p <- ArgumentParser(description = "Add package to miniCRAN repo")
p$add_argument("--pkgs", nargs="+" , help = "Name of packages to add to the repo")
p$add_argument("--repo", help = "Location of your miniCRAN repo")
args <- p$parse_args(commandArgs(trailingOnly=TRUE))

checkArgs = function(args_list) {
    if (length(args_list$pkgs) == 0) {
        stop("Please provide a list of packages using '--pkgs'.")
    } else if (length(args_list$repo) == 0) {
        stop("Please provide a repo location using '--repo'.")
    }
}

loadPackages <- function(args_list){
    print(paste0("Adding packages to repo: ", args_list$repo))
    for (i in args_list$pkgs) {
        print(paste0("Adding ", i, " ..."))
        addPackage(args$pkgs,
            path = args$repo,
            repos = 'https://cloud.r-project.org/',
            type = c("win.binary"))
    }

    print("All packages -- and their dependencies -- successfully added.")
}

checkArgs(args)
loadPackages(args)
