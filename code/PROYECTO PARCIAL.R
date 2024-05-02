setwd("C:/Users/USUARIO/Documents/Archivos R")

data_hotel <- read.csv('hotel_bookings.csv', header=TRUE, stringsAsFactors = FALSE, sep=',',dec='.')

View(data_hotel)

head(data_hotel)

print(paste("Estamos evaluando", nrow(data_hotel), "líneas de código"))
print("Nombre de las columnas: ")

colnames(data_hotel)

sapply(data_hotel, class)

str(data_hotel)

summary(data_hotel)

print("Columnas con NAs:")
unlist(lapply(data_hotel, function(x) any(is.na(x))))

print("Cantidad de columnas con NAs:")
sapply(data_hotel, function(x) sum(is.na(x)))

#Reemplzando NA por 0
data_hotel[is.na(data_hotel)]<-0

unlist(lapply(data_hotel, function(x) any(is.na(x))))

data_hotel$is_canceled <- as.logical(data_hotel$is_canceled)
data_hotel$is_repeated_guest <- as.logical(data_hotel$is_repeated_guest)
data_hotel$reservation_status_date <- as.Date(data_hotel$reservation_status_date)
  
install.packages("mlr",dependencies=TRUE)

install.packages("ggplot2",dependencies=TRUE)
install.packages("dplyr", dependencies=TRUE)
install.packages("agricolae",dependencies=TRUE)
install.packages("readr", dependencies=TRUE)

install.packages("DescTools",dependencies=TRUE)

library(DescTools)

library(mlr) #summary

library(ggplot2) 

library(agricolae)## tabla de frecuencia


max(data_hotel$adr, na.rm = TRUE)
min(data_hotel$adr, na.rm = TRUE)
fivenum(data_hotel$adr)

max(data_hotel$lead_time, na.rm = TRUE)
min(data_hotel$lead_time, na.rm = TRUE)
fivenum(data_hotel$lead_time)

boxplot(data_hotel$adr, col = "lightgreen",main="Boxplot ADR",horizontal = TRUE)

boxplot(data_hotel$lead_time, col = "blue",main="Boxplot lead_time",horizontal = TRUE)

#Hallamos los graficos sin outliers
outliers.values <- boxplot(data_hotel$adr)$out

outliers.values <- boxplot(data_hotel$lead_time)$out

#Todos los valores que son extremos
outliers.values

#Resumen de las columnas que tienen más outliers
summary(data_hotel$adr)

summary(data_hotel$lead_time)

boxplot.stats(data_hotel$adr)$out
boxplot.stats(data_hotel$lead_time)$out


