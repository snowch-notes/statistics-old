Some of my notes on Statistics

See [./stats.ipynb](./stats.ipynb)

----

[R] How to Calculate Percentage of Data within certain SD of Mean [Source](https://stat.ethz.ch/pipermail/r-help/2012-February/302515.html)

```
# Read Data
nb10 <- read.table("http://www.adjoint-functors.net/su/web/314/R/NB10") 

# Calculate Stats
total = length(nb10[,1])
mean = mean(nb10[,1])
sd = sd(nb10[,1])

# Function ... nSD is the number of SD you are looking at
pData <- function(nSD){
  lo = mean - nSD/2*sd
  hi = mean + nSD/2*sd
  percent = sum(nb10[,1]>=lo & nb10[,1]<=hi)/total *100
}

# Output ... 
print(paste("Percent of data within 2 SD is ",pData(2),"%", sep=""))  # 86%
print(paste("Percent of data within 3 SD is ",pData(3),"%", sep=""))  # 93%
print(paste("Percent of data within 4 SD is ",pData(4),"%", sep=""))  # 96%
print(paste("Percent of data within 5 SD is ",pData(5),"%", sep=""))  # 97%
print(paste("Percent of data within 6 SD is ",pData(6),"%", sep=""))  # 98%
```
