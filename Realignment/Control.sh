java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T RealignerTargetCreator -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -I ../Control.sorted.bam -o realigner.intervals

java -jar /Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/GenomeAnalysisTK.jar -T IndelRealigner -R /Users/albertolupatin/Desktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta -I ../Control.sorted.bam -targetIntervals realigner.intervals -o Control.sorted.realigned.bam