boxplot(data_hotel$adr,
         main = "Average Daily Rate",
         boxwex = 0.3)

 boxplot(adr ~ arrival_date_month, data = data_hotel,
           main = "Average Daily Rate per Month")
 
 boxplot(lead_time ~ arrival_date_month, data = data_hotel,
         main = "Average Daily Rate per Month")

 boxplot(adr ~ arrival_date_month, data = data_hotel,
         main = "Average Daily Rate per Month")$out
 
 boxplot(lead_time ~ arrival_date_month, data = data_hotel,
         main = "Average Daily Rate per Month")$out
 
 
 #Cambio de outliers por el promedio y/o la mediana
 fix_outliers <- function(x, removeNA = TRUE){
    #Calculamos los quantiles 1) por arriba del 5% y por debajo del 95%
    quantiles <- quantile(x, c(0.05, 0.95), na.rm = removeNA)
    x[x<quantiles[1]] <- mean(x, na.rm = removeNA)
    x[x>quantiles[2]] <- median(x, na.rm = removeNA)
    x
 }
 
 sin.outliers <- fix_outliers(data_hotel$adr)
 
 par(mfrow = c(1,2))
  boxplot(data_hotel$adr, main = "Presión con Outliers")
  boxplot(fix_outliers(data_hotel$adr), main = "Presión sin Outliers")
 
  par(mfrow = c(1,2))
  boxplot(data_hotel$lead_time, main = "Presión con Outliers")
  boxplot(fix_outliers(data_hotel$lead_time), main = "Presión sin Outliers")
  
  
 # Cambio de outliers enmascarando sus valores (capping)
  replace_outliers <- function(x, removeNA = TRUE){
     qrts <- quantile(x, probs = c(0.25, 0.75), na.rm = removeNA)
     # si el outlier esta por debajo del cuartil 0.5 o por arriba de 0.95
       caps <- quantile(x, probs = c(.05, .95), na.rm = removeNA)
       # Calculamos el rango intercuartilico
         iqr <- qrts[2]-qrts[1]
         # Calculamos el 1.5 veces el rango intercuartiligo (iqr)
           altura <- 1.5*iqr
           #reemplazamos del vector los outliers por debajo de 0.05 y 0.095
            10
           x[x<qrts[1]-altura] <- caps[1]
           x[x>qrts[2]+altura] <- caps[2]
           x
          }
  
  par(mfrow = c(1,2))
   boxplot(replace_outliers(data_hotel$adr), main = "Average Daily Month sin Outliers")
   boxplot(replace_outliers(data_hotel$lead_time), main = "Tiempo de Espera sin Outliers")
   
   #RESERVAS POR TIPO DE HOTEL
   reservas_por_tipo <- table(data_hotel$hotel)
   print(reservas_por_tipo)
   barplot(reservas_por_tipo, main = "Reservas por Tipo de Hotel", xlab = "Tipo de Hotel", ylab = "Número de Reservas")
   
   porcentaje_reservas <- prop.table(reservas_por_tipo) * 100
   print(porcentaje_reservas)
   
   #2.Aumento de reservas a lo largo del tiempo
   data_hotel$reservation_status_date <- as.Date(data_hotel$reservation_status_date)
   reservas_por_año <- table(format(data_hotel$reservation_status_date, "%Y"))
   
   # 2.Graficar la demanda de reservas a lo largo del tiempo
   plot(as.numeric(names(reservas_por_año)), reservas_por_año, type = "o", 
        xlab = "Año", ylab = "Número de Reservas", main = "Demanda de Reservas a lo largo del Tiempo")
   
   # 3.Cargar las bibliotecas necesarias
   library(readr)
   library(dplyr)
   library(ggplot2)
  
   
   # Convertir arrival_date_month a formato numérico (1-12)
   meses <- c("January", "February", "March", "April", "May", "June", 
              "July", "August", "September", "October", "November", "December")
   data_hotel$month <- match(data_hotel$arrival_date_month, meses)
   
   # Contar el número de reservas por año y mes
   reservas_por_mes <- data_hotel %>%
     group_by(arrival_date_year, month) %>%
     summarise(num_reservas = n())
   
   # Calcular el promedio de reservas por mes
   promedio_reservas <- mean(reservas_por_mes$num_reservas)
   
   # Definir los umbrales para temporadas alta, media y baja
   umbral_alto <- promedio_reservas + 1.5 * sd(reservas_por_mes$num_reservas)
   umbral_bajo <- promedio_reservas - 1.5 * sd(reservas_por_mes$num_reservas)
   
   # Clasificar los meses en temporadas alta, media y baja
   reservas_por_mes$temporada <- ifelse(reservas_por_mes$num_reservas > umbral_alto, "Alta",
                                        ifelse(reservas_por_mes$num_reservas < umbral_bajo, "Baja", "Media"))
   
   # Crear un gráfico de barras para visualizar las temporadas de reservas
   ggplot(reservas_por_mes, aes(x = as.Date(paste(arrival_date_year, month, "01", sep = "-")), fill = temporada)) +
     geom_bar(stat = "count") +  # Utilizamos stat = "count" para contar automáticamente las observaciones
     scale_fill_manual(values = c("Alta" = "red", "Media" = "orange", "Baja" = "green")) +
     labs(x = "Fecha", y = "Número de Reservas", title = "Temporadas de Reservas") +
     theme(legend.title = element_blank())
   
   
   
   
   # Calcular el número de reservas por año y mes
   reservas_por_mes <- data_hotel %>%
     group_by(arrival_date_year, arrival_date_month) %>%
     summarise(num_reservas = n()) %>%
     arrange(num_reservas)
   
   # Encontrar el mes y el año con el menor número de reservas
   menor_demanda <- reservas_por_mes %>%
     slice_min(order_by = num_reservas, n = 1)
   
   mes_menor_demanda <- menor_demanda$arrival_date_month
   año_menor_demanda <- menor_demanda$arrival_date_year
   
   cat("El mes y año con menor demanda de reservas es:", mes_menor_demanda, año_menor_demanda)
   
   # Calcular el número total de reservas por mes para los tres años
   reservas_por_mes_total <- data_hotel %>%
     group_by(arrival_date_month) %>%
     summarise(total_reservas = n()) %>%
     arrange(total_reservas)
   
   # Encontrar el mes con el menor número total de reservas

   año_peor_demanda <- reservas_por_año_total$arrival_date_year[1]
   
   cat("El mes con la menor demanda de reservas entre los tres años es:", mes_peor_demanda)

   # Calcular el número total de reservas por año
   reservas_por_año_total <- data_hotel %>%
     group_by(arrival_date_year) %>%
     summarise(total_reservas = n()) %>%
     arrange(total_reservas)
   
   # Encontrar el año con el menor número total de reservas
   año_peor_demanda <- reservas_por_año_total$arrival_date_year[1]
   
   cat("El año con la menor demanda de reservas es:", año_peor_demanda)
   
   
   # Calcular el número total de niños en cada reserva
   data_hotel$con_niños <- data_hotel$children
   
   # Calcular el número total de bebés en cada reserva
   data_hotel$con_bebes <- data_hotel$babies
   
   # Contar cuántas reservas incluyen niños y/o bebés
   reservas_con_niños <- sum(data_hotel$con_niños > 0)
   reservas_con_bebes <- sum(data_hotel$con_bebes > 0)
   
   # Imprimir el número de reservas que incluyen niños y/o bebés
   print(paste("Número de reservas con niños:", reservas_con_niños))
   print(paste("Número de reservas con bebés:", reservas_con_bebes))
   #5.Calcular el número total de niños y bebés en cada reserva en el dataframe data_hotel
   data_hotel$con_niños_y_bebes <- data_hotel$children + data_hotel$babies
   
   # Contar cuántas reservas incluyen niños y/o bebés
   reservas_con_niños_y_bebes <- sum(data_hotel$con_niños_y_bebes > 0)
   
   # Imprimir el número de reservas que incluyen niños y/o bebés
   print(paste("Número de reservas con niños o bebés:", reservas_con_niños_y_bebes))
   
   
   # Contar el número de reservas que requieren estacionamiento
   reservas_con_estacionamiento <- sum(data_hotel$required_car_parking_spaces == 1)
   
   
   # Contar el número total de reservas
   total_reservas <- nrow(data_hotel)
   
   # Calcular el porcentaje de reservas que requieren estacionamiento
   porcentaje_con_estacionamiento <- (reservas_con_estacionamiento / total_reservas) * 100
   
   # Imprimir los resultados
   cat("Número de reservas que requieren estacionamiento:", reservas_con_estacionamiento, "\n")
   cat("Número total de reservas:", total_reservas, "\n")
   cat("Porcentaje de reservas que requieren estacionamiento:", porcentaje_con_estacionamiento, "%\n")

   # Crear un dataframe con los datos de las reservas que requieren estacionamiento y las que no
   datos_reservas <- data.frame(
     Categoria = c("Requieren Estacionamiento", "No Requieren Estacionamiento"),
     Numero = c(reservas_con_estacionamiento, total_reservas - reservas_con_estacionamiento)
   )
   
   # Cargar el conjunto de datos
   library(readr)
   library(dplyr)
  
   
   # Filtrar solo las cancelaciones
   cancelaciones <- data_hotel %>% filter(is_canceled == 1)
   
   # Contar el número de cancelaciones por mes
   cancelaciones_por_mes <- cancelaciones %>% group_by(arrival_date_month) %>% summarise(num_cancelaciones = n())
   
   # Ordenar los resultados por número de cancelaciones descendente
   cancelaciones_por_mes <- cancelaciones_por_mes[order(-cancelaciones_por_mes$num_cancelaciones),]
   
   # Mostrar los meses con más cancelaciones
   print(cancelaciones_por_mes)

   # Cargar las bibliotecas necesarias
   library(ggplot2)
   
   # Crear el gráfico de barras
   ggplot(cancelaciones_por_mes, aes(x = arrival_date_month, y = num_cancelaciones)) +
     geom_bar(stat = "identity", fill = "skyblue") +
     labs(x = "Mes", y = "Número de Cancelaciones", title = "Cancelaciones de Reservas por Mes") +
     theme(axis.text.x = element_text(angle = 45, hjust = 1))   
   
   
   # Agrupa los datos por tipo de habitación reservada y calcula la tasa de cancelación promedio para cada tipo de habitación
   tasa_cancelacion_por_habitacion <- data_hotel %>%
     group_by(reserved_room_type) %>%
     summarise(tasa_cancelacion = mean(is_canceled))
   
   # Visualiza las tasas de cancelación por tipo de habitación reservada
   ggplot(tasa_cancelacion_por_habitacion, aes(x = reserved_room_type, y = tasa_cancelacion)) +
     geom_bar(stat = "identity", fill = "purple", width = 0.5) +
     labs(x = "Tipo de Habitación Reservada", y = "Tasa de Cancelación Promedio", title = "Tasa de Cancelación Promedio por Tipo de Habitación Reservada") +
     theme(axis.text.x = element_text(angle = 45, hjust = 1))
   
   # Contar el número de reservas por país de origen
   reservas_por_pais <- data_hotel %>%
     group_by(country) %>%
     summarise(total_reservas = n()) %>%
     arrange(desc(total_reservas))
   
   # Mostrar el país con el mayor número de reservas
   pais_mas_comun <- reservas_por_pais$country[1]
   
   cat("El país de origen más común entre los huéspedes que realizan reservas en el hotel es:", pais_mas_comun)
   
   # Filtrar los datos para incluir solo los países con un número significativo de reservas (por ejemplo, los 10 primeros)
   paises_comunes <- head(reservas_por_pais, 10)
   
   # Crear un gráfico de barras para mostrar el número de reservas por país de origen
   ggplot(paises_comunes, aes(x = country, y = total_reservas)) +
     geom_bar(stat = "identity", fill = "maroon") +
     labs(x = "País de Origen", y = "Número de Reservas", title = "Reservas por País de Origen (Top 10)") +
     theme(axis.text.x = element_text(angle = 45, hjust = 1))
   
   # Contar el número de reservas por tipo de alimentación
   alimentacion_solicitada <- data_hotel %>%
     group_by(meal) %>%
     summarise(total_reservas = n()) %>%
     arrange(desc(total_reservas))
   
   # Mostrar el tipo de alimentación más solicitado
   tipo_alimentacion_mas_solicitado <- alimentacion_solicitada$meal[1]
   
   cat("El tipo de alimentación más solicitado por los huéspedes durante su estadía en el hotel es:", tipo_alimentacion_mas_solicitado)
   
   # Crear un gráfico de barras para mostrar el número de reservas por tipo de alimentación
   ggplot(alimentacion_solicitada, aes(x = meal, y = total_reservas)) +
     geom_bar(stat = "identity", fill = "lightgreen") +
     labs(x = "Tipo de Alimentación", y = "Número de Reservas", title = "Reservas por Tipo de Alimentación") +
     theme(axis.text.x = element_text(angle = 45, hjust = 1))