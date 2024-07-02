java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/snpEff.jar -v hg19kg ../6-VariantCalling/Tumor.BCF.recode.vcf -s Tumor.BCF.recode.ann.html > Tumor.BCF.recode.ann.vcf
java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/SnpSift.jar Annotate /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/hapmap_3.3.b37.vcf  Tumor.BCF.recode.ann.vcf > Tumor.BCF.recode.ann2.vcf
java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/SnpSift.jar Annotate /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/clinvar_Pathogenic.vcf Tumor.BCF.recode.ann2.vcf > Tumor.BCF.recode.ann3.vcf

java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/snpEff.jar -v hg19kg ../6-VariantCalling/Tumor.GATK.recode.vcf -s Tumor.GATK.recode.ann.html > Tumor.GATK.recode.ann.vcf
java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/SnpSift.jar Annotate /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/hapmap_3.3.b37.vcf  Tumor.GATK.recode.ann.vcf > Tumor.GATK.recode.ann2.vcf
java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/SnpSift.jar Annotate /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/clinvar_Pathogenic.vcf Tumor.GATK.recode.ann2.vcf > Tumor.GATK.recode.ann3.vcf

cat Tumor.BCF.recode.ann3.vcf | java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/SnpSift.jar filter "(ANN[ANY].IMPACT = 'HIGH') & (DP > 20) & (exists ID)" 
cat Tumor.GATK.recode.ann3.vcf | java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/SnpSift.jar filter "(ANN[ANY].IMPACT = 'HIGH') & (DP > 20) & (exists ID)" 

cat Tumor.BCF.recode.ann3.vcf | java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/SnpSift.jar filter "(exists CLNSIG)"
cat Tumor.GATK.recode.ann3.vcf | java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/SnpSift.jar filter "(exists CLNSIG)"

