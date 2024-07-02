setwd("/Users/albertolupatin/Desktop/HumanGenomics/Project/9-AncestryAnalysis")

library(vcfR)

vcfR <- read.vcfR("../10-PurityPloidyEstimation/Tumor.BCF.vcf")

vcf <- as.data.frame(vcfR@fix)

pos_vcf <- unique(vcf$POS)

freq <- table(pos_vcf)

duplicates <- names(freq[freq > 1])

vcf <- vcf[vcf$CHROM %in% out_chr,]