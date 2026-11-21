diabetes_original <- read.csv("D:/10th Sem/Data Science/Project/diabetes_dataset.csv", header = TRUE, sep = ",")

nrow(diabetes_original) 
ncol(diabetes_original) 
str(diabetes_original) 
head(diabetes_original[, 1:8]) 
summary(diabetes_original[, c("age", "bmi", "glucose_fasting", "hba1c", "insulin_level")]) 
summary(factor(diabetes_original$diagnosed_diabetes)) 
summary(factor(diabetes_original$diagnosed_diabetes)) / nrow(diabetes_original) * 100 
summary(factor(diabetes_original$diabetes_stage)) 
sum(is.na(diabetes_original)) 
nrow(na.omit(diabetes_original)) 
sum(diabetes_original$age < 18 | diabetes_original$age > 100) 
sum(diabetes_original$sleep_hours_per_day < 0 | diabetes_original$sleep_hours_per_day > 24)


n <- nrow(diabetes_original) 
modified <- diabetes_original 
modified$insulin_level[seq(20, n, by = 20)] <- NA 
modified$bmi[seq(3, n, by = 33)] <- NA 
modified$smoking_status[seq(11, n, by = 34)] <- NA 
modified$age[seq(500, n, by = 2500)] <- -5 
modified$sleep_hours_per_day[seq(1000, n, by = 5000)] <- 30 
modified$diastolic_bp[seq(300, n, by = 3333)] <- 200 
modified$cholesterol_total[seq(250, n, by = 1667)] <- 700 
modified$triglycerides[seq(400, n, by = 2500)] <- 1000 
modified <- modified[c(1:n, 1:200), ] 
diabetes <- modified 
nrow(diabetes) 
ncol(diabetes) 
colSums(is.na(diabetes)) 
sum(diabetes$age < 18 | diabetes$age > 100) 
sum(diabetes$sleep_hours_per_day > 24) 
sum(diabetes$systolic_bp < diabetes$diastolic_bp) 
max(diabetes$cholesterol_total) 
max(diabetes$triglycerides) 

colSums(is.na(diabetes)) / nrow(diabetes) * 100 
nrow(diabetes) - nrow(na.omit(diabetes)) 
afterDeletedDataset <- na.omit(diabetes) 
nrow(afterDeletedDataset) 
ncol(afterDeletedDataset) 
(nrow(diabetes) - nrow(afterDeletedDataset)) / nrow(diabetes) * 100 
sum(is.na(afterDeletedDataset)) 
summary(diabetes$insulin_level) 
insulin_mean <- diabetes$insulin_level 
insulin_mean[is.na(insulin_mean)] <- mean(diabetes$insulin_level, na.rm = TRUE) 
sum(is.na(insulin_mean)) 
summary(insulin_mean) 
summary(diabetes$bmi) 
bmi_mean <- diabetes$bmi 
bmi_mean[is.na(bmi_mean)] <- mean(diabetes$bmi, na.rm = TRUE) 
sum(is.na(bmi_mean)) 
summary(bmi_mean) 
summary(diabetes$insulin_level) 
insulin_median <- diabetes$insulin_level 
insulin_median[is.na(insulin_median)] <- median(diabetes$insulin_level, na.rm = TRUE) 
sum(is.na(insulin_median)) 
summary(insulin_median) 
smoking_counts <- table(diabetes$smoking_status) 
smoking_counts 
smoking_mode <- names(which.max(smoking_counts)) 
smoking_mode 
smoking_filled <- diabetes$smoking_status 
smoking_filled[is.na(smoking_filled)] <- smoking_mode 
sum(is.na(smoking_filled)) 
table(smoking_filled) 
cleaned_dataset <- diabetes 
cleaned_dataset$insulin_level <- insulin_median 
cleaned_dataset$bmi <- bmi_mean 
cleaned_dataset$smoking_status <- smoking_filled 
sum(is.na(cleaned_dataset)) 
nrow(cleaned_dataset) 
ncol(cleaned_dataset) 

