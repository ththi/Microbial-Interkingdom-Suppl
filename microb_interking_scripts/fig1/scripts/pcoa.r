#### read bray curtis distance file
bc_its1 <- read.table("../data/bray_curtis_oo.txt", sep="\t", header=T, check.names=F)


use_its1=grep(".PU.|.SD.|.G(E|A).",row.names(bc_its1),perl=T)
pcoa_its1 <- cmdscale(bc_its1[use_its1,use_its1], k=2, eig=T)

aa_sd1=grep(".SD.Soil",row.names(bc_its1[use_its1,use_its1]),perl=T)
aa_sd2=grep(".SD.Epi",row.names(bc_its1[use_its1,use_its1]),perl=T)
aa_sd3=grep(".SD.Endo",row.names(bc_its1[use_its1,use_its1]),perl=T)

aa_pu1=grep(".PU.Soil",row.names(bc_its1[use_its1,use_its1]),perl=T)
aa_pu2=grep(".PU.Epi",row.names(bc_its1[use_its1,use_its1]),perl=T)
aa_pu3=grep(".PU.Endo",row.names(bc_its1[use_its1,use_its1]),perl=T)

aa_ge1=grep(".G(E|A).Soil",row.names(bc_its1[use_its1,use_its1]),perl=T)
aa_ge2=grep(".G(E|A).Epi",row.names(bc_its1[use_its1,use_its1]),perl=T)
aa_ge3=grep(".G(E|A).Endo",row.names(bc_its1[use_its1,use_its1]),perl=T)


its1_v1=format(100*pcoa_its1$eig[1]/sum(pcoa_its1$eig),digits=4)
its1_v2=format(100*pcoa_its1$eig[2]/sum(pcoa_its1$eig),digits=4)

par(xpd=T,mar=c(5,5,2,10))

plot(pcoa_its1$points[aa_sd1,1],pcoa_its1$points[aa_sd1,2],xlab=c("PC1 ",its1_v1),ylab=c("PC2 ",its1_v2),xlim=c(range(pcoa_its1$points[,1])[1]-0.01,range(pcoa_its1$points[,1])[2]+0.01),ylim=c(range(pcoa_its1$points[,2])[1]-0.01,range(pcoa_its1$points[,2])[2]+0.01),bg="brown",pch=22,cex=4)

points(pcoa_its1$points[aa_pu1,1],pcoa_its1$points[aa_pu1,2],cex=4,pch=24,bg="brown")
points(pcoa_its1$points[aa_pu2,1],pcoa_its1$points[aa_pu2,2],cex=4,pch=24,bg="grey")
points(pcoa_its1$points[aa_pu3,1],pcoa_its1$points[aa_pu3,2],cex=4,pch=24,bg="dark green")
points(pcoa_its1$points[aa_sd2,1],pcoa_its1$points[aa_sd2,2],cex=4,pch=22,bg="grey")
points(pcoa_its1$points[aa_sd3,1],pcoa_its1$points[aa_sd3,2],cex=4,pch=22,bg="dark green")
points(pcoa_its1$points[aa_ge1,1],pcoa_its1$points[aa_ge1,2],cex=4,pch=21,bg="brown")
points(pcoa_its1$points[aa_ge2,1],pcoa_its1$points[aa_ge2,2],cex=4,pch=21,bg="grey")
points(pcoa_its1$points[aa_ge3,1],pcoa_its1$points[aa_ge3,2],cex=4,pch=21,bg="dark green")

legend(range(pcoa_its1$points[,2])[2]+0.2,range(pcoa_its1$points[,2])[2],legend=c("soil","episphere","endosphere","SD","GE","PU"),col=c("brown","grey","dark green","black","black","black"),pch=c(19,19,19,0,1,2))
