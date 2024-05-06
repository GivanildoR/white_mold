```R
setwd("G:/Meu Drive/Projetos/Feijão/White Mold - final")

install.packages("readxl")
library(readxl)

dados <- read_xlsx("G:/Meu Drive/Projetos/Feijão/White Mold - final/Phenotype_BL.xlsx", sheet = "Planilha2", range =  "A1:G115")
Evaluated <- read_xlsx("G:/Meu Drive/Projetos/Feijão/White Mold - final/Phenotype_BL.xlsx", sheet = "Planilha2", range =  "J1:J115")
Evaluated <- na.omit(Evaluated)
names(Evaluated)[1] <- "Accession"
  
library(dplyr)
dados1 <- inner_join(Evaluated, dados, by = "Accession")

data <- as.data.frame(table(dados1$State))
data$Var1 <- as.character(data$Var1)
data$Var1[data$Var1 == "MT"] <- "Mato Grosso"
data$Var1[data$Var1 == "NA"] <- "NA"
data$Var1[data$Var1 == "PB"] <- "Paraíba"
data$Var1[data$Var1 == "PE"] <- "Pernambuco"
data$Var1[data$Var1 == "PR"] <- "Paraná"
data$Var1[data$Var1 == "SE"] <- "Sergipe"


library(sf)
library(ggplot2)

install.packages("rnaturalearth")
library(rnaturalearth)
install.packages("devtools")
library(rnaturalearth)


brazil_states <- ne_states(country = "Brazil", returnclass = "sf")

brazil_map <- merge(brazil_states, data, by.x = "name", by.y = "Var1", all.x = TRUE)

plot <- ggplot(data = brazil_map) +
  geom_sf(aes(fill = Freq), color = "white", size = 0.2) +
  scale_fill_viridis_c(na.value = "grey", name = "Number of accession") +
  #labs(title = "Origin of BL panel") +
  theme_minimal()

stateless_data_value <- 2  # value to showing in the plot 
plot + annotate("text", x = -60, y = -33, label = paste("Stateless Data:", stateless_data_value), size = 2, color = "red")
```
