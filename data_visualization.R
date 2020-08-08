#Data Visualization 31/07/2020
library(tidyverse)
#tidyverse 1.3.0 --
#ggplot2 3.3.2     v purrr   0.3.4
#tibble  3.0.3     v dplyr   1.0.0
#tidyr   1.1.0     v stringr 1.4.0
#readr   1.3.1     v forcats 0.5.0

View(mpg)
?mpg

#Estructura ggplot

#grafica de relacion de las variables displ y hwy
ggplot(data=mpg)+
  geom_curve(mapping = aes(x=displ,y= hwy))

#la misma grafica agrupada por la variable class identificado por color
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y= hwy,color=class))

#la misma grafica agrupada por la variable class identificado por tamaño
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y= hwy,size=class))

#transparencia de puntos
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y= hwy,alpha=class))

#forma de puntos, solo hay un maximo de 6 formas, los demas no los representa
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y= hwy,shape=class))

#eleccion manual de esteticas, la estetica global va fuera del mapping
#los shape tienen desde 1 a 25 formas, segun cual sea se le puede añadir
#color o no con el campo fill o la intensidad de borde con stroke
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y= hwy),shape=23,color='red',size=2, fill='yellow',stroke=1)

#FACETS, son como subplots agrupados por la variable class,
#segun el nrow es que te lo muestra todo en n filas 
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy))+
  facet_wrap(~cty,nrow=2)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(drv~.)

#otras geometrias, smooth para forma de curva
#se observa que se peuden combinar diferentes geometrias
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ,y=hwy, color=drv))+
  geom_smooth(mapping = aes(x=displ, y = hwy, linetype=drv)) 
  
#forma para evitar confundirse  con variables, muestra
#lo mismo que el codigo de arriba
ggplot(data = mpg,mapping = aes(x=displ,y=hwy, color=drv)) +
  geom_point()+
  geom_smooth() 

#con parametros globales y locales de mapping
ggplot(data = mpg,mapping = aes(x=displ,y=hwy)) +
  geom_point(mapping = aes(color=class))+
  geom_smooth(mapping = aes(color=drv)) 

#para quedarme con partes de informacion del grafico
#el parametro (se) indica el intervalo de confianza
ggplot(data = mpg,mapping = aes(x=displ,y=hwy)) +
  geom_point(mapping = aes(color=class))+
  geom_smooth(data=filter(mpg,class=="suv"),se=F) 

#geom_bar para hacer graficos de barras o usando 
#la funcion stat_count
View(diamonds)
?diamonds

ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut))

ggplot(data=diamonds)+
  stat_count(mapping = aes(x=cut))

#para hacer un subcionjunto de los datos
demo_diamonds <-tribble(
  ~cut,    ~freqs,
  "Fair",   1610,
  "Good",    4906,
  "Very Good", 1208
)

ggplot(data=demo_diamonds)+
  geom_bar(mapping = aes(x=cut, y=freqs),stat = "identity")

#para ver la proporcion, notar (..prop..) indica la proporcion
#y group=1 es por fila
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut, y=..prop.., group=1))

#stat_sumary
ggplot(data=diamonds)+
  stat_summary(mapping = aes(x=cut, y=depth),
               fun.ymin = min,
               fun.ymax = max,
               fun.y=median
               )

#position="fill"
ggplot(data=diamonds, mapping=aes(x=cut, fill=clarity))+
  geom_bar(position="fill")

#position="dodge"
ggplot(data=diamonds, mapping=aes(x=cut, fill=clarity))+
  geom_bar(position="dodge")

#position="jitter", ocurre cuando hay puntos  que
#coinciden uno encima del otro y con el jitter lo 
#dispersa, veamos la comparacion:
#Ver "Position Adjustments" en el fichero de ayuda
ggplot(data=mpg, mapping=aes(x=displ, y=hwy))+
  geom_point(position="jitter")

ggplot(data=mpg, mapping=aes(x=class, y=hwy))+
  geom_point()

#Sistemas de coordenadas
#coord_flip() -> cambiar a x por y
ggplot(data=mpg, mapping=aes(x=class, y=hwy))+
  geom_boxplot()

ggplot(data=mpg, mapping=aes(x=class, y=hwy))+
  geom_boxplot()+coord_flip()

#coord_quickmap -> configura el aspecto radio para mapas
es <-map_data("es")

#cood_polar -> para coordenadas polares
ggplot(data=mpg, mapping=aes(x=class, y=hwy,color=class,fill=class))+
  coord_polar()


ggplot(data = mpg, mapping = aes(x = cty, y = hwy )) + 
  geom_point() + 
  geom_abline() + 
  coord_fixed()







