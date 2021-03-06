## Implementation strategy : used the same as makeVector, but with slightly
## more explicit variable names

makeCacheMatrix <- function(x = matrix()) {
    ## Makes a matrix that can cache its inverse. The cache is invalidated
    ## if the matrix is modified
    ## Returns a list containing the key functions to use the cacheMatrix
    
    cache <- NULL
    
    set <- function(y) {
        x <<- y
        message("New Matrix, invalidating cached data")
        cache <<- NULL
    }
    
    get <- function() x
    setinverse <- function(inverse) cache <<- inverse
    getinverse <- function() cache
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    ## Parameters : x is a CacheMatrix generated by makeCacheMatrix
    ## Returns the inverse of the matrix :  
    ## if the inverse is already present in the variable "cache" in the 
    ## parent environment, that value is returned instead
    ## if not, the cache is updated with the new inverse, and that 
    ## inverse is also returned by the function

    cache <- x$getinverse()
    if(!is.null(cache)) {
        message("getting cached data")
        return(cache)
    }
    data <- x$get()
    cache <- solve(data, ...)
    x$setinverse(cache)
    cache
}
