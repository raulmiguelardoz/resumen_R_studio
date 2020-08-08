library(tidyverse)
library(nycflights13)
View(nycflights13::flights)

#tibble es un data frame mejorado
#filter()-> filtrado de datos
#arrange()-> reordenar filas
#select()
#mutate()-> crea nuevas variables con funciones a partir de las ya existentes
#sumamrise()-> colapsa valores para dar un resumen de los datos

#filter()
View(nycflights13::flights)
jan1<-filter(nycflights13::flights,month==1,day==1)
may20<-filter(nycflights13::flights,month==5,day==20)
jun_jul<-filter(nycflights13::flights,month==5|month==6)
#otra via para la informacion de julio y agosto
verano<-filter(nycflights13::flights,month %in% c(7,8))
julio<-filter(nycflights13::flights,month==7)
filter(nycflights13::flights,!(arr_delay>60 |dep_delay>60))
#usando ley de Morgan
filter(nycflights13::flights,arr_delay<=60,dep_delay<=60))

#Casos NA, notemos que la funcion tibble es para crear dataframe
df<-tibble(x=c(1,2,NA,4,5))
filter(df,x>2)
filter(df,is.na(x)|x>2)

#head, tails, para mostrar las filas primeras y ultimas
head(nycflights13::flights,10)
tail(nycflights13::flights,10)

#uso de arrange()
#esto haria un ordenamiento por año, mes y dia
View(sorted_date<-arrange(nycflights13::flights,year,month,day))

#ordenamiento descendente
head(arrange(nycflights13::flights, desc(arr_delay)))
arrange(df,desc(x))
View(arrange(nycflights13::flights, carrier))
View(arrange(nycflights13::flights, distance))


#EJERCICIO 8
count(filter(nycflights13::flights,arr_delay>60))
SFO_OAK<-filter(nycflights13::flights,dest=="SFO"|dest=="OAK")
View(UA_AA<-filter(nycflights13::flights,carrier=="UA"|carrier=="AA"))
abr_may_jun<-filter(nycflights13::flights,month==4|month==5|month==6)
vuelos_1<-filter(nycflights13::flights,arr_delay>60 & dep_delay<60)
vuelos_2<-filter(nycflights13::flights,arr_delay>60 & dep_delay<30)
vuelos_3<-filter(nycflights13::flights,between(nycflights13::flights$hour,0,7))
vuelos_4<-filter(nycflights13::flights,is.na(dep_time))

#SELECT
#muestra las filas 1024-1050
View(sorted_date[1024:1050,])
View(select(sorted_date[1024:1050,],dep_delay,arr_delay))
select(nycflights13::flights,dep_time:arr_delay) #muestra un rango de columnas
select(nycflights13::flights,-(year:day)) #excepto esas
select(nycflights13::flights,starts_with("dep"))
select(nycflights13::flights,ends_with("delay"))
select(nycflights13::flights,contains("st"))
select(nycflights13::flights,matches("(.)\\1")) #esta expresion regular busca carcteres repetidos
#cuando viene sin cabeceras es mejor buscarla por x1,x2,...xn
select(nycflights13::flights,num_range("x",1:5))

write.csv(nycflights13::flights,file = "Prueba_1.csv")
#renombrar y ordenar columnas
rename(nycflights13::flights,deptime=dep_time,año=year, mes=month,dia=day)
select(nycflights13::flights,distance,air_time, everything())

#EJERCICIO 9
arrange(nycflights13::flights,!is.na(dep_time))
View(sorted_dep_delay<-arrange(nycflights13::flights,dep_delay,flight))
arrange(nycflights13::flights, desc(dep_delay))
arrange(flights, desc(dep_delay))[1,]
arrange(flights, dep_delay)[1,]
View(arrange(nycflights13::flights, distance)[1,])
View(filter(nycflights13::flights, distance==4983))
View(filter(nycflights13::flights, distance==80))
View(select(nycflights13::flights,dep_time,dep_delay,arr_time,arr_delay))
View(select(nycflights13::flights,dep_time:arr_delay))
select(nycflights13::flights, one_of(c("arr_delay", "distance")))
select(nycflights13::flights, contains("time"),)

#Mutate
flight_new<- select(nycflights13::flights,
                    year:day,
                    ends_with("delay"),
                    distance,
                    air_time
                    )
mutate(flight_new,
       time_again=arr_delay-dep_delay,
       air_time_hour=air_time/60,
       flight_speed=distance/(air_time/60),
       time_again_per_hour=time_again/air_time_hour
       ) ->flight_new

transmute(flight_new,
       time_again=arr_delay-dep_delay,
       air_time_hour=air_time/60,
       flight_speed=distance/(air_time/60),
       time_again_per_hour=time_again/air_time_hour
       ) ->data_from_flights
     
write.csv(nycflights13::flights,file = "Prueba_8.csv")  


mutate(nycflights13::flights,
       dep_time=nueva_col
       )
