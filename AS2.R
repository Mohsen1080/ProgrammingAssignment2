##
## I simply set the input x as a matrix
## and then set the solved value "so" as a null
## then I changed every reference to "mean" to "solve"
makeCacheMatrix <- function(x = matrix(sample(1:100,9),3,3)) {
  so <- NULL
  set <- function(y) {
    x <<- y
    so <<- NULL
  }
  get <- function() x
  setsolve <- function(solve) so <<- solve
  getsolve <- function() so
  list(set = set, get = get,
       setsolve = setsolve,
       getsolve = getsolve)
}
##
## Same here, changed "mean" to "solve" and "m" to "y"
cacheSolve <- function(x, ...) {
  y <- x$getsolve()
  if(!is.null(s)) {
    message("getting inversed matrix")
    return(s)
  }
  data <- x$get()
  y<- solve(data, ...)
  x$setsolve(y)
  y
}


