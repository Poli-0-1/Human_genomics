java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T RealignerTargetCreator -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -I ../Tumor.sorted.bam -o realigner.intervals

java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T IndelRealigner -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -I ../Tumor.sorted.bam -targetIntervals realigner.intervals -o Tumor.sorted.realigned.bam
