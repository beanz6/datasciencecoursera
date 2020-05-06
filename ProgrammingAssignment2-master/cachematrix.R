## Put comments here that give an overall description of what your
## functions do

## Want to create a matrix which store the contents and the inverse also.
## with 2 variables which is x and m is the inverse
## set function :  x <<- y creates x, which is then retrieved by get(). so y is the dummy variable and assigns to x.
## which would be the same for m.


makeCacheMatrix <- function(x = matrix()) {
  m <- NULL  
  set <- function(y)
    x <<- y
  m <<- NULL
}

     get <- function()x {
     setInverse <- function(inverse) m <<- inverse
     getInverse <- function() m 
     list(set = set, get = get, 
       setInverse = setInverse, 
       getInverse = getInverse)    
  
}


## Write a short comment describing this function

## cacheSolve retuns the inverse of the matrix returned by makeCacheMatrix 
## If the inverse has already been calculated (and no changes in the matrix has occured),
## then the cachesolve should retrieve the inverse from the cache

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  
  m <- x$getinverse()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$setinverse(m)
  
  
}
