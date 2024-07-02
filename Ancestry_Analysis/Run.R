library(EthSEQ)

setwd("/Users/albertolupatin/Desktop/HumanGenomics/Project/9-AncestryAnalysis")

ethseq.Analysis(
  target.vcf = "/Users/albertolupatin/Desktop/HumanGenomics/Project/Tumor/6-VariantCalling/Tumor.GATK.vcf",
  out.dir = "./results/",
  model.gds = "./ReferenceModel.gds",
  cores=1,
  verbose=TRUE,
  composite.model.call.rate = 0.99,
  space="3D",)
