library(DNAcopy)

folder = "/Users/albertolupatin/Desktop/HumanGenomics/Project/SomaticCopyNumber"
cn <- read.table(file.path(folder,"SCNA.copynumber.called"),header=T)

pdf("/Users/albertolupatin/Desktop/HumanGenomics/Project/SomaticCopyNumber/SegPlot.pdf")

plot(cn$raw_ratio,pch=".",ylim=c(-2.5,2.5))
plot(cn$adjusted_log_ratio,pch=".",ylim=c(-2.5,2.5))
CNA.object <-CNA(genomdat = cn$adjusted_log_ratio, 
                 chrom = cn$chrom,
                 maploc = cn$chr_start, data.type = 'logratio')
CNA.smoothed <- smooth.CNA(CNA.object)
segs <- segment(CNA.smoothed, min.width=2,
                undo.splits="sdundo", #undoes splits that are not at least this many SDs apart.
                undo.SD=3,verbose=1)

plot(segs,plot.type="w")

dev.off()

segs2 = segs$output
write.table(segs2, file=file.path(folder,"SCNA.copynumber.called.seg"), row.names=F, col.names=T, quote=F, sep="\t")
