# Sushi for genomic data visualization
# December 06, 2018
# Erika Bueno

#https://eribue.github.io/COMP-BIOL/SushiPresentation.html

#if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("Sushi", version = "3.8")

# what is Sushi? - r package for genomic data plotting
# BED, Bedgraph, bedpe, interaction matrices
# Bed formats: chromose name, chromastart, chromend
# bedgraph: 4th column a value

# sequencing tracks, interaction plots, gene structure, manhattan plot, gene density plot
# zoomsregion() zoombox()

library(Sushi)
Sushi_data <- data(package="Sushi")
Sushi_data

data(list=Sushi_data$results[,3])

# Function plotBedgraph()
head(Sushi_DNaseI.bedgraph)

chrom = "chr11"
chromstart = 1650000
chromend = 2350000  

plotBedgraph(Sushi_DNaseI.bedgraph, chrom, chromstart,
             chromend, colorbycol=SushiColors(5))

labelgenome(chrom, chromstart, chromend, n=5, scale="Mb",
            mtext("Read Depth", side=2, line=2.75, cex=1, font=2))
axis(side=2, las=2, tcl=0.2)

#plotmanhattan, plotBed
p <- layout.show(matrix(c(1,1,1,1,
                     1,1,1,1,
                     2,2,2,2,
                     2,2,2,2,
                     3,3,3,3,
                     3,3,3,3),
                   6, 4, byrow=TRUE))
p

# set the margins
par(mgp=c(3,0.3,0))

# set parameters
par(mag=c(3,4,3,2))

# genomic paremeters
chrom = "chr15"
chromstart = 73000000
cgromend = 89500000

plotManhattan(bedfile = Sushi_GWAS.bed, pvalues = Sushi_GWAS.bed[,5],
              genome=Sushi_hg18_genome, cex=0.75)

labelgenome(genome=Sushi_hg_genome,n=4, scale="Mb",
            edgeblankfraction = 0.20)

axis(side=2, las=2, tcl=0.2)
mtext("log10(p)", side=2,line=1.75, cex=0.75,font=2)
labelplot("A)", "GWAS")

# zoomed in gwas

# set the margins
par(mar=c(0.1,4,2,2))

# set the genomic regions
chrom = "chr15"
chromstart = 60000000
chromend = 80000000
chromstart2 = 72000000
chromend2 = 74000000

plotManhattan(bedfile = Sushi_GWAS.bed, chrom = chrom2,
              chromstart = chromstart,
              chromend = chromend,
              pvalue = Sushi_GWAS.bed$pval.GC.DBP,
              col=SushiColors(6) (nrow(Sushi_hg18_genome))[15],
cex=0.75)

zoomsregion(region = c(chromstart2, chromend2),
            chrom = chrom2,
            extend = c(0.075, 1),
            wideextend = 0.2,
            offsets = c(0.0,0))

zoombox(passthrough = TRUE, topextend = 2)
axis(side=2,las=2, tcl=0.2)
mtext("Z-score", side = 2, line = 1.75, cex = 0.75, font = 2)
labelplot("B)", "Zoomed in")

#plotBed() to make gene density plot

# set the margins
par(mar=c(3,4,1.8,2))

# set genomic regions
chrom = "chr15"
chromstart = 60000000
chromend = 80000000
chrom_biomart=gsub("chr", "",chrom)

#set the mart
mart <- useMart(host="may2009.archive.ensembl.org",
                biomart = "ENSEMBL_MART_ENSEMBL",
                dataset = "hsapiens_gene_ensembl")

# get gene info
geneinfobed <- getBM(attributes = c("chromosome_name", "start_position", "end_position"), filters=c("chromosome_name", "start", "end"),
                     values=list(chrom_biomart,
                                 chromstart, chromend), mart=mart)

geneinfobed[,1] = paste("chr", geneinfobed[,1], sep="")
head(geneinfobed)

plotBed(beddata = geneinfobed[!duplicated(geneinfobed),],
        chrom=chrom,
        chromstart=chromstart,
        row="supplied",
        palettes = list(SuchiColors(7)),
        type="density")
zoomsregion(region = c(chromstart2, chromend2),
            chrom=chrom2,
            genome=NULL,
            highlight = TRUE,
            extend = c(2,0))
labelgenome(chrom,
            chromstart,
            chromend,
            n=3,
            scale="Mb", edgeblankfraction = 0.20)
labelplot("C)", "Gene Density Plot")
