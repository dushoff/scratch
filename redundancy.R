
## Given a formula, and a list of rows with structural NAs for a variable, 
## fit a model by setting them either to baseline or mean
## Later break this into more functions so we can call the hard one and use it for things other than lm

structFill <- function(mm, NArows, varNum, method123="mean",check){
  
  modAssign <- attr(mm, "assign")
  fillcols <- which(modAssign==varNum)
  
  if(check){
  dcheck <- na.omit(mm[NArows, fillcols])
  if (length(dcheck)>0){stop("Not all structural NAs are really NA")}
  }
  
  if(method123=="base")
    mm[NArows, fillcols] <- 0
  else if (method123=="mean"){
    mm[NArows, fillcols] <- matrix(
      colMeans(mm[!NArows,fillcols])
      , nrow=sum(NArows)
      , ncol=length(fillcols)
      , byrow=TRUE
    )
  }
  else stop("Unrecognized method123")
  
  return(mm)
}

lmFill <- function(formula, data, NArows, fillvar, method123="mean",check=FALSE){
  
  mf <- model.frame(formula, data=data, na.action=NULL)
  mt <- attr(mf, "terms")
  mm <- model.matrix(mt, mf)
  
  varNum <- which(attr(attr(mf, "terms"), "term.labels")==fillvar)
  
  mm <- structFill(mm, NArows, varNum, method123)
  
  mr <- model.response(mf)
  mfit <- lm.fit(mm, mr)
  mfit$call <- match.call()
  class(mfit) <- "lm"
  mfit$terms <- terms(mf)
  
  return(mfit)
}

lmerFill <- function(formula, data, NArows, fillvar, method123="mean",check=FALSE){
  lmod <- lFormula(y~x+country+religion+(1|village), dat)
  varNum <- which(attr(attr(lmod$fr, "terms"), "term.labels")==fillvar)
  lmod$X <- structFill(lmod$X, NArows, varNum, method123, check)
  devfun <- do.call(mkLmerDevfun, lmod)
  opt <- optimizeLmer(devfun)
  return(mkMerMod(environment(devfun), opt, lmod$reTrms, fr = lmod$fr))
}    
    

clmmFill <- function (formula, data,NArows, fillvar, method123="mean", check=FALSE,weights, start, subset, na.action, contrasts, 
                      Hess = TRUE, model = TRUE, link = c("logit", "probit", "cloglog", 
                                                          "loglog", "cauchit"), doFit = TRUE, control = list(), 
                      nAGQ = 1L, threshold = c("flexible", "symmetric", "symmetric2", 
                                               "equidistant"), ...) 
{
  mc <- match.call(expand.dots = FALSE)
  link <- match.arg(link)
  threshold <- match.arg(threshold)
  if (missing(formula)) 
    stop("Model needs a formula")
  if (missing(contrasts)) 
    contrasts <- NULL
  control <- ordinal:::getCtrlArgs(control, list(...))
  nAGQ <- as.integer(round(nAGQ))
  formulae <- ordinal:::clmm.formulae(formula = formula)
  frames <- ordinal:::clmm.frames(modelcall = mc, formulae = formulae, 
                                  contrasts)
  if (control$method == "model.frame") 
    return(frames)
  varNum <- which(attr(attr(frames$mf, "terms"), "term.labels")==fillvar)
  frames$X <- structFill(frames$X, NArows, varNum, method123,check)
  frames$X <- drop.coef(frames$X, silent = FALSE)
  ths <- ordinal:::makeThresholds(levels(frames$y), threshold)
  rho <- with(frames, {
    ordinal:::clm.newRho(parent.frame(), y = y, X = X, weights = wts, 
                         offset = off, tJac = ths$tJac)
  })
  retrms <- ordinal:::getREterms(frames = frames, formulae$formula)
  use.ssr <- (retrms$ssr && !control$useMatrix)
  ordinal:::setLinks(rho, link)
  rho$dims <- ordinal:::getDims(frames = frames, ths = ths, retrms = retrms)
  if (use.ssr) {
    ordinal:::rho.clm2clmm.ssr(rho = rho, retrms = retrms, ctrl = control$ctrl)
    if (missing(start)) 
      start <- c(ordinal:::fe.start(frames, link, threshold), 0)
    rho$par <- start
    nbeta <- rho$nbeta <- ncol(frames$X) - 1
    nalpha <- rho$nalpha <- ths$nalpha
    ntau <- rho$ntau <- length(retrms$gfList)
    stopifnot(is.numeric(start) && length(start) == (nalpha + 
                                                       nbeta + ntau))
  }
  else {
    rho.clm2clmm(rho = rho, retrms = retrms, ctrl = control$ctrl)
    if (missing(start)) {
      rho$fepar <- fe.start(frames, link, threshold)
      rho$ST <- STstart(rho$ST)
      start <- c(rho$fepar, ST2par(rho$ST))
    }
    else {
      stopifnot(is.list(start) && length(start) == 2)
      stopifnot(length(start[[1]]) == rho$dims$nfepar)
      stopifnot(length(start[[2]]) == rho$dims$nSTpar)
      rho$fepar <- as.vector(start[[1]])
      rho$ST <- par2ST(as.vector(start[[2]]), rho$ST)
    }
  }
  ordinal:::set.AGQ(rho, nAGQ, control, use.ssr)
  if (!doFit) 
    return(rho)
  fit <- if (use.ssr) 
    ordinal:::clmm.fit.ssr(rho, control = control$optCtrl, method = control$method, 
                 Hess)
  else clmm.fit.env(rho, control = control$optCtrl, method = control$method, 
                    Hess)
  fit$nAGQ <- nAGQ
  fit$link <- link
  fit$start <- start
  fit$threshold <- threshold
  fit$call <- match.call()
  fit$formula <- formulae$formula
  fit$gfList <- retrms$gfList
  fit$control <- control
  res <- ordinal:::clmm.finalize(fit = fit, frames = frames, ths = ths, 
                       use.ssr)
  if (model) 
    res$model <- frames$mf
  return(res)
}
