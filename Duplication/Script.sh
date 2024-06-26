java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/picard.jar MarkDuplicates I=../Tumor.sorted.bam O=Tumor.sorted.dedup.bam REMOVE_DUPLICATES=true TMP_DIR=/tmp METRICS_FILE=Tumor.picard.log ASSUME_SORTED=true
samtools index Tumor.sorted.dedup.bam 

samtools sort -n ../Tumor.bam > Tumor.nsorted.bam #Sort by name
samtools fixmate -m Tumor.nsorted.bam Tumor.nsorted.fixed.bam #Fix by mate
samtools sort Tumor.nsorted.fixed.bam > Tumor.nsorted.fixed.sorted.bam #Sort by position
samtools markdup -sr Tumor.nsorted.fixed.sorted.bam Tumor.nsorted.fixed.sorted.dedup.bam #Mark Duplicates

ARRIVATO QUI

samtools flagstat Tumor.sorted.dedup.bam
samtools flagstat Tumor.nsorted.fixed.sorted.dedup.bam #We removed more reads because we have found more duplicates; there aren't no reads which mate is found in another chromosome 

samtools index Tumor.sorted.dedup.bam
samtools index Tumor.nsorted.fixed.sorted.dedup.bam

java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T RealignerTargetCreator -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -I ../Tumor.sorted.bam -o realigner.intervals
java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T IndelRealigner -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -I ../Tumor.sorted.bam -targetIntervals realigner.intervals -o Tumor.sorted.realigned.bam

java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T BaseRecalibrator -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -I Tumor.sorted.realigned.bam -knownSites /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/hapmap_3.3.b37.vcf -o recal.table
java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T PrintReads -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -I Tumor.sorted.realigned.bam -BQSR recal.table -o Tumor.sorted.realigned.recalibrated.bam --emit_original_quals

java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/picard.jar MarkDuplicates I=Tumor.sorted.realigned.recalibrated.bam O=Tumor.sorted.realigned.recalibrated.dedup.bam REMOVE_DUPLICATES=true TMP_DIR=/tmp METRICS_FILE=Tumor.sorted.realigned.recalibrated.picard.log ASSUME_SORTED=true
samtools index Tumor.sorted.realigned.recalibrated.dedup.bam