chol_summary <- summary(cleaned_dataset$cholesterol_total) 
chol_summary 
chol_q1 <- chol_summary[["1st Qu."]] 
chol_q3 <- chol_summary[["3rd Qu."]] 
chol_iqr <- chol_q3 - chol_q1 
chol_lower <- chol_q1 - 1.5 * chol_iqr 
chol_upper <- chol_q3 + 1.5 * chol_iqr 
chol_iqr 
chol_lower 
chol_upper 
sum(cleaned_dataset$cholesterol_total < chol_lower | cleaned_dataset$cholesterol_total > chol_upper) 
trig_summary <- summary(cleaned_dataset$triglycerides) 
trig_summary 
trig_q1 <- trig_summary[["1st Qu."]] 
trig_q3 <- trig_summary[["3rd Qu."]] 
trig_iqr <- trig_q3 - trig_q1 
trig_lower <- trig_q1 - 1.5 * trig_iqr 
trig_upper <- trig_q3 + 1.5 * trig_iqr 
trig_iqr 
trig_lower 
trig_upper 
sum(cleaned_dataset$triglycerides < trig_lower | cleaned_dataset$triglycerides > trig_upper) 
after_removal <- cleaned_dataset[cleaned_dataset$cholesterol_total >= chol_lower & cleaned_dataset$cholesterol_total <= chol_upper, ] 
nrow(after_removal) 
nrow(cleaned_dataset) - nrow(after_removal) 
outlier_handled <- cleaned_dataset 
outlier_handled$cholesterol_total <- ifelse(outlier_handled$cholesterol_total > chol_upper, chol_upper, outlier_handled$cholesterol_total) 
outlier_handled$triglycerides <- ifelse(outlier_handled$triglycerides > trig_upper, trig_upper, outlier_handled$triglycerides) 
summary(cleaned_dataset$cholesterol_total) 
summary(outlier_handled$cholesterol_total) 
summary(cleaned_dataset$triglycerides) 
summary(outlier_handled$triglycerides) 
nrow(outlier_handled) 

type_converted <- outlier_handled 
str(type_converted$age) 
type_converted$age_group <- cut( 
  type_converted$age, 
  breaks = c(17, 34, 49, 64, Inf), 
  labels = c("18-34", "35-49", "50-64", "65+") 
) 
str(type_converted$age_group) 
table(type_converted$age_group) 
type_converted$family_history_diabetes <- factor( 
  
  type_converted$family_history_diabetes, 
  levels = c(0, 1), 
  labels = c("No", "Yes") 
) 

type_converted$hypertension_history <- factor( 
  
  type_converted$hypertension_history, 
  levels = c(0, 1), 
  labels = c("No", "Yes") 
) 

type_converted$cardiovascular_history <- factor( 
  type_converted$cardiovascular_history, 
  levels = c(0, 1), 
  labels = c("No", "Yes") 
) 
str(type_converted[, c( 
  
  "family_history_diabetes", 
  "hypertension_history", 
  "cardiovascular_history" 
)]) 
table(type_converted$hypertension_history) 

normalized_data <- type_converted
min_bmi <- min(normalized_data$bmi, na.rm = TRUE)
max_bmi <- max(normalized_data$bmi, na.rm = TRUE)
normalized_data$bmi_normalized <- (normalized_data$bmi - min_bmi) / (max_bmi - min_bmi)
summary(normalized_data$bmi_normalized)
range(normalized_data$bmi_normalized, na.rm = TRUE)

sum(duplicated(normalized_data))

duplicate_removed <- normalized_data[!duplicated(normalized_data), ]

sum(duplicated(duplicate_removed))

nrow(duplicate_removed)
ncol(duplicate_removed)

filtered_data <- subset(duplicate_removed, age >= 40 & bmi >= 25)
nrow(filtered_data)
ncol(filtered_data)
head(filtered_data)
summary(filtered_data[, c("age", "bmi")])

sum(filtered_data$age < 18 | filtered_data$age > 100)

sum(filtered_data$sleep_hours_per_day < 0 | filtered_data$sleep_hours_per_day > 24)

sum(filtered_data$systolic_bp < filtered_data$diastolic_bp)

invalid_data <- filtered_data[
  filtered_data$age < 18 |
    filtered_data$age > 100 |
    filtered_data$sleep_hours_per_day < 0 |
    filtered_data$sleep_hours_per_day > 24 |
    filtered_data$systolic_bp < filtered_data$diastolic_bp,
]

nrow(invalid_data)
valid_data <- filtered_data[
  !(filtered_data$age < 18 |
      filtered_data$age > 100 |
      filtered_data$sleep_hours_per_day < 0 |
      filtered_data$sleep_hours_per_day > 24 |
      filtered_data$systolic_bp < filtered_data$diastolic_bp),
]
nrow(valid_data)
ncol(valid_data)

feature_data <- valid_data
feature_data$glucose_difference <- feature_data$glucose_postprandial - feature_data$glucose_fasting
head(feature_data[, c("glucose_fasting", "glucose_postprandial", "glucose_difference")])
nrow(feature_data)
ncol(feature_data)
summary(feature_data$glucose_difference)

