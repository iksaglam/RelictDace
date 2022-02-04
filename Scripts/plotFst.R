#!/usr/bin/Rscript


library(ggplot2)
library(viridis)

args = commandArgs(TRUE)
infile = args[1]

Fst = read.table(infile, header = T, sep = '\t')

ggplot(Fst, aes(Pop2, Pop1)) + geom_tile(aes(fill = Fst), color="white") + 
theme_minimal()+ scale_fill_viridis(discrete=FALSE, option = "cividis", space = "Lab", direction = -1) + theme_bw() + 
theme(axis.text.x=element_text(angle=45,vjust=1,size=10,hjust=1), panel.border=element_blank(), panel.grid.major=element_blank(), axis.title.y = element_blank(), axis.title.x = element_blank()) + scale_y_discrete(position = "left") + 
geom_text(aes(label = round(Fst, 2)), size=3.5, colour = "white") + ggtitle(label = "Fst between artvinensis populations")

ggsave("artv_pops_Fst.pdf", width = 12, height = 6)
unlink("Rplots.pdf", force=TRUE)
