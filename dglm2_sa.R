shell("cls")
library(statmod)
library(nlme)
library(mgcv)
library(dglm)

setwd("E:/NeuroImage/code")

age<-read.table('../data/age.txt')
age<-as.matrix(age)
gender<-read.table('../data/sex.txt')
gender<-as.matrix(gender)
area<-read.table('../data/area.txt')
area<-as.matrix(area)
typeof(area)

cog<-read.table('../data/cog_agecorrected.txt')
cog<-as.matrix(cog)
fluid<-as.matrix(cog[,1])
crystal<-as.matrix(cog[,2])
total<-as.matrix(cog[,3])


site <-read.table('../data/site.txt')
site<-as.matrix(site)
a1<-matrix(nrow=151,ncol=2)
b1<-matrix(nrow=151,ncol=2)
a2<-matrix(nrow=151,ncol=2)
b2<-matrix(nrow=151,ncol=2)
a3<-matrix(nrow=151,ncol=2)
b3<-matrix(nrow=151,ncol=2)
#for(i in union(1:83,85:151)){
for(i in 1:151){
  print(i)
  m<-as.numeric(area[,i])
  clotting<-data.frame(age,gender,area,site,m,total,crystal,fluid)
  sa <-gam(m ~s(age)+gender+site,family=gaussian,data=clotting)
  out1<-dglm(sa$residuals~total+age+gender,~total+age+gender,data=clotting,family=gaussian)
  out2<-dglm(sa$residuals~crystal+age+gender,~crystal+age+gender,data=clotting,family=gaussian)
  out3<-dglm(sa$residuals~fluid+age+gender,~fluid+age+gender,data=clotting,family=gaussian)
  
  a1[i,1:2]<-summary(out1)$coefficients[2,3:4]
  b1[i,1:2]<-summary(out1$dispersion.fit)$coefficients[2,3:4]
  a2[i,1:2]<-summary(out2)$coefficients[2,3:4]
  b2[i,1:2]<-summary(out2$dispersion.fit)$coefficients[2,3:4]
  a3[i,1:2]<-summary(out3)$coefficients[2,3:4]
  b3[i,1:2]<-summary(out3$dispersion.fit)$coefficients[2,3:4]
}


write.table(a1,"../result/1_mean_sa.txt")
write.table(b1,"../result/1_dispersion_sa.txt")
write.table(a2,"../result/2_mean_sa.txt")
write.table(b2,"../result/2_dispersion_sa.txt")
write.table(a3,"../result/3_mean_sa.txt")
write.table(b3,"../result/3_dispersion_sa.txt")
#success!

