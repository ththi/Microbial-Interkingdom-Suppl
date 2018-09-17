##Figure 5b and 5c

library(ggplot2)

#Bacteria-only inoculated data (blue lines)

 ggplot(fresh_b, aes(x=Condition, y=Normalized))+
 stat_summary(fun.y = "mean", geom="point")+ylim(0,4)+
 stat_summary(fun.data=mean_se, geom="errorbar")

#Bacteria+fungi inoculated data (boxplots)
 
ggplot(fresh_bf, aes(x=Strain, y=Normalized))+
 	geom_boxplot(alpha=.2, size=1.5)+
    geom_jitter(height=0, size=4, color="darkgray", shape=1)+
    theme(
         panel.background = element_rect(fill = "transparent",colour = NA), # or theme_blank()
         plot.background = element_rect(fill = "transparent",colour = NA)
     )
> p

##statistical test

library(FSA)

kruskal(fresh$Normalized, fresh$Condition, alpha=0.05, p.adj="bonferroni")$groups