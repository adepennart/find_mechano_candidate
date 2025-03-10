rm(list=ls())
setwd("/Users/lamarcki/Documents/AP_PhD_year1/mechanosensation_project/mechanoreceptor_candiate/output2/")
#install.packages(c("DESeq2", "gplots","RColorBrewer"))

#import libraries 
library(DESeq2) 
library(gplots)
library(RColorBrewer)

#main 1.1 - antennal tip gene expression
# ----------------------------------------------------------------------------------------
#reading in only the genes of interest (which are already in units transcripts per million(tpm))
dataframed<- read.csv("filtered_gene_expression_Matthews_NCBI_Gene_ID.csv", sep = ',' ,row.names = "Id.name")

#remove unnecessary columns
small <- subset(dataframed, select = c(-NCBI.Gene.ID,-Gene.ID,-Gene.symbol) )

#select only abdominal tip columns
subsetted <- as.matrix(small[,c(17:26,106:108)]) #male female
#subsetted <- as.matrix(small[,c(17:26)] )#female

log <- log10(subsetted+1) #add 1 to have all values above 0 and avoid inf values

hmcol <- rev(colorRampPalette( brewer.pal(9, "RdBu"))(100))#select heatmap colour palette and reverse order (i.e. blue to red)
#plot
pdf("../figures/abdominal_tip_mechano.pdf") 
heatmap.2(log , col = hmcol, scale = "none" , dendrogram = "none" ,
          trace = "none" , margin = c (9.25 ,18) ,cexRow = 0.5 ) #Rowv = FALSE ,  Colv = FALSE ))
dev.off()
#main 1.2 - average gene expression per tissue
# ----------------------------------------------------------------------------------------
#reading in only the genes of interest (which are already in units transcripts per million(tpm))
dataframed_2<- read.csv("filtered_gene_expression_Matthews_NCBI_Gene_ID.csv", sep = ',' )#,row.names = "Id.name")

#remove unnecessary columns
small_2 <- subset(dataframed, select = c(-NCBI.Gene.ID,-Gene.ID,-Gene.symbol) )
small_t <- t(small_2) #pivot table

#for loop getting tissue info per column
tissue <- vector()
for (variable in row.names(small_t)) {
 # new<-substring(toupper(as.character(variable)),4,5) #here we are disregarding male/female
  new<-substring((as.character(variable)),1,5) #here we are not disregarding male/female
  tissue<-append(tissue,new) 
  print(new)
}

#aggregate values by mean by tissue
meaned <- aggregate(small_t,list(tissue),mean)

#put tissue in row names
meaned2 <- meaned[,-1]
rownames(meaned2) <- meaned[,1]

meaned_t <- t(meaned2)#pivot table

log2 <- log10(meaned_t+1) #add 1 to have all values above 0 and avoid inf values

hmcol <- rev(colorRampPalette( brewer.pal(9, "RdBu"))(100))#select heatmap colour palette and reverse order (i.e. blue to red)

#plot, At female abdominal tip, AT male abdominal tip
pdf("../figures/all_tissue_mechano.pdf") 
heatmap.2(log2 , col = hmcol, scale = "none" , dendrogram = "none" , 
          trace = "none" , margin = c (9.25 ,17),cexRow = 0.5 )
dev.off()

#get top ten results, uncharacterized LOC5566135 is tmc-1 like
print(tail(sort(log2[,2]),20))
top_ten<-(tail(sort(log2[,2]),10))
write.csv(top_ten, "../figures/top_ten_mechano.csv")