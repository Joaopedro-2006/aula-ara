library(readr)
diabetes <- read_csv("diabetes_dataset.csv")

# Verificar estrutura
glimpse(diabetes)


# Remove todas as linhas em que a coluna "diabetes_stage" seja "No Diabetes"
db <- diabetes[diabetes$diabetes_stage != "No Diabetes", ]
db
db_100 <- head(db, 100)
View(db_100)
