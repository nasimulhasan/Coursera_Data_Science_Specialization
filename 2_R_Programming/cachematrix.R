## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

##This function creates a special "matrix" 
##object that can cache its inverse.
makeCacheMatrix <- function(x = matrix()) {
        m <- NULL
        
        #assign the value of the matrix
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        
        #return the content of x
        get <- function() x
        
        #set the inverse value of the matrix
        setInverse <- function(solve) m <<- solve
        
        #return the inverse of the content of x
        getInverse <- function() m
        
        #functions wrapped in list
        list(set = set, get = get,
             setInverse = setInverse,
             getInverse = getInverse)

}


## Write a short comment describing this function

##This function computes the inverse of the special "matrix" 
##returned by makeCacheMatrix above
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        
        #query the x matrix's cache
        m <- x$getInverse()
        
        #if there is a cache, then return the cache, no 
        #computation needed
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        
        #if there is no cache, then compute them and
        #save the result back to x's cache, and
        #return the result
        data <- x$get()
        m <- solve(data, ...)
        x$setInverse(m)
        m
}
