library("GenomeInfoDb", lib.loc = "~/R/Packages")
library("GenomicRanges", lib.loc = "/home/gelde036/R/Packages")
library(DNAshapeR, lib.loc="/home/gelde036/R/Packages")
library(seqinr, lib.loc="/home/gelde036/R/Packages")

args <- commandArgs(trailingOnly=T)  

file = args[1]

pred = getShape(file)
ylim_vector <- cbind(c(3,6), c(33,35.5), c(-10,-4), c(-3,2))

#png(paste(file, 'DNAshapes_plot.png', sep="."))

par(mfrow=c(2,2))

for (i in 1:4) {
meansd<-mean(apply(pred[[i]], 1, function(x) sd(x, na.rm=T)))
plotShape(pred[[i]], colLine= 'red', main=paste(names(pred)[i], meansd), ylim = ylim_vector[,i])
} 

#dev.off()


fas = read.fasta(file, seqtype="DNA", as.string=T)

seqlen= c()

for (i in 1:4) { 
  
  rownames(pred[[i]]) = names(fas)
  
  pred[[i]] = data.frame(pred[[i]])
  
  seqlen[i] = ncol(pred[[i]]) # sequence length 
}


for (i in 1:4) {
  mean <- apply(pred[[i]], 1, function(x) mean(x, na.rm=T))
  max <- apply(pred[[i]], 1, function(x) max(x, na.rm=T))
  min <- apply(pred[[i]], 1, function(x) min(x, na.rm=T))
  pred[[i]] = cbind(pred[[i]], 	mean ,max, min )
  
}

for (i in 1:4) { 
  
  n = ncol(pred[[i]])
  
  for (j in 1:ncol(pred[[i]])) { colnames(pred[[i]])[j] = paste(names(pred)[i], colnames(pred[[i]])[j], sep=".") }
  
  write.table(pred[[i]][,(n-2):n], file=paste(file, names(pred)[i], "txt" ,sep="."), sep="\t", col.names=T, row.names=F,append=FALSE, quote=FALSE) 
}
