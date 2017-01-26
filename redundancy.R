
## Given a formula, and a list of rows with structural NAs for a variable, 
## fit a model by setting them either to baseline or mean
## Later break this into more functions so we can call the hard one and use it for things other than lm

structFill <- function(mm, NArows, varNum, method123="mean",check=TRUE){

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

lmFill <- function(formula, data, NArows, fillvar, method123="mean"){

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

lmerFill <- function(formula, data, NArows, fillvar, method123="mean",check=TRUE){
  lmod <- lFormula(y~x+country+religion+(1|village), dat)
  varNum <- which(attr(attr(lmod$fr, "terms"), "term.labels")==fillvar)
  lmod$X <- structFill(lmod$X, NArows, varNum, method123, check)
  devfun <- do.call(mkLmerDevfun, lmod)
  opt <- optimizeLmer(devfun)
  return(mkMerMod(environment(devfun), opt, lmod$reTrms, fr = lmod$fr))
}
