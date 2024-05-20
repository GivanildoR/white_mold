######
#Identifying the 15 lesser values to BLUP for each trait:
#Givanildo Silva
#05/20/24


library(readxl)
blupsbl <- read_xlsx("G:/Meu Drive/Projetos/Feijão/White Mold - final/Phenotype_BL.xlsx", sheet = "BLUP")
blupsbl <- blupsbl[,-c(7,10,13,17)]

# Extract numeric columns starting from the 5th column
numeric_df <- blupsbl[, 5:ncol(blupsbl)]

# Initialize an empty list to store results
lesser_genotypes <- list()

# Iterate through each numeric column
for (column_name in colnames(numeric_df)) {
  # Sort the dataframe by the current column and get the top 15 rows with the smallest values
  top_15 <- blupsbl[order(blupsbl[[column_name]]), ][1:15, ]
  
  # Extract the genotypes (first column) for these rows and preserve column names
  lesser_genotypes[[column_name]] <- top_15[, 1]
}
library(tibble)
# Convert the results to a dataframe for better visualization (optional)
lesser_genotypes_df <- as_tibble(lesser_genotypes)

# Display the result
print(lesser_genotypes_df)

# Count the appearances of each genotype across all traits
library(dplyr)
genotype_counts <- lesser_genotypes_df %>%
  unlist() %>%
  table() %>%
  as.data.frame() %>%
  arrange(desc(Freq))

# Rename the columns for better understanding
colnames(genotype_counts) <- c("Genotype", "Count")

# Display the result
print(genotype_counts)

#End


######
#####Creating an incidence matrix

# Extract numeric columns starting from the 5th column
numeric_df <- blupsbl[, 5:ncol(blupsbl)]

# Initialize an empty dataframe for the incidence matrix with all values set to 0
genotypes <- blupsbl[, 1]
incidence_matrix <- data.frame(matrix(0, nrow = nrow(blupsbl), ncol = ncol(numeric_df)))
colnames(incidence_matrix) <- colnames(numeric_df)
rownames(incidence_matrix) <- genotypes[[1]]

# Iterate through each numeric column
for (column_name in colnames(numeric_df)) {
  # Sort the dataframe by the current column and get the top 15 rows with the smallest values
  top_15 <- blupsbl[order(blupsbl[[column_name]]), ][1:15, ]
  
  # Mark the presence of each genotype in the top 15 with 1
  incidence_matrix[as.character(top_15[[1]]), column_name] <- 1
}

# Display the incidence matrix
print(incidence_matrix)
