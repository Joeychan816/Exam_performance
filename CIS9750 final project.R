library(ggplot2)
library(regclass)
student_data <- read.csv("C:/Users/jazia/Downloads/student_habits_performance.csv")
#remove any NAs
student_data <- na.omit(student_data) 
student_data

library(stringr)
#space and capitalize column names
names(student_data) <- str_replace_all(names(student_data),'_',' ')
names(student_data) <- str_to_title(names(student_data))
names(student_data) <- str_replace_all(names(student_data),' ','.')
names(student_data)
student_data

#combine two columns to create a new one: Screen Time
student_data$'Total.Screen.Time' <- student_data$`Social.Media.Hours` + student_data$`Netflix.Hours`
student_data$'Total.Screen.Time'

#convert part time job & extracurric. participation to binary variables
student_data$'Part.Time.Job'<- ifelse(student_data$'Part.Time.Job' == 'No',0,1)
unique(student_data$`Part.Time.Job`)
student_data$'Extracurricular.Participation'<- ifelse(student_data$'Extracurricular.Participation' == 'No',0,1)
student_data

#if statement for part time job, extracurricular activities or both
#0 = none, 1 = participates in extracurric. only, 2 = part time job only, 3 = both
student_data$'Responsibilities' <- ifelse(student_data$'Part.Time.Job' == 0 & student_data$'Extracurricular.Participation' == 0,0,
                                          ifelse(student_data$'Part.Time.Job' == 0 & student_data$'Extracurricular.Participation' == 1,1,
                                                 ifelse(student_data$'Part.Time.Job' == 1 & student_data$'Extracurricular.Participation' == 0,2,
                                                        3)))
student_data$'Responsibilities' 
student_data

all_correlations(student_data, interest = 'Exam.Score', sorted="magnitude") #displays correlation of exam score variable

qq(student_data$Exam.Score) #qqplot of Exam.Score, median provides better summary
summary(student_data$Exam.Score) #summary of exam score

Score.Study <- lm(Exam.Score ~ Study.Hours.Per.Day, data = student_data) #assign linear model to variable
summary(Score.Study) #intercept, coefficient, Rsquared, p values
associate(Exam.Score~Study.Hours.Per.Day, data=student_data) #spearman's  rank value and p value better. 
ggplot(student_data, aes(x=Study.Hours.Per.Day, y=Exam.Score))+
  geom_point(size=1)+
  geom_smooth(method = "lm", se = FALSE, color = "purple")
confint(Score.Study,level=.95)

Score.Mental <- lm(Exam.Score ~ Mental.Health.Rating, data = student_data) #assign linear model to variable
summary(Score.Mental)
associate(Exam.Score~Mental.Health.Rating, data=student_data) #spearman's  rank value and p value better. 
ggplot(student_data, aes(x=Mental.Health.Rating, y=Exam.Score))+
  geom_point(size=1)+
  geom_smooth(method = "lm", se = FALSE, color = "orange")
confint(Score.Mental,level=.95)

Score.Screen <- lm(Exam.Score ~ Total.Screen.Time, data = student_data) #assign linear model to variable
summary(Score.Screen)
associate(Exam.Score~Total.Screen.Time, data=student_data) #spearman's  rank value and p value better. 
ggplot(student_data, aes(x=Total.Screen.Time, y=Exam.Score))+
  geom_point(size=1)+
  geom_smooth(method = "lm", se = FALSE, color = "red")
confint(Score.Screen, level=0.95)

Score.Exercise <- lm(Exam.Score ~ Exercise.Frequency, data = student_data) #assign linear model to variable
summary(Score.Exercise)
associate(Exam.Score~Exercise.Frequency, data=student_data) #spearman's  rank value and p value better. 
ggplot(student_data, aes(x=Exercise.Frequency, y=Exam.Score))+
  geom_point(size=1)+
  geom_smooth(method = "lm", se = FALSE, color = "blue")
confint(Score.Exercise,level=.95)

Score.Sleep <- lm(Exam.Score ~ Sleep.Hours, data = student_data) #assign linear model to variable
summary(Score.Sleep)
associate(Exam.Score~Sleep.Hours, data=student_data) #spearman's  rank value and p value better. 
ggplot(student_data, aes(x=Sleep.Hours, y=Exam.Score))+
  geom_point(size=1)+
  geom_smooth(method = "lm", se = FALSE, color = "pink")
confint(Score.Sleep, level=.95)

Multi.Model <- lm(Exam.Score ~ Study.Hours.Per.Day + Mental.Health.Rating + Total.Screen.Time + Exercise.Frequency + Sleep.Hours, data = student_data) #assign linear model to variable
summary(Multi.Model)
confint(Multi.Model)

#heatmap with ONLY EXAM.SCORE
num_data <- student_data[sapply(student_data, is.numeric)] # Select only numeric columns from student_data
exam_cor <- cor(num_data, use = "complete.obs")["Exam.Score", ] # Calculate correlations of all numeric variables with Exam.Score as interest
cor_df <- data.frame(Variable = names(exam_cor), Correlation = exam_cor) # Convert correlation vector to a data frame
# Plot using circles
ggplot(cor_df, aes(x = Variable, y = 0, color = Correlation, size = abs(Correlation))) + #ggplot using Correlation column to differentiate and absolute value of correlation as size
  geom_point() + #create points via geom_point()
  scale_color_gradient2(low = "red", mid = "purple", high = "blue", midpoint = 0) +
  scale_size(range = c(1, 10)) +
  labs(title = "Correlation with Exam.Score", x = "", y = "", size = "Strength") +
  theme_minimal() +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x = element_text(angle = 45, hjust = 1))

#heatmap with ALL correlations listed
install.packages("corrplot") #install corrplot package (correlation plot)
library(corrplot) #library
corr_matrix <- cor(student_data[sapply(student_data, is.numeric)]) #select only numeric columns from student_data
corrplot(corr_matrix, method = "color", type = "upper") #create correlation plot with color as difference and shown in upper

