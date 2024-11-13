rm(list=ls())
setwd("/Users/lamarcki/Documents/AP_PhD_year1/mechanosensation_project/mechanoreceptor_candiate/output/")
#install.packages(c("DESeq2", "gplots","RColorBrewer"))

#import libraries 
library(DESeq2) 
library(gplots)
library(RColorBrewer)

#main
# ----------------------------------------------------------------------------------------
#normalized?
dataframed<- read.csv("filtered_gene_expression_Matthews_NCBI_Gene_ID.csv", sep = ',' ,row.names = "Id.name")
#head(dataframed)
#normalized <- as.matrix(read.csv("filtered_gene_expression_Matthews_NCBI_Gene_ID.csv", sep = ',' ,row.names = "Id.name")) 

#small<-head(dataframed)
small <- subset(dataframed, select = c(-NCBI.Gene.ID,-Gene.ID,-Gene.symbol) )
small <- as.matrix(small[,2:125])
#small <- as.matrix(small[,17:26])
#small <- as.matrix(small)
#small[small == 0] <- NA
log <- log10(small+1)
#heatmap.2(small)
hmcol <- colorRampPalette( brewer.pal(9, "RdBu"))(100)
hmcol <- rev(hmcol)
print(hmcol)
heatmap.2(log)
#heatmap.2(small , col = hmcol, Rowv = FALSE ,
 #          Colv = FALSE , scale = "none" , dendrogram = "none" ,
  #        trace = "none" , margin = c (6 ,6) )
heatmap.2(log , col = hmcol, Rowv = FALSE ,
          Colv = FALSE , scale = "none" , dendrogram = "none" ,
          trace = "none" , margin = c (9.25 ,14) )
#heatmap.2(counts(small,normalized=TRUE)[select,])