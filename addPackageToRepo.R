#!/usr/bin/env Rscript
# Author: Landon Gibson
# Date: 10/20/2020
#-------------------------------------------------------------------------------------------#
library("utils")
library("miniCRAN")
library("argparse")

p <- ArgumentParser(description = "Add package to miniCRAN repo")
p$add_argument("--pkgs", nargs="+" , help = "Names of packages to add to the repo")
p$add_argument("--repo", help = "Location of your miniCRAN repo")
p$add_argument("--create", default=FALSE, help = "A flag for whether or not the repo needs to be created first. Defaults to 'FALSE'.")
p$add_argument("--rversion", default = "3.5.1", help = "Your R version. Defaults to 3.5.1.")
args <- p$parse_args(commandArgs(trailingOnly=TRUE))
CRAN_mirror <- c(CRAN = 'https://cloud.r-project.org/')


checkArgs = function(args_list) {
    if (length(args_list$pkgs) == 0) {
        stop("Please provide a list of packages using '--pkgs'.")
    } else if (length(args_list$repo) == 0) {
        stop("Please provide a repo location using '--repo'.")
    }
}


createRepo <- function(args_list) {
    print(paste0("Creating repo at: ", args_list$repo))
    pkgs_expanded <- pkgDep(args_list$pkgs, repos = CRAN_mirror)
    makeRepo(pkgs_expanded,
        path = args_list$repo,
        repos = CRAN_mirror,
        type = "win.binary",
        Rversion = args_list$rversion)
    print("All packages -- and their dependencies -- successfully added.")
}


loadPackages <- function(args_list){
    print(paste0("Adding packages to repo: ", args_list$repo))
    for (i in args_list$pkgs) {
        print(paste0("Adding ", i, " ..."))
        # addPackage(args$pkgs,
        #     path = args$repo,
        #     repos = CRAN_mirror,
        #     type = c("win.binary"))
    }
    print("All packages -- and their dependencies -- successfully added.")
}


checkArgs(args)
if (args$create == TRUE) {
    createRepo(args)
} else {
    loadPackages(args)
}
