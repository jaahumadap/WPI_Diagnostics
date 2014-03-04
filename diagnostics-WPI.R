# checking for discrepancies between occupancy models and data
# Process
# 1. Extract a site
# 2. Create occ. matrices for all the species
# 3. Calculate naive occupancy
# 4. Compare to fitted occupancy
library(reshape2)
library(plyr)
#LOAD WPI SYSTEM RESULTS
species.masterlist<-read.csv("specieslist.csv",h=T)
species.masterlist[,"bin"]<-paste(species.masterlist$genus,species.masterlist$species,sep=" ")

wpi<-read.csv("WPI results/psi_last1000.csv",h=T)
qwe<-mapvalues(x=wpi$site_id,from=site.key$site_id,to=(as.character(site.key$site_name)))
wpi[,"site_name"]<-qwe
site.names<-unique(wpi[,"site_name"])

qwe<-mapvalues(x=wpi$species_id,from=species.masterlist$id,to=(as.character(species.masterlist$bin)))
wpi[,"species_name"]<-qwe

#LOAD DATA FROM DB

load("ct_data2014-02-14.gzip")
data<-cam_trap_data
rm(cam_trap_data)
source("camera trap analysis code-02-14-14.R")
#change names of variables back to names in TEAM downloaded files
names(data)<-gsub(pattern=" ",replacement=".",x=names(data))

diag.cax <- calculateWPIDiagnostics(site.names[1])
diag.psh <- calculateWPIDiagnostics(site.names[2])
diag.csn <- calculateWPIDiagnostics(site.names[3])
diag.man <- calculateWPIDiagnostics(site.names[4])
