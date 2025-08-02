The clarelm function performs linear regression analysis with optional ridge regularization and computes various diagnostic metrics for model assessment. It also optionally calculates added-variable slopes for visualizing the contribution of each predictor, enhancing model interpretability.
This function is designed for use in statistical modeling and diagnostics, particularly for students or researchers exploring classical linear regression with added interpretive tools.

Function Signature
clarelm(Xk, Y, method = 'lsr', delta = 1.5, avplot = TRUE)
Arguments
Xk: A matrix or data frame of predictor variables (excluding the intercept).
Y: A numeric response vector.
method: A character string indicating the regression method:
'lsr' (default): Ordinary least squares regression.
'ridge': Ridge regression with regularization strength controlled by delta.
delta: A numeric value controlling the ridge penalty (default 1.5). Only used if method = 'ridge'.
avplot: A logical flag indicating whether to compute added-variable slopes (default TRUE). This helps understand the marginal contribution of each predictor.
Returns
A named list containing:
Model Estimates and Fits
betahat: Estimated coefficients.
yhat: Fitted values.
rsd: Raw residuals.
srsd: Studentized residuals.
lev: Leverage values (diagonal of hat matrix H).
H: Hat matrix.
Error Metrics
sse: Sum of squared errors.
rmse: Root mean squared error.
mse: Mean squared error.
sebhat: Standard errors of betahat.
Model Evaluation
r2: R-squared.
r2adj: Adjusted R-squared.
fstat: F-statistic.
pval: p-value for F-test.
Standardization
zetahat: Coefficients from standardized (Z-scored) regression.
bhat_s: t-statistics for each coefficient (betahat / sebhat).
pseudoD: A pseudo-determinant of the X'X matrix (for numerical diagnostics).
Collinearity Diagnostics
corrmat: Correlation matrix of [Y, Xk].
vif: Variance inflation factors.
mci: Multicollinearity indicators (sqrt of VIF).
Added-Variable Slopes (Optional)
avslopes: Vector of added-variable slopes for each predictor, indicating their marginal contribution after controlling for other predictors.
Notes
The function automatically adds an intercept column to the predictors.
Standardized coefficients are included both as z-score regression (zetahat) and t-statistics (bhat_s).
If avplot = TRUE, the function recursively fits reduced models to calculate added-variable slopes.
Example
set.seed(1)
X <- matrix(rnorm(100), ncol = 2)
Y <- 3 + 2 * X[,1] - 1 * X[,2] + rnorm(50)

result <- clarelm(X, Y)

print(result$betahat)     # Estimated coefficients
print(result$r2adj)       # Adjusted R-squared
print(result$avslopes)    # Added-variable slopes
