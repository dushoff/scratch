  library(mgcv)

  N<- 100
  N.distclass<- 7

  X<- matrix(runif(N * N.distclass, -2, 2), N, N.distclass)

  noise<- rnorm(N)

  true.coefs<- c(0.3, 0.5, 0.7, 0.8, 0.6, 0.3, 0.1)

  y<- X %*% true.coefs + noise

  D<- matrix(1:N.distclass, N, N.distclass, byrow= T)

  b<- gam(y ~ s(D, by= X, k= 3))

  par(mfrow= c(1, 1))
  plot(b, shade= TRUE)
  lines(1:N.distclass, true.coefs, col= 2)

