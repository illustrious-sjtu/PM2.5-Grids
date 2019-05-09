setwd("C:/Users/zheng/Desktop")
#setwd("D:/data")
library("raster")
library("rgdal")
library("RColorBrewer")

#import the data
data2016<-raster("gwr_pm25_2016.tif")
#import China map
CN<-readOGR("bou2_4p.shp")
plot(CN)

#summarize of the data
crs(data2016)
xres(data2016)
yres(data2016)

GDALinfo("gwr_pm25_2016.tif")
data2016@extent
nlayers(data2016)

#plot ps.Do NOT plot the entire file!!!
plot(data2016,xlim=c(121,122),ylim=c(30,32),col=rev(heat.colors(100)))
plot(data2016,xlim=c(121,122),ylim=c(30,32),col=brewer.pal(11,"RdYlGn")[11:1])

#Get the PM2.5 data
p1<-extent(121,121.01,31,31.01)
extract(data2016,p1)
plot(data2016,xlim=c(121,121.01),ylim=c(31,31.01))
p2<-extent(121,121.1,31,31.1)
extract(data2016,p2)

#crop for China
data2016_CN <- crop(data2016, CN)
plot(data2016_CN,col=brewer.pal(11,"RdYlGn")[8:1])
#plot(data2016_CN,col=rev(heat.colors(100)))

# add shapefile on top of the existing raster
plot(CN, add = TRUE)

#about China map
length(CN)
names
#polygon numbers of each province
table(iconv(CN$NAME, from = "GBK"))
#get the map of Shanghai
SH = CN[CN$ADCODE99 == 310000,]
plot(SH)

#crop for Shanghai
data2016_SH <- crop(data2016, SH)
plot(data2016_SH,col=brewer.pal(11,"RdYlGn")[8:1])
#plot(data2016_CN,col=rev(heat.colors(100)))

# add shapefile on top of the existing raster
plot(SH, add = TRUE)

#add the patients' address
addr<-read.csv("IgAN_addr.csv")
points(addr$longitude, addr$latitude, cex=0.8,pch = 20, col="slateblue4")


