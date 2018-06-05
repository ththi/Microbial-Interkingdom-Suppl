

## which dataset? fungal ="fun", bacterial ="bac", oomycetal ="oomyc"

aa_mode="oomyc"

## read otu table
tab=read.table("../data/otu_tab_filter_001_oo.txt",header=T)

## read taxonomy file
tax_tab_full=read.table("../data/taxonomy_ref_oo.txt",header=F,fill=T)


################################


# divide by column sum (to get RAs)
tab_ra=sweep(tab,2,colSums(tab),"/")

# tax assigenment
inter_tax=match(tax_tab_full[,1],rownames(tab)) # see if taxonomy matches otu_table
tax_tab=tax_tab_full[!is.na(inter_tax),] # remove missing ones from taxonomy

tax_match=match(rownames(tab),tax_tab[,1]) # first number is first OTU from table, where to find it in tax_tab
tax_uniq=unique(droplevels(tax_tab[tax_match,c(3,4)])) ### change in loop too ! fun bac 3,4 , oo 2,3

tax_uniq=gsub("\\[|\\]","",as.matrix(tax_uniq))
tax_tab=gsub("\\[|\\]","",as.matrix(tax_tab))


tax_mat=matrix(0, nrow=nrow(tax_uniq), ncol=ncol(tab_ra),dimnames=list(paste(tax_uniq[,1],tax_uniq[,2],sep="_"),colnames(tab_ra)))  

dump_row=""

#for(i in 1:length(tax_uniq)){
for(i in 1:nrow(tax_uniq)){
	
	pat=paste("^",tax_uniq[i,2],"$",sep="") # important to find only exact matches (imagine c__, or 1 )
	tax_rows1=grep(pat,tax_tab[,4]) # find all otus for tax[i]

	pat2=paste("^",tax_uniq[i,1],"$",sep="") # important to find only exact matches (imagine c__, or 1 )
	tax_rows2=grep(pat2,tax_tab[,3]) # find all otus for tax[i]	

	tax_rows=intersect(tax_rows1,tax_rows2)	# where are both patterns found
	
	otu_rows=unique(match(tax_tab[tax_rows,1],rownames(tab)))	# find these OTUs in otu_table ## unique avoids duplicated entries in tax_table
	sum_tax=colSums(tab_ra[otu_rows,])
	tax_mat[i,]=sum_tax	# complete row (all columns) filled with sum of rows from otu_table
	
	
	dump_row=c(dump_row,otu_rows)
	
	
}

tax_mat=tax_mat[sort(rownames(tax_mat)),]

# choose columns to display, (e.g.) (case sensitive)

col_1=grep("PU.Soil",colnames(tab_ra))
col_2=grep("G(A|E).Soil",colnames(tab_ra))
col_3=grep("SD.Soil",colnames(tab_ra))
col_4=grep("PU.Epi",colnames(tab_ra))
col_5=grep("G(A|E).Epi",colnames(tab_ra))
col_6=grep("SD.Epi",colnames(tab_ra))
col_7=grep("PU.Endo",colnames(tab_ra))
col_8=grep("G(A|E).Endo",colnames(tab_ra))
col_9=grep("SD.Endo",colnames(tab_ra))

use_col=c(col_1,col_2,col_3,col_4,col_5,col_6,col_7,col_8,col_9)
use_otu=rowMeans(tax_mat)>0.001

### bac

if(aa_mode=="bac"){

	aa_unclass=grep("1.00_1$",rownames(tax_mat))
	aa_low=grep("(1.00_1)|(p__(Proteobacteria|Planctomycetes|Gemmati|Firmi|Chloroflex|Bacteroide|Actinobact|Acidobac))",rownames(tax_mat),invert=T)
	aa_firm=grep("p__Firmicutes",rownames(tax_mat))
	aa_planc=grep("p__Planctomycetes",rownames(tax_mat))
	aa_gem=grep("p__Gemma",rownames(tax_mat))
	aa_chlo=grep("(p__Chloroflexi_c__($|Anaero|C0119|Chloro|Dehal|SHA|TK17))|(p__Chloroflexi_1.00)",rownames(tax_mat))
	aa_bact=grep("p__Bacteroidetes_c__(Cyto|Sapro|Sphi)",rownames(tax_mat))
	aa_actin=grep("p__Actinobacteria_c__(MB|Rub|The)",rownames(tax_mat))
	aa_acido=grep("p__Acidobac",rownames(tax_mat))
	aa_alpha=grep("c__Alphaprot",rownames(tax_mat))
	aa_beta=grep("c__Betaprot",rownames(tax_mat))
	aa_delt=grep("c__Deltaprot",rownames(tax_mat))
	aa_gam=grep("c__Gammaprot",rownames(tax_mat))
	aa_chlo2=grep("p__Chloroflexi_c__TK10",rownames(tax_mat))
	aa_chlo3=grep("p__Chloroflexi_c__S085",rownames(tax_mat))
	aa_bact2=grep("p__Bacteroidetes_c__Flavo",rownames(tax_mat))
	aa_actin2=grep("p__Actinobacteria_c__Actinobac",rownames(tax_mat))
	aa_actin3=grep("p__Actinobacteria_c__Acidi",rownames(tax_mat))


	new_mat=rbind(colSums(tax_mat[aa_low,]),tax_mat[aa_unclass,],tax_mat[aa_delt,],tax_mat[aa_gam,],tax_mat[aa_beta,],tax_mat[aa_alpha,],colSums(tax_mat[aa_planc,]),colSums(tax_mat[aa_gem,]),colSums(tax_mat[aa_firm,]),tax_mat[aa_chlo2,],tax_mat[aa_chlo3,],colSums(tax_mat[aa_chlo,]),tax_mat[aa_bact2,],colSums(tax_mat[aa_bact,]),tax_mat[aa_actin2,],tax_mat[aa_actin3,],colSums(tax_mat[aa_actin,]),colSums(tax_mat[aa_acido,]))

	new_mat2=cbind(c("low_abundant","unclassified","deltaproteobacteria","gammaproteobacteria","betaproteobacteria","alphaproteobacteria","planctomycetes","gemmatomonadetes","firmicutes","chloroflexi tk10","chloroflexi_s085","chloroflexi","bacteroidetes flavobacteriia","bacteroidetes","actinobacteria actinobac.","actinobacteria acidimicrobiia","actinobacteria","acidobcateria"),new_mat)

}

