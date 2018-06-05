tab=read.table("../data/Figure5B_inputdata.txt",header=T)

boxplot(tab[,4]~tab[,1],las=2,ylim=c(0,3))

nam_sort=unique(sort(as.factor(tab[,1])))

for(i in 1:nrow(tab)){

	pos_x=match(tab[i,1],nam_sort)	
	rand_add=runif(1,-0.3,0.3)
	points(pos_x+rand_add,tab[i,4],col="dimgrey",pch=19,cex=0.75)
}
