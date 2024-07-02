setwd("/Users/albertolupatin/Desktop/HumanGenomics/Project/10-PurityPloidyEstimation")

library(vcfR)

Control <- read.vcfR("Control.het.vcf")
ct <- as.data.frame(Control@fix)

ct_subset <- ct[, c("CHROM", "POS")]

# Trova i duplicati considerando entrambe le colonne
duplicati <- duplicated(ct_subset) | duplicated(ct_subset, fromLast = TRUE)

# Ottieni gli indici delle righe che sono duplicate
indici_duplicati <- which(duplicati)
pos_datogliere <- ct$POS[indici_duplicati]

file <- file("indexes.txt")    
writeLines(pos_datogliere, file)    
close(file)

ct_filtered <- ct[-indici_duplicati,]
ct_filtered <- as.matrix(ct_filtered)

Control@fix <- ct_filtered

library(VariantAnnotation)
writeVcf(Control, file = "Control.filteredv2.vcf")


Control2 <- readVcf("Control.het.vcf")
ct <- as.data.frame(Control@fix)

ct_subset <- ct[, c("CHROM", "POS")]

# Trova i duplicati considerando entrambe le colonne
duplicati <- duplicated(ct_subset) | duplicated(ct_subset, fromLast = TRUE)

# Ottieni gli indici delle righe che sono duplicate
indici_duplicati <- which(duplicati)

ct_filtered <- ct[-indici_duplicati,]
ct_filtered <- as.matrix(ct_filtered)

Control@fix <- ct_filtered


VC_gatk <- read.delim("6-VariantCalling/GATK.vcf")

chr_vcf <- unique(VC_vcf$X.CHROM)
chr_gatk <- unique(VC_gatk$X.CHROM)

setdiff(chr_gatk, chr_vcf)
