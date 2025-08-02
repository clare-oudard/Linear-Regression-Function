clarelm = function(Xk, Y, method = 'lsr', delta = 1.5, avplot = T){
  n = length(Y)
  X = cbind(1, Xk)
  p = (ncol(X) -1) # need to put a cbind or rbind, ncol and nrow only works for true matrices
  if(method == 'ridge') {
    I = diag(p+1)
    bhat = solve(t(X)%*%X + (delta^2)*I)%*%t(X)%*%Y
  }
  if(method == 'lsr') {
    bhat = solve(t(X)%*%X)%*%t(X)%*%Y
  }
  yhat = X%*%bhat
  rsd = Y - yhat
  sse = sum(rsd^2)
  mse = sse/(n-p-1)
  rmse = sqrt(sse/n)
  sigmahat = sqrt(mse)
  
  H = X%*%solve(t(X)%*%X)%*%t(X)
  lev = diag(H)
  
  srsd = rsd/(sqrt(mse)*sqrt(1-lev))
  sst = var(Y)*(n-1)
  mst = var(Y)
  ssm = sst - sse
  msm = ssm/p
  fstat = msm/mse
  pval = pf(fstat, p, n-p-1, lower.tail = F)
  
  r2 = 1 - sse/sst
  r2adj = 1- mse/mst
  
  sigbhat = mse*solve(t(X)%*%X) # a matrix p + 1 x p +1
  varbhat = diag(sigbhat)
  sebhat = sqrt(varbhat)

  
  Zk = scale(Xk) # gives z score for every column
  Z = cbind(1, Zk)
  
  
  Zy = scale(Y)
  #zeta hat gives standardized coeff
  R = cor(cbind(Y, Xk))
  vif = diag(solve(R)) #something with varbhat in it 
  mci = sqrt(vif)
  
  # bhat_s is standadrdized coefficients for original data
  # zetahat = coeffeciencts of standardized data
  # one is not better than the other 
  bhat_s = bhat/sebhat
  zetahat = solve(t(Z)%*%Z)%*%t(Z)%*%Y 
  D = sqrt(abs(det(t(X)%*%X)))

  my_avslopes = NULL
  if( avplot == T){
    my_avslopes = c()
    for (k in 1:p){
      M_Y_Xkc = clarelm(as.matrix(Xk[,-k]), Y, avplot = F)
      M_Xk_Xkc = clarelm(as.matrix(Xk[,-k]), Xk[,k], avplot = F)
      
      YY = M_Y_Xkc$srsd
      XX = M_Xk_Xkc$srsd
      m_avk = cor(XX, YY)*sd(YY)/sd(XX)
      my_avslopes = c(my_avslopes, m_avk)
    }
  }
  
  my_avslopes
  # standardized  coefficients 
  result = list("betahat" = bhat, 
                "yhat"    = yhat, 
                "mse"     = mse, 
                "lev"     = lev, 
                "srsd"    = srsd,
                "sse"     = sse,
                "ssm"     = ssm,
                "rmse"    = rmse,
                "sebhat"  = sebhat,
                "pval"    = pval,
                "fstat"   = fstat,
                "r2"      = r2,
                "r2adj"   = r2adj, 
                "zetahat" = zetahat, 
                "pseudoD" = D,
                "corrmat" = R, 
                "vif"     = vif,
                "mci"     = mci,
                "bhat_s"  = bhat_s,
                "rsd"     = rsd, 
                "H"       = H, 
                "avslopes" = my_avslopes)
  
  # lists dont have to be the same type
  # give each thing a short easy name
  return(result)
}




  
