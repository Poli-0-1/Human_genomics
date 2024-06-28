bcftools mpileup -Ou -a DP -f /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta ../Control.sorted.bam | bcftools call -Ov -c -v > Control.BCF.vcf

java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T UnifiedGenotyper -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -I ../Control.sorted.bam -o Control.GATK.vcf

vcftools --minQ 20 --max-meanDP 200 --min-meanDP 5 --remove-indels --vcf Control.BCF.vcf --out Control.BCF --recode --recode-INFO-all

vcftools --minQ 20 --max-meanDP 200 --min-meanDP 5 --remove-indels --vcf Control.GATK.vcf --out Control.GATK --recode --recode-INFO-all

vcftools --vcf Control.BCF.recode.vcf --diff Control.GATK.recode.vcf --diff-site --not-chr GL000198.1