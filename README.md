# 📚 Student Habits and Exam Performance Analysis

This project analyzes how various lifestyle and study habits impact **exam performance** in students. Using a dataset of student behavior, we explore relationships between exam scores and factors such as study hours, mental health, screen time, exercise, and sleep.

---

## 📁 Dataset

- **Source**: `student_habits_performance.csv`
- **Imported From**: Local machine (`C:/Users/jazia/Downloads/`)
- **Cleaning Steps**:
  - Removed missing values (`NA`)
  - Standardized column names (capitalization, spaces, underscores)
  - Created new columns:
    - `Total.Screen.Time` = `Social.Media.Hours` + `Netflix.Hours`
    - `Responsibilities` = Encoded combo of extracurricular and part-time job status

---

## 🧠 Feature Engineering

- **Binary Encoding**:
  - `Part.Time.Job`: 1 = Yes, 0 = No
  - `Extracurricular.Participation`: 1 = Yes, 0 = No
- **Responsibility Levels**:
  - 0 = Neither job nor extracurriculars
  - 1 = Only extracurriculars
  - 2 = Only part-time job
  - 3 = Both activities

---

## 📈 Analysis Performed

### 🔢 Correlation Analysis
- Used `all_correlations()` to find most influential factors on `Exam.Score`
- Generated visual heatmaps to show:
  - Correlation with `Exam.Score` only
  - Correlation matrix of all numeric variables (`corrplot`)

### 📊 Exploratory Data Visualizations
- **QQ Plot**: Exam score distribution
- **Summary Statistics**: Min, Max, Median, Quartiles

### 📉 Linear Regressions (Single Variable)
Each model visualized with `ggplot2`:
- `Exam.Score ~ Study.Hours.Per.Day`
- `Exam.Score ~ Mental.Health.Rating`
- `Exam.Score ~ Total.Screen.Time`
- `Exam.Score ~ Exercise.Frequency`
- `Exam.Score ~ Sleep.Hours`

### 🧪 Multiple Linear Regression
- `Exam.Score ~ Study.Hours.Per.Day + Mental.Health.Rating + Total.Screen.Time + Exercise.Frequency + Sleep.Hours`
- Output includes coefficients, p-values, confidence intervals, and R-squared

---

## 📊 Key Visualizations

- **Scatterplots**: Show linear relationships between each feature and exam scores
- **Color Heatmap**: Correlation values with exam scores
- **Full Correlation Matrix**: Visualized with `corrplot`

---

## 📦 Packages Used

- `ggplot2`: Visualizations
- `regclass`: Correlation and association metrics
- `stringr`: String cleaning for column names
- `corrplot`: Correlation heatmaps
- `base` and `stats`: Core R functions for modeling and summaries

---

## 🚀 How to Run

1. Make sure you have the required packages:
   ```r
   install.packages(c("ggplot2", "regclass", "stringr", "corrplot"))
