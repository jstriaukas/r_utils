#' Sorts directory
#' 
#' @description 
#'  Finds the current file directory
#' @details
#'  Sorts directory
#' @return list of variables: 1. full path filename, 2. working directory, 3. OS type
#' @author Jonas Striaukas
#' @examples 
#' \donttest{
#'  sort_directory()
#' }
#' @export sort_directory
sort_directory <- function(){
  filename <- rstudioapi::getActiveDocumentContext()$path
  wd <- dirname(filename)
  
  os_type <- .Platform$OS.type
  output <- list(filename = filename, wd = wd, os_type = os_type)
  
  return(output)
}