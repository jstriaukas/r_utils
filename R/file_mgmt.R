#' Saves plotly figure in specified folder
#' 
#' @description 
#'  Saves plotly figure in specified folder
#' @details
#'  Saves plotly figure in specified folder
#' @param fig - plotly figure output
#' @param filepath - file path to folder where figures should be saved
#' @param filename - file name (should include prefix)
#' @return empty
#' @author Jonas Striaukas
#' @examples 
#' \donttest{
#'  library(plotly)
#'  fig <- plot_ly(z = volcano, type = "heatmap")
#'  plotly_savepdf(fig)
#' }
#' @export plotly_savepdf
plotly_savepdf <- function(fig, filepath = NULL, filename = "plot.pdf"){
  dir <- getwd()
  if (is.null(filepath)){
    filepath <- file.path(getwd(),"/figures")
    if (!file.exists(filepath)){
      dir.create(file.path(filepath))
    } 
  }
  setwd(filepath)
  file <- filename
  format = tools::file_ext(file)
  debug=verbose=safe=F
  b <- plotly_build(fig)
  plotlyjs <- plotly:::plotlyjsBundle(b)
  plotlyjs_path <- file.path(plotlyjs$src$file, plotlyjs$script)
  if (!is.null(plotlyjs$package)) {
    plotlyjs_path <- system.file(plotlyjs_path, package = plotlyjs$package)
  }
  tmp <- tempfile(fileext = ".json")
  cat(plotly:::to_JSON(b$x[c("data", "layout")]), file = tmp)
  args <- c("graph", tmp, "-o", file, "--format", 
            format, "--plotlyjs", plotlyjs_path, if (debug) "--debug", 
            if (verbose) "--verbose", if (safe) "--safe-mode")
  base::system(paste("orca", paste(args, collapse = " ")))
  setwd(dir)
}