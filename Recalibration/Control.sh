java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T BaseRecalibrator -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -I Control/Control.sorted.bam -knownSites /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/hapmap_3.3.b37.vcf -o recal.table 

java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T PrintReads -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -I Control/Control.sorted.bam -BQSR recal.table -o Control.sorted.recalibrated.bam

java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar  -T BaseRecalibrator -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -I Control/Control.sorted.bam -knownSites /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/hapmap_3.3.b37.vcf -BQSR recal.table -o after_recal.table

java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T AnalyzeCovariates -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -before recal.table -after after_recal.table -csv recal.csv -plots recal.pdf

samtools view Control.sorted.recalibrated.bam | grep OQ | wc -l