table(feature_data$diagnosed_diabetes)
prop.table(table(feature_data$diagnosed_diabetes)) * 100

set.seed(123)
class_groups <- split(feature_data, feature_data$diagnosed_diabetes)
min_class <- min(table(feature_data$diagnosed_diabetes))
undersampled_data <- do.call(rbind, lapply(class_groups, function(x) {
  x[sample(seq_len(nrow(x)), min_class), ]
}))
table(undersampled_data$diagnosed_diabetes)
nrow(undersampled_data)

set.seed(123)
max_class <- max(table(feature_data$diagnosed_diabetes))
oversampled_data <- do.call(rbind, lapply(class_groups, function(x) {
  x[sample(seq_len(nrow(x)), max_class, replace = TRUE), ]
}))
table(oversampled_data$diagnosed_diabetes)
nrow(oversampled_data)

set.seed(123)
class_labels <- unique(feature_data$diagnosed_diabetes)
train_indices <- unlist(lapply(class_labels, function(cl) {
  class_indices <- which(feature_data$diagnosed_diabetes == cl)
  sample(class_indices, floor(0.8 * length(class_indices)))
}))
train_data <- feature_data[train_indices, ]
test_data <- feature_data[-train_indices, ]
nrow(train_data)
nrow(test_data)
table(train_data$diagnosed_diabetes)
table(test_data$diagnosed_diabetes)
prop.table(table(train_data$diagnosed_diabetes)) * 100
prop.table(table(test_data$diagnosed_diabetes)) * 100

bmi_original <- diabetes$bmi
sum(is.na(bmi_original))
summary(bmi_original)
bmi_mean <- bmi_original
bmi_mean[is.na(bmi_mean)] <- mean(bmi_original, na.rm = TRUE)
sum(is.na(bmi_mean))
summary(bmi_mean)
bmi_median <- bmi_original
bmi_median[is.na(bmi_median)] <- median(bmi_original, na.rm = TRUE)
sum(is.na(bmi_median))
summary(bmi_median)

sd_before <- sd(bmi_original, na.rm = TRUE)
sd_mean <- sd(bmi_mean)
sd_median <- sd(bmi_median)
sd_before
sd_mean
sd_median

summary(bmi_original)
summary(bmi_mean)
summary(bmi_median)
par(mfrow = c(1, 3))
hist(bmi_original, main = "Before Imputation", xlab = "BMI")
hist(bmi_mean, main = "Mean Imputation", xlab = "BMI")
hist(bmi_median, main = "Median Imputation", xlab = "BMI")
par(mfrow = c(1, 1))

numerical_vars <- c("age", "bmi", "glucose_fasting", "hba1c", "cholesterol_total")
task13_results <- do.call(rbind, lapply(sort(unique(feature_data$diagnosed_diabetes)), function(cl) {
  
  group_data <- subset(feature_data, diagnosed_diabetes == cl)
  
  data.frame(
    Target_Class = cl,
    Variable = numerical_vars,
    Count = sapply(group_data[numerical_vars], function(x) sum(!is.na(x))),
    Mean = sapply(group_data[numerical_vars], mean, na.rm = TRUE),
    Median = sapply(group_data[numerical_vars], median, na.rm = TRUE),
    Standard_Deviation = sapply(group_data[numerical_vars], sd, na.rm = TRUE),
    Minimum = sapply(group_data[numerical_vars], min, na.rm = TRUE),
    Maximum = sapply(group_data[numerical_vars], max, na.rm = TRUE)
  )
}))

task13_results


gender_data <- subset(feature_data, gender %in% c("Male", "Female"))

task14_results <- aggregate(
  bmi ~ gender,
  data = gender_data,
  FUN = mean
)

task14_results

task15_groups <- split(feature_data, feature_data$smoking_status)

task15_results <- do.call(rbind, lapply(names(task15_groups), function(cl) {
  
  group_data <- task15_groups[[cl]]
  
  values <- group_data$physical_activity_minutes_per_week
  
  data.frame(
    Smoking_Status = cl,
    Count = sum(!is.na(values)),
    IQR = IQR(values, na.rm = TRUE),
    Standard_Deviation = sd(values, na.rm = TRUE),
    Variance = var(values, na.rm = TRUE),
    Range = max(values, na.rm = TRUE) - min(values, na.rm = TRUE)
  )
}))

task15_results