### fun

if(aa_mode=="fun"){

	aa_unclass=grep("p___c__$",rownames(tax_mat))
	aa_low=grep("Chytridiomycota|Glomeromycota|p__Zygomycota_c__$|p__Zygomycota_c__Kick",rownames(tax_mat))
	aa_zyg=grep("p__Zygomycota_c__Muco",rownames(tax_mat))
	aa_trem=grep("p__Basidiomycota_c__Tremell",rownames(tax_mat))
	aa_puc=grep("p__Basidiomycota_c__Pucc",rownames(tax_mat))
	aa_mic=grep("p__Basidiomycota_c__Microbot",rownames(tax_mat))
	aa_aga=grep("p__Basidiomycota_c__Agaricomyc",rownames(tax_mat))
	aa_bas=grep("p__Basidiomycota_c__($|Agaricostil|Exobasidi|Ustilagin)",rownames(tax_mat))
	aa_sord=grep("p__Ascomycota_c__Sordario",rownames(tax_mat))
	aa_pep=grep("p__Ascomycota_c__(Pezizomycotina|Pezizomycetes)",rownames(tax_mat))
	aa_leo=grep("p__Ascomycota_c__Leotiom",rownames(tax_mat))
	aa_dot=grep("p__Ascomycota_c__Dothi",rownames(tax_mat))
	aa_asc=grep("p__Ascomycota_c__($|Ascomycota|Eurotio|Orbiliomy|Saccharom)",rownames(tax_mat))

	new_mat=rbind(colSums(tax_mat[aa_low,]),tax_mat[aa_unclass,],tax_mat[aa_zyg,],tax_mat[aa_trem,],tax_mat[aa_puc,],tax_mat[aa_mic,],tax_mat[aa_aga,],colSums(tax_mat[aa_bas,]),tax_mat[aa_sord,],colSums(tax_mat[aa_pep,]),tax_mat[aa_leo,],tax_mat[aa_dot,],colSums(tax_mat[aa_asc,]))

	new_mat2=cbind(c("low_abundant","unclassified","zygomy._mucoromycotina","basidio._tremellomycetes","basidio._Pucciniomycetes","basidio._Microbotryomycetes","basidio._agaricomycetes","basidiomycota_","ascomyc._sordariomycetes","ascomyc._pezizomycetes","ascomyc._leotiomycetes","ascomyc._dothideomycetes","ascomycota_"),new_mat)

}

### oo

if(aa_mode=="oomyc"){

	aa_unclass=grep("c__Oomycetes_o__$",rownames(tax_mat))
	aa_low=grep("Lagenidiales",rownames(tax_mat))
	aa_sap=grep("c__Oomycetes_o__Sapro",rownames(tax_mat))
	aa_per=grep("c__Oomycetes_o__Perono",rownames(tax_mat))
	aa_al=grep("c__Oomycetes_o__Albu",rownames(tax_mat))
	aa_lep=grep("c__Oomycetes_o__Lepto",rownames(tax_mat))
	aa_py=grep("c__Oomycetes_o__Pythiales",rownames(tax_mat))

	new_mat=rbind(tax_mat[aa_low,],tax_mat[aa_unclass,],tax_mat[aa_sap,],tax_mat[aa_py,],tax_mat[aa_per,],tax_mat[aa_lep,],tax_mat[aa_al,])
	new_mat2=cbind(c("low_abundant","unclassified","Saprolegniales","Pythiales","Peronosporales","Leptomitales","Albuginales"),new_mat)

}

 
par(xpd=T,mar=c(15,4.1,2.1,15))
barplot(as.matrix(new_mat[nrow(new_mat):1,use_col]),col=rainbow(nrow(new_mat)),cex.names=0.75,ylim=c(0,1),las=2)
legend(43,1,legend=new_mat2[nrow(new_mat):1,1],fill=rainbow(nrow(new_mat[nrow(new_mat):1,])),cex=0.75)







