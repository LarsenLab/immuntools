#' @name set_proj
#' @title Function to set up a R project
#' @param fd_name path and folder name.
#' @param proj_type project type.
#' working folder/project name of the project
#' @return
#' .Rproj and folder structure of the project
#' @export
#'
#' @import
#' devtools
#' tidyverse
#' purrr
#' usethis
#' rstudioapi
#' @examples
#' \dontrun{
#' set_proj(fd_name= "/Users/newfolder", proj_type = "g")
#' }

set_proj <- function(fd_name, proj_type = "general")
{
  if (missing(fd_name)){
    warning("please enter the project path and speficy the project type")
  } else {
    # step 1: create the main folder, sub-folders, and readme.txt under each folder
    fd_list <- list( "f0" = fd_name,
                     "f1" = paste(fd_name, "data", sep = "/"),
                     "f2" = paste(fd_name, "data/raw", sep = "/"),
                     "f3" = paste(fd_name, "data/proc", sep = "/"),
                     "f4" = paste(fd_name, "output", sep = "/"),
                     "f7" = paste(fd_name, "docs", sep = "/"),
                     "f8" = paste(fd_name, "vignette", sep = "/"))

    map(fd_list, dir.create)
    map(paste(fd_list, "readme.txt", sep = "/"), file.create)

    # step 2: create .Rproj file
    create_project(fd_name, rstudio = rstudioapi::isAvailable(), open = FALSE)
  }

  if (proj_type %in% c("general", "g", "")) {
    fd_from <- paste(path.package("immuntools"),"rmarkdown/templates/report/skeleton/general",sep = "/")
  } else if (proj_type %in% c("sc", "SC", "singlecell", "single_cell")) {
    fd_from <- paste(path.package("immuntools"),"rmarkdown/templates/report/skeleton/sc",sep = "/")
  } else if (proj_type %in% c("flow", "Flow")) {
    fd_from <- paste(path.package("immuntools"),"rmarkdown/templates/report/skeleton/flow",sep = "/")
  } else if (proj_type %in% c("metagen")) {
    fd_from <- paste(path.package("immuntools"),"rmarkdown/templates/report/skeleton/metagen",sep = "/")
  } else {
    fd_from <- paste(path.package("immuntools"),"rmarkdown/templates/report/skeleton/general",sep = "/")
  }

  # copy .Rmd files from sub-folder
  list_of_files <- list.files(fd_from, ".Rmd|.css")
  file.copy(file.path(fd_from,list_of_files), fd_name)

  # copy skeleton.Rmd and style.css from skeleton folder for tree view
  fd_from_skel <- paste(path.package("immuntools"),"rmarkdown/templates/report/skeleton",sep = "/")
  list_of_files_skel <- list.files(fd_from_skel, ".Rmd|.css")
  file.copy(file.path(fd_from_skel,list_of_files_skel), fd_name)

  # remove the R folder created by create_project()
  unlink(paste(fd_name, "R", sep = "/"), recursive = TRUE)
}


