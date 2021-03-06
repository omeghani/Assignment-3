# read in the data files
A2010 <- read.csv("BP Apprehensions 2010.csv", header = TRUE, stringsAsFactors = FALSE)
A2017 <- read.csv("BP Apprehensions 2017.csv", header = TRUE, stringsAsFactors = FALSE)
A2000.2017 <- read.csv("BP monthly summaries.csv", header = TRUE, stringsAsFactors = FALSE)



# editing data frames

rownames(A2010) <- A2010[,1]
A2010 <-  subset(A2010, select= -c(Sector))
## rbind ColSums to dataframe
A2010 <- rbind(A2010, colSums(A2010))
## rename the row with column totals "Total"
rownames(A2010) <- c(rownames(A2010)[-length(rownames(A2010))], "Total")
## cbind rowSums to dataframd
A2010 <- cbind(A2010,rowSums(A2010))
## rename last column "Totals
colnames(A2010) <- c(colnames(A2010)[-length(colnames(A2010))], "Total")

rownames(A2017) <- A2017[,1]
A2017 <-  subset(A2017, select= -c(Sector))
## rbind ColSums to dataframe
A2017 <- rbind(A2017, colSums(A2017))
## rename the row with column totals "Total"
rownames(A2017) <- c(rownames(A2017)[-length(rownames(A2017))], "Total")
## cbind rowSums to dataframd
A2017 <- cbind(A2017,rowSums(A2017))
## rename last column "Totals
colnames(A2017) <- c(colnames(A2017)[-length(colnames(A2017))], "Total")


## Barplots

# create dataframe of sector totals for 2010
compsect2010 <- as.data.frame(matrix(c(A2010[1,13],A2010[2,13],A2010[3,13],A2010[4,13],A2010[5,13],A2010[6,13],A2010[7,13],A2010[8,13],A2010[9,13]), nrow = 1))
colnames(compsect2010) <- rownames(A2010)[1:9]
# create dataframe of sector totals for 2017
compsect2017 <- as.data.frame(matrix(c(A2017[1,13],A2017[2,13],A2017[3,13],A2017[4,13],A2017[5,13],A2017[6,13],A2017[7,13],A2017[8,13],A2017[9,13]), nrow = 1))
colnames(compsect2017) <- rownames(A2010)[1:9]
# rbind the two dataframes 
compsect10.17 <- rbind(compsect2010, compsect2017)
# create barplot comparing sector totals between 2010/2017
barplot(as.matrix(compsect10.17), beside = TRUE, col = c("red", "blue"), bty="n", ylab = "Apprehensions", xlab = "Sector", las=2, cex.lab = 1.5, cex.axis = 0.7, cex.names = 0.6)
legend("topleft", c("2010","2017"), pch=15,  col=c("red","blue"),  bty="n")        
title("Apprehension Comparisons by Sector")

# create dataframe of month totals for 2010
compmnth2010 <- as.data.frame(matrix(c(A2010[10,1],A2010[10,2],A2010[10,3],A2010[10,4],A2010[10,5],A2010[10,6],A2010[10,7],A2010[10,8],A2010[10,9],A2010[10,10],A2010[10,11],A2010[10,12]), nrow = 1))
colnames(compmnth2010) <- colnames(A2010)[1:12]
# create dataframe of month totals for 2017
compmnth2017 <- as.data.frame(matrix(c(A2017[10,1],A2017[10,2],A2017[10,3],A2017[10,4],A2017[10,5],A2017[10,6],A2017[10,7],A2017[10,8],A2017[10,9],A2017[10,10],A2017[10,11],A2017[10,12]), nrow = 1))
colnames(compmnth2017) <- colnames(A2010)[1:12]
# rbind the two dataframes 
compmnth10.17 <- rbind(compmnth2010, compmnth2017)
# create barplot comparing month totals between 2010/2017
barplot(as.matrix(compmnth10.17), beside = TRUE, col = c("red", "blue"), bty="n", ylab = "Apprehensions", xlab = "Month",las=2, cex.lab = 1.5, cex.axis = 0.7, cex.names = 0.7)
legend("topleft", c("2010","2017"), pch=15,  col=c("red","blue"),  bty="n")
title("Apprehensions Comparisons by Month")


# analysis t-tests

# create two vectors of sector with max apprhensions in 2010 and 2017
maxsect2010 <- as.numeric(as.vector(A2010[8,1:12]))
maxsect2017 <- as.numeric(as.vector(A2017[6,1:12]))
# variance test between two vectors
var.test(maxsect2010, maxsect2017)
# equal var t-test between two vectors 
t.test(maxsect2010, maxsect2017, var.equal = TRUE)

# create two vectors fo 3-month period with max apprehensions for 2010 and 2107
max3mnth2010 <- c(A2010$March[1:9],A2010$April[1:9],A2010$May[1:9])
max3mnth2017 <- c(A2017$October[1:9], A2017$November[1:9], A2017$December[1:9])
# variance test for the two vectors
var.test(max3mnth2010, max3mnth2017)
# equal var t-test for the two vectors 
t.test(max3mnth2010, max3mnth2017, var.equal = TRUE)


# time series plot

x1 <- A2000.2017[order(nrow(A2000.2017):1),]
ts1 <- x1[,2:13]
ts2 <- as.vector(t(ts1))
ts3 <- ts(ts2, start = c(2000,17), frequency=12)
ts.plot(ts3, gpars=list(main = "BP Apprehensions Monthly Time Series Plot (2000-2017)",xlab="year", ylab="Apprehensions",lty=c(1:3),col=4))

