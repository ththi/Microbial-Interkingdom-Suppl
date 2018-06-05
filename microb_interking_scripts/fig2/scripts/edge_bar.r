test=read.table("dump.txt",header=F)
barplot(as.matrix(t(test[c(1,4,6,2,3,5),2:3])),names=test[c(1,4,6,2,3,5),1],las=2,col=c("red","black"))
dev.print(pdf,"edge_bar.pdf")
