# Clean and Set environment
rm(list = ls())
setwd("~/Desktop")

# Load the data
data = read.table(file="butner_copy.csv", header=T, sep=",", na.strings="`", stringsAsFactors=F)
namesExtr = names(data[9:13])
namesExtr

# Unique P.numbers
uniqP <- unique(data$P.number)
uniqP

processedData = data.frame()
for (nameVar in namesExtr){
  for (i in 1:length(uniqP)){
  #for (i in 1:1){
    # Unique Spacing for each P.number
    uniqS <- unique(data[data$P.number == uniqP[i], "Spacing"])
    for (j in 1:length(uniqS)){
    #for (j in 1:1){
      extracted  <- data[data$P.number == uniqP[i] & data$Spacing == uniqS[j],  nameVar]
      processedData <- rbind(processedData, data.frame(name = nameVar, P = uniqP[i], 
                                                       Spacing = uniqS[j],
                                  "Total" = sum(extracted ,na.rm=TRUE), 
                                  "Mean" = mean(extracted, na.rm =TRUE)))
    }
  }
}
write.csv(processedData, file = "Omo_Processed.csv")
