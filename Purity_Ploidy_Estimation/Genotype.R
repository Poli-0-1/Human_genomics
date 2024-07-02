setwd("/Users/albertolupatin/Desktop/HumanGenomics/Project/10-PurityPloidyEstimation")

control <- read.delim2("Control.csv")
tumor <- read.delim2("Tumor.csv")

control$AF <- control$altCount / control$totalCount

library(dplyr)
control <- control %>%
  mutate(genotype = case_when(
    AF < 0.2 ~ "AA",
    AF > 0.2 & AF < 0.8 ~ "AB",
    AF > 0.8 ~ "BB"
  ))

tumor$AF <- tumor$altCount / tumor$totalCount

tumor <- tumor %>%
  mutate(genotype = case_when(
    AF < 0.2 ~ "AA",
    AF > 0.2 & AF < 0.8 ~ "AB",
    AF > 0.8 ~ "BB"
  ))