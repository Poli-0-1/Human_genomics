bcftools mpileup -Ou -a DP -f /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta ../Tumor.sorted.bam | bcftools call -Ov -c -v > Tumor.BCF.vcf

java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T UnifiedGenotyper -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -I ../Tumor.sorted.bam -o Tumor.GATK.vcf

vcftools --minQ 20 --max-meanDP 200 --min-meanDP 5 --remove-indels --vcf Tumor.BCF.vcf --out Tumor.BCF --recode --recode-INFO-all

vcftools --minQ 20 --max-meanDP 200 --min-meanDP 5 --remove-indels --vcf Tumor.GATK.vcf --out Tumor.GATK --recode --recode-INFO-all

grep -v -E '^(13|GL000203.1|GL000228.1|GL000213.1|GL000216.1|GL000192.1)\b' Tumor.GATK.recode.vcf > Tumor.GATK.recode.filtered.vcf
vcftools --vcf Tumor.BCF.recode.vcf --diff Tumor.GATK.recode.vcf --diff-site --not-chr GL000198.1