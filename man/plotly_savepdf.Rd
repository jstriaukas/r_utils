\name{plotly_savepdf}
\alias{plotly_savepdf}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
plotly_savepdf(fig, filepath = NULL, filename = "plot.pdf")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{fig}{
%%     ~~Describe \code{fig} here~~
}
  \item{filepath}{
%%     ~~Describe \code{filepath} here~~
}
  \item{filename}{
%%     ~~Describe \code{filename} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (fig, filepath = NULL, filename = "plot.pdf") 
{
    dir <- getwd()
    if (is.null(filepath)) {
        filepath <- file.path(getwd(), "/figures")
        if (!file.exists(filepath)) {
            dir.create(file.path(filepath))
        }
    }
    setwd(filepath)
    file <- filename
    format = tools::file_ext(file)
    debug = verbose = safe = F
    b <- plotly_build(fig)
    plotlyjs <- plotly:::plotlyjsBundle(b)
    plotlyjs_path <- file.path(plotlyjs$src$file, plotlyjs$script)
    if (!is.null(plotlyjs$package)) {
        plotlyjs_path <- system.file(plotlyjs_path, package = plotlyjs$package)
    }
    tmp <- tempfile(fileext = ".json")
    cat(plotly:::to_JSON(b$x[c("data", "layout")]), file = tmp)
    args <- c("graph", tmp, "-o", file, "--format", format, "--plotlyjs", 
        plotlyjs_path, if (debug) "--debug", if (verbose) "--verbose", 
        if (safe) "--safe-mode")
    base::system(paste("orca", paste(args, collapse = " ")))
    setwd(dir)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
