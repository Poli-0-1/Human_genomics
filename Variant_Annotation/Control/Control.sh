java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/snpEff.jar -v hg19kg ../6-VariantCalling/Control.BCF.recode.vcf -s Control.BCF.recode.ann.html > Control.BCF.recode.ann.vcf
java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/SnpSift.jar Annotate /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/hapmap_3.3.b37.vcf  Control.BCF.recode.ann.vcf > Control.BCF.recode.ann2.vcf
java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/SnpSift.jar Annotate /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/clinvar_Pathogenic.vcf Control.BCF.recode.ann2.vcf > Control.BCF.recode.ann3.vcf

java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/snpEff.jar -v hg19kg ../6-VariantCalling/Control.GATK.recode.vcf -s Control.GATK.recode.ann.html > Control.GATK.recode.ann.vcf
java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/SnpSift.jar Annotate /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/hapmap_3.3.b37.vcf  Control.GATK.recode.ann.vcf > Control.GATK.recode.ann2.vcf
java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/SnpSift.jar Annotate /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/clinvar_Pathogenic.vcf Control.GATK.recode.ann2.vcf > Control.GATK.recode.ann3.vcf

cat Control.BCF.recode.ann3.vcf | java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/SnpSift.jar filter "(ANN[ANY].IMPACT = 'HIGH') & (DP > 20) & (exists ID)" 
cat Control.GATK.recode.ann3.vcf | java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/SnpSift.jar filter "(ANN[ANY].IMPACT = 'HIGH') & (DP > 20) & (exists ID)" 

cat Control.BCF.recode.ann3.vcf | java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/SnpSift.jar filter "(exists CLNSIG)"
cat Control.GATK.recode.ann3.vcf | java -Xmx4g -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/snpEff/SnpSift.jar filter "(exists CLNSIG)"

