#!/usr/bin/env Rscript
# Reference:
#   1. https://cran.r-project.org/web/packages/miniCRAN/vignettes/miniCRAN-introduction.html
#   2. https://docs.microsoft.com/en-us/sql/machine-learning/package-management/create-a-local-package-repository-using-minicran?view=sql-server-ver15
library("miniCRAN")
library("utils")

# Extracting arguments from command and checking actions are properly coded
# At the moment I have only one action, but this can easily be expanded to include
# actions for defining packages and the R version.
args <- commandArgs(trailingOnly = TRUE)

if (action == '--repo') {
    local_repo_path = args[2]
} else {
    print('Please provide a repo location using --repo [directory location]')
    break
}

CRAN_mirror <- c(CRAN = 'https://cloud.r-project.org/')
pkgs_to_install <- c("tidyverse", "odbc", "purr", "tidymodels", "lubridate")

pkgs_expanded <- pkgDep(pkgs_to_install, repos = CRAN_mirror)
makeRepo(pkgs_expanded, path = local_repo_path, repos = CRAN_mirror, type = "win.binary", Rversion = "3.5.1")
