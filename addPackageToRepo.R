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

args <- commandArgs(trailingOnly = TRUE)

if ("--pkgs" %in% args) {

    if ("--repo" %in% args) {
        repo_command_index <- match("--repo",args)
        repo_file_url <- args[repo_command_index + 1]
    } else {
        stop("Please use the --repo argument to provide the path to the repo")
    }


    pkgs_command_index <- match("--pkgs",args)

    if (pkgs_command_index < repo_command_index) {
        pkgsToAdd <- args[(pkgs_command_index+1) : (repo_command_index-1)]
    } else {
        pkgsToAdd <- args[(pkgs_command_index+1) : length(args)]
    }

    print(paste0("Adding packages to repo: ", repo_file_url))
    for (i in pkgsToAdd) {
        print(paste0("Adding ", i, " ..."))
        addPackage(pkgsToAdd,
            path = repo_file_url,
            repos = 'https://cloud.r-project.org/',
            type = c("win.binary"))
    }

    print("All packages -- and their dependencies -- successfully added.")

} else {

    stop("Something went wrong. Make sure to use --pkgs to define which packages
        you would like installed and follow it with --repo.")

}


if ("--help" %in% args) {

    print("Use --pkgs followed by the packages you want to install. And use --repo to define the repo location.")

}



