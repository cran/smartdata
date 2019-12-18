## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- echo = FALSE, include = FALSE-------------------------------------------
library(smartdata)

## ----options_method-----------------------------------------------------------
which_options("instance_selection")
which_options("instance_selection", "multiedit")

## ----preprocess, eval = FALSE-------------------------------------------------
#  preprocess <- function(task){
#    UseMethod("preprocess")
#  }
#  
#  preprocess.instanceSelection <- function(task){
#    class(task) <- instSelectionPackages[[task$method]]$pkg
#  
#    doInstSelection(task)
#  }

## ----wrapper-packages, eval = FALSE-------------------------------------------
#  instSelectionPackages <- list(
#    "CNN" = list(
#      pkg = "unbalanced",
#      map = "ubCNN"
#    ),
#    "ENN" = list(
#      pkg = "unbalanced",
#      map = "ubENN"
#    ),
#    "multiedit" = list(
#      pkg       = "class"
#    ),
#    "FRIS" = list(
#      pkg  = "RoughSets",
#      map  = "IS.FRIS.FRST"
#    )
#  )

## ----wrapper-methods, eval = FALSE--------------------------------------------
#  instSelectionMethods <- names(instSelectionPackages)

## ----method-args, eval = FALSE------------------------------------------------
#  args.multiedit <- list(
#    k = list(
#      check = Curry(qexpect, rules = "X1[1,Inf)", label = "k"),
#      info = "Number of neighbors used in KNN",
#      default = 1
#    ),
#    num_folds = list(
#      check = Curry(qexpect, rules = "X1[1,Inf)", label = "num_folds"),
#      info = "Number of partitions the train set is split in",
#      default = 3,
#      map = "V"
#    ),
#    null_passes = list(
#      check = Curry(qexpect, rules = "X1[1,Inf)", label = "null_passes"),
#      info = "Number of null passes to use in the algorithm",
#      default = 5,
#      map = "I"
#    )
#  )

## ----resolve-method, eval = FALSE---------------------------------------------
#  doInstSelection.unbalanced <- function(task){
#    callArgs <- eval(parse(text = paste("args.", task$method, sep = "")))
#    callArgs <- mapArguments(task$args, callArgs)
#    classAttr <- task$classAttr
#    classIndex <- task$classIndex
#    dataset <- task$dataset
#  
#    method <- mapMethod(instSelectionPackages, task$method)
#  
#    # CNN and ENN need minority class as 1, and majority one as 0
#    minorityClass <- whichMinorityClass(dataset, classAttr)
#    minority <- whichMinority(dataset, classAttr)
#    old_levels <- levels(dataset[, classIndex])
#    new_levels <- old_levels
#    new_levels[old_levels == minorityClass] <- 1
#    new_levels[old_levels != minorityClass] <- 0
#    levels(dataset[, classIndex]) <- as.numeric(new_levels)
#  
#    callArgs <- c(list(X = dataset[, -classIndex],
#                       Y = dataset[, classIndex], verbose = FALSE),
#                  callArgs)
#    result <- do.call(method, callArgs)
#    result <- cbind(result$X, result$Y)
#    # Assign original classAttr name to class column
#    names(result)[classIndex] <- classAttr
#    # Retrieve original levels for class
#    levels(result[, classIndex]) <- old_levels
#    # Reset rownames
#    rownames(result) <- c()
#  
#    result
#  }

## ---- eval = FALSE------------------------------------------------------------
#  instance_selection <- function(dataset, method, class_attr = "Class", ...){
#    classAttr <- class_attr
#    checkDataset(dataset)
#    checkDatasetClass(dataset, classAttr)
#  
#    method <- matchArg(method, instSelectionMethods)
#  
#    # Perform instance selection
#    task <- preprocessingTask(dataset, "instanceSelection", method, classAttr, ...)
#    dataset <- preprocess(task)
#  
#    dataset
#  }

