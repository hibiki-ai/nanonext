% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/listdial.R
\name{dial}
\alias{dial}
\title{Dial an Address from a Socket}
\usage{
dial(
  socket,
  url = "inproc://nanonext",
  tls = NULL,
  autostart = TRUE,
  fail = c("warn", "error", "none"),
  ...
)
}
\arguments{
\item{socket}{a Socket.}

\item{url}{[default 'inproc://nanonext'] a URL to dial, specifying the
transport and address as a character string e.g. 'inproc://anyvalue' or
'tcp://127.0.0.1:5555' (see \link{transports}).}

\item{tls}{[default NULL] for secure tls+tcp:// or wss:// connections only,
provide a TLS configuration object created by \code{\link[=tls_config]{tls_config()}}.}

\item{autostart}{[default TRUE] whether to start the dialer (by default
asynchronously). Set to NA to start synchronously - this is less resilient
if a connection is not immediately possible, but avoids subtle errors from
attempting to use the socket before an asynchronous dial has completed. Set
to FALSE if setting configuration options on the dialer as it is not
generally possible to change these once started.}

\item{fail}{[default 'warn'] failure mode - a character value or integer
equivalent, whether to warn (1L), error (2L), or for none (3L) just return
an 'errorValue' without any corresponding warning.}

\item{...}{not used (and will be removed).}
}
\value{
Invisibly, an integer exit code (zero on success). A new Dialer
(object of class 'nanoDialer' and 'nano') is created and bound to the
Socket if successful.
}
\description{
Creates a new Dialer and binds it to a Socket.
}
\details{
To view all Dialers bound to a socket use \verb{$dialer} on the socket, which
returns a list of Dialer objects. To access any individual Dialer (e.g. to
set options on it), index into the list e.g. \verb{$dialer[[1]]} to return the
first Dialer.

A Dialer is an external pointer to a dialer object, which creates a single
outgoing connection at a time. If the connection is broken, or fails, the
dialer object will automatically attempt to reconnect, and will keep doing so
until the dialer or socket is destroyed.
}
\section{Further details}{


Dialers and Listeners are always associated with a single socket. A given
socket may have multiple Listeners and/or multiple Dialers.

The client/server relationship described by dialer/listener is completely
orthogonal to any similar relationship in the protocols. For example, a rep
socket may use a dialer to connect to a listener on an req socket. This
orthogonality can lead to innovative solutions to otherwise challenging
communications problems.

Any configuration options on the dialer/listener should be set by \code{\link[=opt<-]{opt<-()}}
before starting the dialer/listener with \code{\link[=start]{start()}}.

Dialers/Listeners may be destroyed by \code{\link[=close]{close()}}. They are also closed when
their associated socket is closed.
}

\examples{
socket <- socket("rep")
dial(socket, url = "inproc://nanodial", autostart = FALSE)
socket$dialer
start(socket$dialer[[1]])
socket$dialer
close(socket$dialer[[1]])
close(socket)

nano <- nano("bus")
nano$dial(url = "inproc://nanodial", autostart = FALSE)
nano$dialer
nano$dialer_start()
nano$dialer
close(nano$dialer[[1]])
nano$close()

}
