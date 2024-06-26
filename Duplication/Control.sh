java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/picard.jar MarkDuplicates I= ../Control.sorted.bam O=Control.sorted.dedup.bam REMOVE_DUPLICATES=true TMP_DIR=/tmp METRICS_FILE=Control.picard.log ASSUME_SORTED=true
samtools index Control.sorted.dedup.bam 

samtools sort -n ../Control.bam > Control.nsorted.bam #Sort by name
samtools fixmate -m Control.nsorted.bam Control.nsorted.fixed.bam #Fix by mate
samtools sort Control.nsorted.fixed.bam > Control.nsorted.fixed.sorted.bam #Sort by position
samtools markdup -sr Control.nsorted.fixed.sorted.bam Control.nsorted.fixed.sorted.dedup.bam #Mark Duplicates

samtools flagstat Control.sorted.dedup.bam
samtools flagstat Control.nsorted.fixed.sorted.dedup.bam #We removed more reads because we have found more duplicates; there aren't no reads which mate is found in another chromosome 

samtools index Control.sorted.dedup.bam
samtools index Control.nsorted.fixed.sorted.dedup.bam

java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T RealignerTargetCreator -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -I ../Control.sorted.bam -o realigner.intervals
java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T IndelRealigner -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -I ../Control.sorted.bam -targetIntervals realigner.intervals -o Control.sorted.realigned.bam

java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T BaseRecalibrator -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -I Control.sorted.realigned.bam -knownSites /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/hapmap_3.3.b37.vcf -o recal.table
java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T PrintReads -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -I Control.sorted.realigned.bam -BQSR recal.table -o Control.sorted.realigned.recalibrated.bam --emit_original_quals

java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/picard.jar MarkDuplicates I=Control.sorted.realigned.recalibrated.bam O=Control.sorted.realigned.recalibrated.dedup.bam REMOVE_DUPLICATES=true TMP_DIR=/tmp METRICS_FILE=Control.sorted.realigned.recalibrated.picard.log ASSUME_SORTED=true
samtools index Control.sorted.realigned.recalibrated.dedup.bam

