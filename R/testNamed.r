testNamed = function(x, dups.ok, strict) {
  nn = names(x)
  if (is.null(nn) || anyMissing(nn) || !all(nzchar(nn)))
    return("'%s' must be named")
  if (assertFlag(dups.ok) && !dups.ok && anyDuplicated(nn) > 0L)
    return("'%s' contains duplicated names")
  if (assertFlag(strict) && strict && (any(nn != make.names(nn) | grepl("^\\.\\.[0-9]$", nn))))
    return("Names of '%s' are not compatible with R's variable naming rules")
  return(TRUE)
}

#' Check or assert that an argument is named
#'
#' @param x [\code{ANY}]\cr
#'  Object to check.
#' @param dups.ok [logical(1)]\cr
#'  Are duplicated names okay?
#'  Default is \code{TRUE}.
#' @param strict [logical(1)]\cr
#'  Enables a check for compability with R's variable naming rules.
#'  Default is \code{FALSE}.
#' @param .var.name [\code{logical(1)}]\cr
#'  Argument name to print in error message. If missing,
#'  the name of \code{x} will be retrieved via \code{\link[base]{substitute}}.
#' @return [\code{logical(1)}] Returns \code{TRUE} on success.
#'  Throws an exception on failure for assertion.
#' @export
assertNamed = function(x, dups.ok = TRUE, strict = FALSE, .var.name) {
  amsg(testNamed(x, dups.ok, strict), vname(x, .var.name))
}

#' @rdname assertNamed
#' @export
checkNamed = function(x, dups.ok = TRUE, strict = FALSE) {
  isTRUE(testNamed(x, dups.ok, strict))
}