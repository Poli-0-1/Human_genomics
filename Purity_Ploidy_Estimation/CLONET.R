library(data.table)
library(CLONETv2)
library(TPES)

setwd("/Users/albertolupatin/Desktop/HumanGenomics/Project/10-PurityPloidyEstimation")

Control = fread("Control.csv",data.table=F)
Control$af = Control$altCount/Control$totalCount
tumor = fread("Tumor.csv",data.table=F)
tumor$af = tumor$altCount/tumor$totalCount

pileup.Control = Control[,c(1,2,4,5,14,8)]
colnames(pileup.Control) = c("chr","pos","ref","alt","af","cov")

pileup.tumor = tumor[,c(1,2,4,5,14,8)]
colnames(pileup.tumor) = c("chr","pos","ref","alt","af","cov")

seg.tb <- fread("../05-SomaticCopyNumberCalling/SCNA.copynumber.called.seg",data.table=F)

bt <- compute_beta_table(seg.tb, pileup.tumor, pileup.Control)

## Compute ploidy table with default parameters
pl.table <- compute_ploidy(bt)

adm.table <- compute_dna_admixture(beta_table = bt, ploidy_table = pl.table)

allele_specific_cna_table <- compute_allele_specific_scna_table(beta_table = bt,
                                                                ploidy_table = pl.table, 
                                                                admixture_table = adm.table)


check.plot <- check_ploidy_and_admixture(beta_table = bt, ploidy_table = pl.table,
                                         admixture_table = adm.table)

pdf("R-beta.pdf")
print(check.plot)
dev.off()

# TPES
library(vcfR)
snv.vcf <- read.vcfR("../8-SomaticVariantCalling/PointMutations/somatic.pm.ann.vcf")
snv.reads <- snv.vcf@fix
snv.reads <- as.data.frame(snv.reads)

snv.reads <- subset(snv.reads, grepl("SOMATIC", INFO))
snv.reads = snv.reads[,c("CHROM","POS","REF","ALT")]
colnames(snv.reads) = c("chr","pos","ref.count","alt.count")
snv.reads$sample = "Sample.1"

TPES_purity(ID = "Sample.1", SEGfile = seg.tb,
            SNVsReadCountsFile = snv.reads,
            ploidy = pl.table,
            RMB = 0.47, maxAF = 0.6, minCov = 10, minAltReads = 10, minSNVs = 1)

TPES_report(ID = "Sample.1", SEGfile = seg.tb,
            SNVsReadCountsFile = snv.reads,
            ploidy = pl.table,
            RMB = 0.47, maxAF = 0.6, minCov = 10, minAltReads = 10, minSNVs = 1)
