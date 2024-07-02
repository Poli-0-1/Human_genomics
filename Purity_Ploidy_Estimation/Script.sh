bcftools mpileup -Ou -a DP -f /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta ../Control/Control.sorted.bam | bcftools call -Ov -c -v > Control.BCF.vcf

grep -E "(^#|0/1)" Control.BCF.vcf > Control.het.vcf

awk 'NR==FNR {pos[$1]; next} !($2 in pos) || /^#/' $pos_to_remove $input_vcf > $output_vcf
java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T ASEReadCounter -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -o Control.csv -I ../Control/Control.sorted.bam -sites Control.filteredv4.vcf -U ALLOW_N_CIGAR_READS -minDepth 20 --minMappingQuality 20 --minBaseQuality 20

java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T ASEReadCounter -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -o Tumor.csv -I ../Tumor/Tumor.sorted.bam -sites Control.filteredv4.vcf -U ALLOW_N_CIGAR_READS -minDepth 20 --minMappingQuality 20 --minBaseQuality 20



