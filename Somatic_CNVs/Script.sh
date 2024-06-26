samtools mpileup -q 1 -f /Users/albertolupatin/ sktop/HumanGenomics/Labs/annotations/human_g1k_v37.fasta ../Control/Control.sorted.bam../Tumor/Tumor.sorted.bam | java-jar
/Users/albertolupatin/Desktop/HumanGenomics/Labs/tools/VarScan.v2.3.9.jar copynumber --output-file SCNA --mpileup
1
