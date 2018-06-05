tab=read.table("dump.txt",header=F)
par(mar=c(12,5,5,5))
barplot(tab[,2],ylim=c(0,tab[1,2]+2),col=c("white","black")[as.factor(tab[,5])],names=tab[,1],las=2,cex.names=0.75,ylab="RA per OTU")
par(new=T)
plot(1:50,tab[,3],col="black",ylim=c(0,100),xaxt="n",yaxt="n",type="l",xlab="",ylab="")
axis(side=4)
mtext("cumulative RA (%)",side=4,line=3)
legend(3,100,c("recovered OTUs","non recovered OTUs"),fill=c("black","white"))

dev.print(pdf,"top_50.pdf")

