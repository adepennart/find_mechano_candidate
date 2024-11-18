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
#mean <- rowMeans(small)

#small <- as.matrix(small[,2:125])
subsetted <- as.matrix(small[,c(17:26,106:108)]) #male female
#subsetted <- as.matrix(small[,c(17:26)])#female
#small <- as.matrix(small)
#small[small == 0] <- NA
log <- log10(subsetted+1)
#heatmap.2(small)
hmcol <- colorRampPalette( brewer.pal(9, "RdBu"))(100)
hmcol <- rev(hmcol)
print(hmcol)
#heatmap.2(log)
#heatmap.2(small , col = hmcol, Rowv = FALSE ,
 #          Colv = FALSE , scale = "none" , dendrogram = "none" ,
  #        trace = "none" , margin = c (6 ,6) )
heatmap.2(log , col = hmcol, scale = "none" , dendrogram = "none" ,
          trace = "none" , margin = c (9.25 ,14) )
#heatmap.2(counts(small,normalized=TRUE)[select,])

##mean?, does it work?
dataframed_2<- read.csv("filtered_gene_expression_Matthews_NCBI_Gene_ID.csv", sep = ',' )#,row.names = "Id.name")
small <- subset(dataframed, select = c(-NCBI.Gene.ID,-Gene.ID,-Gene.symbol) )
small_t <- t(small)
tissue <- vector()
for (variable in row.names(small_t)) {
  #print(variable)
 # new<-substring(toupper(as.character(variable)),4,5) #here we are disregarding male/female
  new<-substring((as.character(variable)),4,5) #here we are not disregarding male/female
    #print(new)
  tissue<-append(tissue,new)  
}
print(tissue)
#small_t <- cbind(small_t,tissue)
#library(dplyr)
#small_t %>% group_by(row.names) %>% summarise_each(sum)
#print(row.names(small_t))
#small_t <- data.frame(cbind(small_t[,1:44],tissue))
test <- aggregate(small_t,list(tissue),mean)
test2 <- test[,-1]
rownames(test2) <- test[,1]
test_t <- t(test2)
print(mean(subsetted[1,]))
#mean <- data.frame(average=rowMeans(small))
#nm1 <- paste0("Fe", 1:125)
#print(nm1)
#subsetted$meanTest <- rowMeans(small[nm1],na.rm = TRUE)
#meaned <- aggregate(subsetted,mean)
#meaned <- as.matrix(meaned)
log2 <- log10(test_t+1)
#heatmap.2(log2)
heatmap.2(log2 , col = hmcol, scale = "none" , dendrogram = "none" ,
          trace = "none" , margin = c (8,8) )

print(tail(sort(log2[,2]),10))