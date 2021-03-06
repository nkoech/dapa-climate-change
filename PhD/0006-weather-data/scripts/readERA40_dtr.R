#Julian Ramirez-Villegas
#CIAT / UoL / CCAFS
#April 2012
stop("do not run whole thing")

library(raster); library(rgdal); library(ncdf); library(maptools); data(wrld_simpl)

#src.dir <- "D:/_tools/dapa-climate-change/trunk/PhD/0006-weather-data/scripts"
src.dir <- "~/Repositories/dapa-climate-change/trunk/PhD/0006-weather-data/scripts"
source(paste(src.dir,"/GHCND-GSOD-functions.R",sep=""))
source(paste(src.dir,"/ERA40-functions.R",sep=""))

#wd <- "D:/CIAT_work/crop-modelling/climate-data/ERA-40"
wd <- "/media/PhD_data_01/PhD-work/crop-modelling/climate-data/ERA-40"
setwd(wd)

oDir <- "./daily_data_dtr"
if (!file.exists(oDir)) {dir.create(oDir)}

varName <- "Temperature Surface"
dates.table <- data.frame(START=c("1960-01-01","1971-01-01","1983-01-01","1993-01-01"),
                          END=c("1970-12-31","1982-12-31","1992-12-31","2002-08-31"))
dates.table$FILE <- paste(varName," ",dates.table$START,"_",dates.table$END,".nc",sep="")

#which row to process
#i <- 1
for (i in 1:4) {
  
  iniYear <- as.numeric(substr(dates.table$START[i],1,4))
  finYear <- as.numeric(substr(dates.table$END[i],1,4))
  fName <- dates.table$FILE[i]
  
  if (i > 1) {
    pfName <- dates.table$FILE[i-1]
  } else {
    pfName <- NULL
  }
  
  if (i == 1) {
    iniYear <- iniYear+1
  }
  
  library(snowfall)
  sfInit(parallel=T,cpus=4)
  
  sfExport("leap")
  sfExport("findNCPos")
  sfExport("wd")
  sfExport("oDir")
  sfExport("varName")
  sfExport("iniYear")
  sfExport("finYear")
  sfExport("dates.table")
  sfExport("fName")
  sfExport("pfName")
  sfExport("i")
  
  #year_wrapper_dtr((iniYear:finYear)[1])
  system.time(sfSapply(as.vector(iniYear:finYear),year_wrapper_dtr))
  
  sfStop()
  
}
