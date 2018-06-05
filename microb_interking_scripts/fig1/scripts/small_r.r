test=read.table("dump2.txt",header=T)
test=test[,c(2:8,1)]
barplot(as.matrix(t(test)),col=rainbow(8),legend=colnames(test))
dev.print(pdf,"test.pdf")
