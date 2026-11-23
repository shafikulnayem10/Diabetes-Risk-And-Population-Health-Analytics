# Diabetes Risk Analysis – Data Science Project

Introduction to Data Science (IDS) midterm project, **Section E, Group 10**, American International University-Bangladesh (AIUB), Fall 2026-27.

The project takes a Kaggle diabetes dataset and runs it through a full data pre-processing and basic analysis pipeline in **R**: cleaning, outlier handling, feature engineering, balancing, splitting and group-wise statistics.

## Team

| Member | Tasks |
| --- | --- |
| Shafiqul Islam Nayem | 1 – 4 |
| Farhan Kabir | 5 – 8 |
| Syeda Tahsin Hasan | 9 – 12 |
| Hasibul Alam | 13 – 15 |

## Dataset

- File: `data/diabetes_dataset.csv`
- Size: 100,000 rows x 31 columns
- Target: `diagnosed_diabetes` (0 = No, 1 = Yes)
- Column groups:
  - Demographics: `age`, `gender`, `ethnicity`, `education_level`, `income_level`, `employment_status`
  - Lifestyle: `smoking_status`, `alcohol_consumption_per_week`, `physical_activity_minutes_per_week`, `diet_score`, `sleep_hours_per_day`, `screen_time_hours_per_day`
  - History: `family_history_diabetes`, `hypertension_history`, `cardiovascular_history`
  - Clinical: `bmi`, `waist_to_hip_ratio`, `systolic_bp`, `diastolic_bp`, `heart_rate`, `cholesterol_total`, `hdl_cholesterol`, `ldl_cholesterol`, `triglycerides`, `glucose_fasting`, `glucose_postprandial`, `insulin_level`, `hba1c`
  - Outcome: `diabetes_risk_score`, `diabetes_stage`, `diagnosed_diabetes`

## Project structure

```
.
├── Diabetes_Project.Rproj     RStudio project file
├── R/
│   └── Main.R                 Full group script (Tasks 1-15)
├── data/
│   └── diabetes_dataset.csv   Dataset
└── docs/
    ├── IDS MIdterm Project_Fall_26-27.pdf   Project instructions
    ├── Diabetes-report_Sec-E.pdf            Submitted report
    └── ... Viva Preparation Guide ... .pdf  Viva preparation notes
```

## Tasks covered

| # | Task |
| --- | --- |
| 1 | Load the dataset, inspect structure, introduce missing values, invalid values and duplicates |
| 2 | Handle missing values: deletion, mean, median and mode imputation |
| 3 | Detect outliers with the IQR rule (1.5 x IQR) and handle them by removal and capping |
| 4 | Type conversion: factors and age groups with `cut()` |
| 5 | Remove duplicate rows |
| 6 | Verify duplicate removal |
| 7 | Filter records (`age >= 40` and `bmi >= 25`) |
| 8 | Detect and remove invalid data (age, sleep hours, blood pressure) |
| 9 | Min-Max normalization |
| 10 | Feature engineering |
| 11 | Class imbalance: under-sampling and over-sampling |
| 12 | Compare mean vs median imputation by standard deviation and histograms |
| 13 | Train / test split (80 / 20, stratified) |
| 14 | Average BMI by gender using `aggregate()` |
| 15 | Variability (IQR, SD, variance, range) by smoking status using `split()` and `lapply()` |

## Requirements

- R (4.x recommended)
- RStudio (optional but convenient)
- Base R only, no extra packages needed

## How to run

1. Clone or download the repository.
2. Open `Diabetes_Project.Rproj` in RStudio, so the working directory is the project root.
3. In `R/Main.R`, change the first line to a relative path:

   ```r
   diabetes_original <- read.csv("data/diabetes_dataset.csv", header = TRUE, sep = ",")
   ```

   The script currently points to `D:/10th Sem/Data Science/Project/diabetes_dataset.csv`, which only exists on one machine.
4. Run the script top to bottom (`Ctrl + Shift + Enter` in RStudio).

## Important notes

- The script is sequential. Each task reuses the data frame produced by the previous task, so run it in order.
- Task 7 filters the data (`age >= 40`, `bmi >= 25`) and later tasks continue from that subset, so Tasks 8 to 15 describe the filtered rows (about 44.7k), not the full 100k.
- Invalid and missing values are injected on purpose in Task 1 so the cleaning tasks have something to fix. Results therefore depend on that injection.
- Course rule: no comments are allowed inside the R program.

## Git workflow for the team

- Each member works in their own file under `R/` (for example `R/Nayem_Tasks_1_to_4.R`) to avoid merge conflicts.
- R variables are not shared between files. To pass data on, save it with `write.csv(..., row.names = FALSE)` into `data/` and read it in the next file.
- Use a branch per member and open a pull request into `main`.

## Submission

Files are named `Group No_Dataset`, `Group No_R_File`, `Group No_Report_Section name` (here: Group 10, Section E).

## License

Academic coursework. The dataset comes from Kaggle and remains subject to its original license.
