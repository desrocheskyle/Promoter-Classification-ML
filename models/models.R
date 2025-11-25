load("model-setup.rda")

library(tidyverse)
library(tidymodels)
library(naniar)
library(gridExtra)
library(BiocManager)
library(stringr)
library(MASS)
library(parsnip)
library(discrim)
library(kernlab)

#Lasso
logistic <- logistic_reg(penalty = tune(), mixture = 1) %>%  # Lasso regression
  set_engine("glmnet") %>%
  set_mode("classification")

# Create workflow
logistic_wf <- workflow() %>%
  add_model(logistic) %>%
  add_recipe(promoter_recipe)

penalty_grid <- grid_regular(penalty(range = c(-3, 0)), levels = 10)

# Tune the penalty parameter
tune_results_lasso <- tune_grid(
  logistic_wf,
  resamples = promoter_folds,
  grid = penalty_grid,
  metrics = metric_set(roc_auc)
)


#LDA

# Specify LDA model
lda_spec <- discrim_linear() %>%
  set_engine("MASS") %>%
  set_mode("classification")

# Creating LDA workflow
lda_wf <- workflow() %>%
  add_model(lda_spec) %>%
  add_recipe(promoter_recipe)

# Fit LDA model with cross-validation
lda_fit <- fit_resamples(
  lda_wf,
  resamples = promoter_folds,
  metrics = metric_set(roc_auc)
)


# Specify RDA Model and Workflow
rda_spec <- discrim_regularized(frac_common_cov = tune(), frac_identity = tune()) %>%
  set_engine("klaR") %>%
  set_mode("classification")

rda_wf <- workflow() %>%
  add_model(rda_spec) %>%
  add_recipe(promoter_recipe)

# Define Grid for Hyperparameter Tuning
rda_grid <- grid_regular(
  frac_common_cov(range = c(0, 1)),    
  frac_identity(range = c(0, 1)),      
  levels = 10
)

# Perform Hyperparameter Tuning
rda_tune_results <- tune_grid(
  rda_wf,
  resamples = promoter_folds,
  grid = rda_grid,
  metrics = metric_set(roc_auc, accuracy)
)


#Random Forest
# Specify Random Forest model with tuning parameters
random_forest_model <- rand_forest(mtry = tune(), trees = tune(), min_n = tune()) %>%
  set_engine("ranger", importance = "impurity") %>% set_mode("classification")

# Create workflow
rf_wf <- workflow() %>%
  add_model(random_forest_model) %>%
  add_recipe(promoter_recipe)

# Define a grid for tuning `mtry`, `min_n`, and `trees`
rf_grid <- grid_regular(
  mtry(range = c(1, 6)),
  min_n(range = c(2, 10)),
  trees(range = c(500, 1500)),
  levels = 5
)

# Tune the hyperparameters with cross-validation
tune_results_rf <- tune_grid(
  rf_wf,
  resamples = promoter_folds,
  grid = rf_grid,
  metrics = metric_set(roc_auc)
)



#Support Vector Machine
# Specify SVM model with RBF kernel and tunable parameters
svm_spec <- svm_rbf(
  cost = tune(),   # C parameter
  rbf_sigma = tune()  # γ parameter
) %>%
  set_engine("kernlab") %>%
  set_mode("classification")

# Creating SVM workflow
svm_wf <- workflow() %>%
  add_model(svm_spec) %>%
  add_recipe(promoter_recipe)

# Define the grid for hyperparameter tuning with broad ranges
svm_grid <- grid_regular(
  cost(range = c(-5, 5)),    # Range for cost (log scale)
  rbf_sigma(range = c(-5, 0)), # Range for rbf_sigma (log scale)
  levels = 5
)

# Tune the model with cross-validation
svm_tune_results <- tune_grid(
  svm_wf,
  resamples = promoter_folds,
  grid = svm_grid,
  metrics = metric_set(roc_auc, accuracy)
)

save(svm_wf, rf_wf, rda_wf, lda_wf, logistic_wf, tune_results_lasso, lda_fit, rda_tune_results, tune_results_rf, svm_tune_results, file = "/Users/kyledesroches/Desktop/PSTAT 131/Final Project/models.rda")