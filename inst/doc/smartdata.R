## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE, 
  message = FALSE
)

## ---- eval = FALSE------------------------------------------------------------
#  result <- dataset %>% impute_missing %>% clean_noise %>% oversample %>% feature_selection

## ---- warning = FALSE, message = FALSE----------------------------------------
library("smartdata")
which_options("instance_selection")

## -----------------------------------------------------------------------------
which_options("instance_selection", "multiedit")

## -----------------------------------------------------------------------------
super_iris <- iris %>% instance_selection("multiedit", k = 3, num_folds = 2, 
                                          null_passes = 10, class_attr = "Species")

## -----------------------------------------------------------------------------
super_iris <- iris %>% instance_selection("multiedit", k = 3, null_passes = 10,                                           
                                          class_attr = "Species")

## -----------------------------------------------------------------------------
super_iris <- iris %>% instance_selection("multiedit", k = 3, 
                                          class_attr = "Species")

## -----------------------------------------------------------------------------
super_iris <- iris %>% instance_selection("multiedit", class_attr = "Species")

## ---- message = FALSE, warning = FALSE, results = "hide"----------------------
data(iris0, package = "imbalance")
super_iris <- oversample(iris0, method = "MWMOTE", class_attr = "Class",
                         ratio = 0.8, filtering = TRUE)

## ---- message = FALSE, warning = FALSE, results = "hide"----------------------
super_iris <- instance_selection(iris, method = "CNN", class_attr = "Species")

## -----------------------------------------------------------------------------
super_iris <- feature_selection(iris, "Boruta", class_attr = "Species")

## ---- results = "hide", warning = FALSE, message = FALSE----------------------
super_iris <- normalize(iris, method = "min_max", exclude = "Species", by = "column")

## -----------------------------------------------------------------------------
super_iris <- discretize(iris, method = "chi2", class_attr = "Species")

## ---- results = "hide"--------------------------------------------------------
data(ecoli1, package = "imbalance")
super_ecoli <- space_transformation(ecoli1, "lle_knn", k = 3, num_features = 2,
                                   regularization = 1, exclude = c("Mcg", "Alm1"))

## ---- eval = FALSE------------------------------------------------------------
#  super_iris <- clean_outliers(iris, method = "multivariate", type = "adj")
#  super_iris <- clean_outliers(iris, method = "univariate", type = "z", fill = "mean")

## -----------------------------------------------------------------------------
data(nhanes, package = "mice")
super_nhanes <- impute_missing(nhanes, "gibbs_sampling")

## -----------------------------------------------------------------------------
super_iris <- clean_noise(iris, method = "AENN", class_attr = "Species", k = 3)

