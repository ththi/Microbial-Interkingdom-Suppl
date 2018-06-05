tab_bac=read.table("dump_bac.txt",header=F)
tab_fun=read.table("dump_fun.txt",header=F)



par(mar=c(16,3,3,3),mfrow=c(1,2))
aa=by(tab_bac[,4],tab_bac[,2],median)
zz=rank(aa)
boxplot(tab_bac[,4]~tab_bac[,2],las=2,at=zz,col="cyan")

aa=by(tab_fun[,4],tab_fun[,2],median)
zz=rank(aa)
boxplot(tab_fun[,4]~tab_fun[,2],las=2,at=zz,col="orange")

dev.print=(pdf,"boxplot.pdf")	
