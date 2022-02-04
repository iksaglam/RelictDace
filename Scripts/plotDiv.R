#!/usr/bin/Rscript


library(ggplot2)
library(psych)
library(pastecs)
library(viridis)

args = commandArgs(TRUE)
infile = args[1]

Pops = read.table(infile, header = T, sep = '\t')
Pops[,c(3,4)] = Pops[,c(3,4)]/Pops$Nsites
Pops = subset(Pops, Nsites >= 200)
Pops = subset(Pops, tW < 0.1 & tP < 0.1)

Pops_means=aggregate(Pops[,3:5], list(Pops$Pop), FUN=mean, header=TRUE)
write.table(Pops_means, "artv_pops_div_table.tsv", quote = F, sep = '\t', row.names = FALSE)

P=ggplot(Pops, aes(x=Pop, y=tW)) + geom_violin(trim=TRUE, scale = "area", fill="#E5D05AFF") + labs(title="Watterson's Theta", y = "ThetaW") + geom_boxplot(width=0.1) + theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1), axis.title.x=element_blank()) + scale_y_continuous(breaks=seq(0.00,0.1,0.01)) + ggtitle(label = "ThetaW values for artvinensis populations")
ggsave("artv_pops_thetaW.pdf", width = 12, height = 6)

ggplot(Pops, aes(x=Pop, y=tP)) + geom_violin(trim=TRUE, fill="#E5D05AFF") + labs(title="Theta Pi", y = "ThetaP") + geom_boxplot(width=0.1) + theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1), axis.title.x=element_blank()) + scale_y_continuous(breaks=seq(0.00,0.1,0.01)) + ggtitle(label = "ThetaP values for artvinensis populations")
ggsave("artv_pops_thetaP.pdf", width = 12, height = 6)

ggplot(Pops, aes(x=Pop, y=TajD)) + geom_violin(trim=TRUE, fill="#E5D05AFF") + labs(title="Tajima's D", y = "TajimaD") + geom_boxplot(width=0.1) + theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1), axis.title.x=element_blank()) + scale_y_continuous(breaks=seq(-3,4,1)) + ggtitle(label = "Tajima's D values for artvinensis populations")
ggsave("artv_pops_TajimaD.pdf", width = 12, height = 6)

unlink("Rplots.pdf", force=TRUE)
