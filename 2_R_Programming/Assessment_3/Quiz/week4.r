set.seed(1)
rpois(5, 2)

rnorm
pnorm

set.seed(1)
rpois(5, 2)

set.seed(1)
ppois(5, 2)

set.seed(10)
x <- rbinom(10000, 10, 0.5)
e <- rnorm(10000, 0, 20)
y <- 0.5 + 2 * x + e