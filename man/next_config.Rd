% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{next_config}
\alias{next_config}
\title{Configure Next Mode}
\usage{
next_config(refhook = list(), class = "", vec = FALSE, mark = FALSE)
}
\arguments{
\item{refhook}{\strong{either} a list or pairlist of two functions: the
signature for the first must accept a reference object inheriting from
\sQuote{class} (or a list of such objects) and return a raw vector, and
the second must accept a raw vector and return reference objects (or a
list of such objects), \cr \strong{or else} NULL to reset.}

\item{class}{[default ""] a character string representing the class of object
that these serialization function will be applied to, e.g.
\sQuote{ArrowTabular} or \sQuote{torch_tensor}.}

\item{vec}{[default FALSE] the serialization functions accept and return
reference object individually e.g. \code{arrow::write_to_raw} and
\code{arrow::read_ipc_stream}. If TRUE, the serialization functions are
vectorized and accept and return a list of reference objects, e.g.
\code{torch::torch_serialize} and \code{torch::torch_load}.}

\item{mark}{[default FALSE] (for advanced use only) logical value, whether to
mark serialized data with a special bit.}
}
\value{
A pairlist comprising the currently-registered \sQuote{refhook}
    functions.
}
\description{
Configures send mode \sQuote{next} by registering functions for custom
    serialization and unserialization of non-system reference objects,
    allowing these to be sent and received between different R sessions.
}
\details{
Calling this function without any arguments returns the pairlist of
    currently-registered \sQuote{refhook} functions (and resets \sQuote{mark}
    to FALSE).
}
\examples{
g <- next_config(refhook = list(function(x) serialize(x, NULL), unserialize))
next_config()
next_config(g, mark = TRUE)

next_config(NULL)
next_config()

}
