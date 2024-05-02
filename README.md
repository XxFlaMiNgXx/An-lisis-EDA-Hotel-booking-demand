
<div style="width: 100%; clear: both;">
<div style="float: left; width: 50%;">

</div>
<div style="float: right; width: 50%;">
<p style="margin: 0; padding-top: 22px; text-align:right;"> Descripción y análisis de la base de datos hotel_booking</p>
<p style="margin: 0; text-align:right;">2024 · Fundamentos de Data Science (Data science)</p>
<p style="margin: 0; text-align:right;">Prof. Colaboradora: Nérida Isabel Manrique Tunque<b></b></p>
<p style="margin: 0; text-align:right; padding-button: 100px;">Alumnos: <b>Favio Enrique Arroyo Gamarra y Abel Kevin Aguilar Caceres</b> - <a href=""></a></p>
</div>
</div>
<div style="width:100%;">&nbsp;</div>
<center><h1>Trabajo Parcial - Hotel Booking</h1></center>


# Contenidos

1. [Dataset y Objetivo del trabajo](#data1)

2. [Integración y selección de los datos de interés a analizar.](#data2)

3. [Limpieza de los datos.](#data3)
    
    3.1. [¿Los datos contienen ceros o elementos vacíos? ¿Cómo gestionarías cada uno de estos casos?](#data31)
    
    3.2. [Identificación y tratamiento de valores extremos.](#data32)
    
    
4. [Desarrollo de las preguntas.](#data4)

    4.1. [¿Cuántas reservas se realizan por tipo de hotel? o ¿Qué tipo de hotel prefiere la gente?.](#data41)
    
    4.2. [¿Está aumentando la demanda con el tiempo?.](#data42)
    
    4.3. [¿Cuándo se producen las temporadas de reservas: alta, media y baja?.](#data43)
   
    4.4. [¿Cuándo es menor la demanda de reservas?.](#data44)
   
    4.5. [¿Cuántas reservas incluyen niños y/o bebes?.](#data45)
   
    4.6. [¿Es importante contar con espacios de estacionamiento?.](#data46)
   
    4.7. [¿En qué meses del año se producen más cancelaciones de reservas?.](#data47)
   
    4.8. [¿Existe alguna relación entre el tipo de habitación reservada y la probabilidad de cancelación de la reserva?.](#data48)
   
    4.9. [¿Cuál es el país de origen más común entre los huéspedes que realizan reservas en el hotel?.](#data49)
   
    4.10. [¿Qué tipo de alimentación es más solicitada por los huéspedes durante su estadía en el hotel?.](#data410)
   
    
5. [Conclusiones.](#data5)


## 1. Dataset y Objetivos del trabajo <a name="data1"></a>
*Descripción del dataset. ¿Por qué es importante y qué pregunta/problema pretende responder?*

He elegido el dataset ["**Hotel booking demand**" de Kagle]([https://www.kaggle.com/c/titanic/overview](https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand)). 

Objetivos:
Determinar la distribución de reservas por tipo de hotel: Analizar cuántas reservas se realizan en cada tipo de hotel para comprender las preferencias de los clientes y la demanda relativa de cada tipo de alojamiento.

Evaluar la tendencia temporal de la demanda: Examinar si la demanda de reservas está aumentando, disminuyendo o se mantiene estable a lo largo del tiempo, lo que puede proporcionar información sobre las tendencias del mercado y la estacionalidad.

Identificar las temporadas de reservas: Determinar cuándo se producen las temporadas de reservas alta, media y baja, lo que puede ayudar a los hoteles a planificar y gestionar su capacidad y recursos de manera más efectiva.

Identificar períodos de menor demanda: Identificar cuándo la demanda de reservas es menor, lo que puede ser útil para desarrollar estrategias de marketing y promoción para estimular la demanda durante esos períodos.

Analizar la inclusión de niños y/o bebés en las reservas: Determinar cuántas reservas incluyen niños y/o bebés como huéspedes, lo que puede ser importante para la planificación de alojamiento y servicios adicionales.

Evaluar la importancia de los espacios de estacionamiento: Determinar si contar con espacios de estacionamiento es un factor importante para los clientes al realizar reservas de hotel, lo que puede influir en la disponibilidad y el precio de los espacios de estacionamiento.
Analizar las cancelaciones de reservas por mes: Identificar en qué meses del año se producen más cancelaciones de reservas, lo que puede ayudar a los hoteles a anticipar y gestionar la demanda fluctuante.


```R
# Como estamos trabajando con ficheros separados por commas, vamos a mirar un poco de datos
data_hotel <- read.csv('hotel_bookings.csv', header=TRUE, stringsAsFactors = FALSE, sep=',',dec='.')

View(data_hotel)

head(data_hotel)

print(paste("Estamos evaluando", nrow(data_hotel), "líneas de código"))
print("Nombre de las columnas: ")

colnames(data_hotel)

sapply(data_hotel, class)

str(data_hotel)

summary(data_hotel)
```
```R
hotel is_canceled lead_time arrival_date_year arrival_date_month arrival_date_week_number arrival_date_day_of_month
1 Resort Hotel           0       342              2015               July                       27                         1
2 Resort Hotel           0       737              2015               July                       27                         1
3 Resort Hotel           0         7              2015               July                       27                         1
4 Resort Hotel           0        13              2015               July                       27                         1
5 Resort Hotel           0        14              2015               July                       27                         1
6 Resort Hotel           0        14              2015               July                       27                         1
  stays_in_weekend_nights stays_in_week_nights adults children babies meal country market_segment distribution_channel
1                       0                    0      2        0      0   BB     PRT         Direct               Direct
2                       0                    0      2        0      0   BB     PRT         Direct               Direct
3                       0                    1      1        0      0   BB     GBR         Direct               Direct
4                       0                    1      1        0      0   BB     GBR      Corporate            Corporate
5                       0                    2      2        0      0   BB     GBR      Online TA                TA/TO
6                       0                    2      2        0      0   BB     GBR      Online TA                TA/TO
  is_repeated_guest previous_cancellations previous_bookings_not_canceled reserved_room_type assigned_room_type booking_changes
1                 0                      0                              0                  C                  C               3
2                 0                      0                              0                  C                  C               4
3                 0                      0                              0                  A                  C               0
4                 0                      0                              0                  A                  A               0
5                 0                      0                              0                  A                  A               0
6                 0                      0                              0                  A                  A               0
  deposit_type agent company days_in_waiting_list customer_type adr required_car_parking_spaces total_of_special_requests
1   No Deposit  NULL    NULL                    0     Transient   0                           0                         0
2   No Deposit  NULL    NULL                    0     Transient   0                           0                         0
3   No Deposit  NULL    NULL                    0     Transient  75                           0                         0
4   No Deposit   304    NULL                    0     Transient  75                           0                         0
5   No Deposit   240    NULL                    0     Transient  98                           0                         1
6   No Deposit   240    NULL                    0     Transient  98                           0                         1
  reservation_status reservation_status_date
1          Check-Out              2015-07-01
2          Check-Out              2015-07-01
3          Check-Out              2015-07-02
4          Check-Out              2015-07-02
5          Check-Out              2015-07-03
6          Check-Out              2015-07-03

```

```R
   print(paste("Estamos evaluando", nrow(data_hotel), "líneas de código"))
[1] "Estamos evaluando 119390 líneas de código"
> print("Nombre de las columnas: ")
[1] "Nombre de las columnas: "
```
```R
colnames(data_hotel)
 [1] "hotel"                          "is_canceled"                    "lead_time"                     
 [4] "arrival_date_year"              "arrival_date_month"             "arrival_date_week_number"      
 [7] "arrival_date_day_of_month"      "stays_in_weekend_nights"        "stays_in_week_nights"          
[10] "adults"                         "children"                       "babies"                        
[13] "meal"                           "country"                        "market_segment"                
[16] "distribution_channel"           "is_repeated_guest"              "previous_cancellations"        
[19] "previous_bookings_not_canceled" "reserved_room_type"             "assigned_room_type"            
[22] "booking_changes"                "deposit_type"                   "agent"                         
[25] "company"                        "days_in_waiting_list"           "customer_type"                 
[28] "adr"                            "required_car_parking_spaces"    "total_of_special_requests"     
[31] "reservation_status"             "reservation_status_date"       
```

```R
    hotel                    is_canceled                      lead_time              arrival_date_year 
                   "character"                      "integer"                      "integer"                      "integer" 
            arrival_date_month       arrival_date_week_number      arrival_date_day_of_month        stays_in_weekend_nights 
                   "character"                      "integer"                      "integer"                      "integer" 
          stays_in_week_nights                         adults                       children                         babies 
                     "integer"                      "integer"                      "integer"                      "integer" 
                          meal                        country                 market_segment           distribution_channel 
                   "character"                    "character"                    "character"                    "character" 
             is_repeated_guest         previous_cancellations previous_bookings_not_canceled             reserved_room_type 
                     "integer"                      "integer"                      "integer"                    "character" 
            assigned_room_type                booking_changes                   deposit_type                          agent 
                   "character"                      "integer"                    "character"                    "character" 
                       company           days_in_waiting_list                  customer_type                            adr 
                   "character"                      "integer"                    "character"                      "numeric" 
   required_car_parking_spaces      total_of_special_requests             reservation_status        reservation_status_date 
                     "integer"                      "integer"                    "character"                    "character" 


```
    'data.frame':	119390 obs. of  32 variables:
 ```R   
 $ hotel                         : chr  "Resort Hotel" "Resort Hotel" "Resort Hotel" "Resort Hotel" ...
 $ is_canceled                   : int  0 0 0 0 0 0 0 0 1 1 ...
 $ lead_time                     : int  342 737 7 13 14 14 0 9 85 75 ...
 $ arrival_date_year             : int  2015 2015 2015 2015 2015 2015 2015 2015 2015 2015 ...
 $ arrival_date_month            : chr  "July" "July" "July" "July" ...
 $ arrival_date_week_number      : int  27 27 27 27 27 27 27 27 27 27 ...
 $ arrival_date_day_of_month     : int  1 1 1 1 1 1 1 1 1 1 ...
 $ stays_in_weekend_nights       : int  0 0 0 0 0 0 0 0 0 0 ...
 $ stays_in_week_nights          : int  0 0 1 1 2 2 2 2 3 3 ...
 $ adults                        : int  2 2 1 1 2 2 2 2 2 2 ...
 $ children                      : int  0 0 0 0 0 0 0 0 0 0 ...
 $ babies                        : int  0 0 0 0 0 0 0 0 0 0 ...
 $ meal                          : chr  "BB" "BB" "BB" "BB" ...
 $ country                       : chr  "PRT" "PRT" "GBR" "GBR" ...
 $ market_segment                : chr  "Direct" "Direct" "Direct" "Corporate" ...
 $ distribution_channel          : chr  "Direct" "Direct" "Direct" "Corporate" ...
 $ is_repeated_guest             : int  0 0 0 0 0 0 0 0 0 0 ...
 $ previous_cancellations        : int  0 0 0 0 0 0 0 0 0 0 ...
 $ previous_bookings_not_canceled: int  0 0 0 0 0 0 0 0 0 0 ...
 $ reserved_room_type            : chr  "C" "C" "A" "A" ...
 $ assigned_room_type            : chr  "C" "C" "C" "A" ...
 $ booking_changes               : int  3 4 0 0 0 0 0 0 0 0 ...
 $ deposit_type                  : chr  "No Deposit" "No Deposit" "No Deposit" "No Deposit" ...
 $ agent                         : chr  "NULL" "NULL" "NULL" "304" ...
 $ company                       : chr  "NULL" "NULL" "NULL" "NULL" ...
 $ days_in_waiting_list          : int  0 0 0 0 0 0 0 0 0 0 ...
 $ customer_type                 : chr  "Transient" "Transient" "Transient" "Transient" ...
 $ adr                           : num  0 0 75 75 98 ...
 $ required_car_parking_spaces   : int  0 0 0 0 0 0 0 0 0 0 ...
 $ total_of_special_requests     : int  0 0 0 0 1 1 0 1 1 0 ...
 $ reservation_status            : chr  "Check-Out" "Check-Out" "Check-Out" "Check-Out" ...
 $ reservation_status_date       : chr  "2015-07-01" "2015-07-01" "2015-07-02" "2015-07-02" ...
> 
```R



## 2. Limpieza de los datos<a name="data2"></a>

### 2.1. ¿Los datos contienen ceros o elementos vacíos? ¿Cómo gestionarías cada uno de estos casos?<a name="data21"></a>


```R
# Como resultado del comando abajo, podemos ver que solamente Age tiene elementos NA
print("Columnas con NAs:")
unlist(lapply(data_hotel, function(x) any(is.na(x))))

print("Cantidad de columnas con NAs:")
sapply(data_hotel, function(x) sum(is.na(x)))

#Reemplzando NA por 0
data_hotel[is.na(data_hotel)]<-0

unlist(lapply(data_hotel, function(x) any(is.na(x))))
```
```R
    [1] "Columnas con NAs:"



 hotel                    is_canceled                      lead_time              arrival_date_year 
                         FALSE                          FALSE                          FALSE                          FALSE 
            arrival_date_month       arrival_date_week_number      arrival_date_day_of_month        stays_in_weekend_nights 
                         FALSE                          FALSE                          FALSE                          FALSE 
          stays_in_week_nights                         adults                       children                         babies 
                         FALSE                          FALSE                           TRUE                          FALSE 
                          meal                        country                 market_segment           distribution_channel 
                         FALSE                          FALSE                          FALSE                          FALSE 
             is_repeated_guest         previous_cancellations previous_bookings_not_canceled             reserved_room_type 
                         FALSE                          FALSE                          FALSE                          FALSE 
            assigned_room_type                booking_changes                   deposit_type                          agent 
                         FALSE                          FALSE                          FALSE                          FALSE 
                       company           days_in_waiting_list                  customer_type                            adr 
                         FALSE                          FALSE                          FALSE                          FALSE 
   required_car_parking_spaces      total_of_special_requests             reservation_status        reservation_status_date 
                         FALSE                          FALSE                          FALSE                          FALSE 

```
```R
    [1] "Cantidad de columnas con NAs:"

                         hotel                    is_canceled                      lead_time              arrival_date_year 
                             0                              0                              0                              0 
            arrival_date_month       arrival_date_week_number      arrival_date_day_of_month        stays_in_weekend_nights 
                             0                              0                              0                              0 
          stays_in_week_nights                         adults                       children                         babies 
                             0                              0                              4                              0 
                          meal                        country                 market_segment           distribution_channel 
                             0                              0                              0                              0 
             is_repeated_guest         previous_cancellations previous_bookings_not_canceled             reserved_room_type 
                             0                              0                              0                              0 
            assigned_room_type                booking_changes                   deposit_type                          agent 
                             0                              0                              0                              0 
                       company           days_in_waiting_list                  customer_type                            adr 
                             0                              0                              0                              0 
   required_car_parking_spaces      total_of_special_requests             reservation_status        reservation_status_date 
                             0                              0                              0                              0 


```
```R
    [1] "Reemplazando para los atributos vacios, ahora no hay más NAs:"



hotel                    is_canceled                      lead_time              arrival_date_year 
                         FALSE                          FALSE                          FALSE                          FALSE 
            arrival_date_month       arrival_date_week_number      arrival_date_day_of_month        stays_in_weekend_nights 
                         FALSE                          FALSE                          FALSE                          FALSE 
          stays_in_week_nights                         adults                       children                         babies 
                         FALSE                          FALSE                          FALSE                          FALSE 
                          meal                        country                 market_segment           distribution_channel 
                         FALSE                          FALSE                          FALSE                          FALSE 
             is_repeated_guest         previous_cancellations previous_bookings_not_canceled             reserved_room_type 
                         FALSE                          FALSE                          FALSE                          FALSE 
            assigned_room_type                booking_changes                   deposit_type                          agent 
                         FALSE                          FALSE                          FALSE                          FALSE 
                       company           days_in_waiting_list                  customer_type                            adr 
                         FALSE                          FALSE                          FALSE                          FALSE 
   required_car_parking_spaces      total_of_special_requests             reservation_status        reservation_status_date 
                         FALSE                          FALSE                          FALSE                          FALSE 

```

### 2.2. Cambio de tipo de datos e instalación de paquetes necesarios
```R
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
```
## 3. Identificación y tratamiento de valores extremos<a name="data3"></a>

La verdad es que, mismo antes de seguir con el análisis si hay o no valores extremos (*outliers*) queda evidente que hay pocas posibilidades de haber muchos problemas, dado que tenemos simplemente 2 columnas con valores propiamente numéricos. Eso porque aunque **Survived** y **Pclass** son *numeric*, toman valores finitos, por lo que no pueden considerarse variables contínuas y deben factorizarse - abajo lo hacemos antes de empezar la identificación de extremos.

**Los outliers afectan especialmente a la media (medida poco robusta). Y cuando la muestra es pequeña como en nuestro, el efecto se nota aún más acentuado.**


```R
max(data_hotel$adr, na.rm = TRUE)
min(data_hotel$adr, na.rm = TRUE)
fivenum(data_hotel$adr)
```
```R
>   max(data_hotel$adr, na.rm = TRUE)
[1] 5400
>   min(data_hotel$adr, na.rm = TRUE)
[1] -6.38
>   fivenum(data_hotel$adr)
[1]   -6.380   69.290   94.575  126.000 5400.000
>  max(data_hotel$lead_time, na.rm = TRUE)
[1] 737
>   min(data_hotel$lead_time, na.rm = TRUE)
[1] 0
>   fivenum(data_hotel$lead_time)
[1]   0  18  69 160 737
```
```R
boxplot(data_hotel$adr, col = "lightgreen",main="Boxplot ADR",horizontal = TRUE)

boxplot(data_hotel$lead_time, col = "blue",main="Boxplot lead_time",horizontal = TRUE)

#Hallamos los graficos sin outliers
outliers.values <- boxplot(data_hotel$adr)$out

outliers.values <- boxplot(data_hotel$lead_time)$out

#Todos los valores que son extremos
outliers.values
```
```R
[1] 225.00 213.75 230.67 216.13 249.00 241.50 214.00 214.00 240.64 217.05 233.00 222.67 240.00 233.05 219.43 240.00 250.33
  [18] 280.74 219.50 214.00 252.00 233.00 237.00 222.14 220.55 221.00 230.50 230.50 241.00 242.60 268.00 217.20 239.30 267.00
  [35] 226.00 277.50 221.00 250.00 211.75 246.00 252.00 276.43 228.00 211.50 277.00 214.00 254.00 221.00 233.00 214.00 241.00
  [52] 274.93 252.00 258.33 255.00 243.00 222.20 243.00 266.40 236.00 271.00 232.00 223.00 229.00 266.00 262.00 234.00 242.50
  [69] 248.00 299.33 218.00 248.00 223.99 214.00 225.90 213.00 213.00 236.00 229.67 239.50 220.40 241.00 241.00 241.00 222.07
  [86] 229.00 213.50 236.00 248.00 260.71 222.00 221.43 218.50 259.00 229.00 233.00 231.60 261.40 219.33 212.83 221.20 332.00
 [103] 270.00 276.60 232.00 214.00 220.00 225.00 220.00 220.00 272.00 222.00 219.00 219.00 224.00 260.00 238.63 225.80 235.00
 [120] 231.43 237.33 280.00 215.33 212.14 236.67 212.00 240.00 240.00 224.00 224.00 212.00 239.00 227.00 242.00 250.00 237.00
 [137] 233.00 252.00 287.00 259.00 212.00 227.00 247.00 252.00 240.00 240.00 240.00 216.00 212.00 226.00 259.00 224.43 240.00
 [154] 223.00 212.00 227.00 288.00 222.33 226.00 226.00 226.00 226.00 262.00 222.00 226.00 243.32 259.00 219.80 241.00 222.00
 [171] 292.00 259.00 266.50 253.57 241.00 240.00 232.00 259.00 212.14 256.50 212.00 252.00 244.50 282.00 250.00 240.00 221.00
 [188] 219.00 283.32 231.00 231.00 272.70 221.00 230.00 240.00 231.00 246.00 241.00 236.00 259.00 233.00 221.00 299.00 245.67
 [205] 248.75 248.89 298.00 289.00 262.00 251.00 213.00 224.00 274.00 230.00 299.00 241.00 273.00 269.00 269.00 254.00 259.00
 [222] 236.71 259.00 243.63 231.00 219.00 243.63 369.00 262.00 278.60 246.50 271.00 216.00 234.00 222.50 218.00 240.00 240.00
 [239] 216.00 254.31 240.00 261.50 240.00 240.00 214.00 246.00 259.00 224.00 224.00 225.67 219.00 231.50 226.50 231.50 251.00
 [256] 241.00 256.00 216.00 259.00 291.00 241.00 249.00 219.00 225.67 221.00 219.00 225.67 214.00 251.50 234.60 234.00 279.00
 [273] 241.00 259.00 241.00 254.00 277.67 299.00 227.92 258.00 247.67 269.00 263.00 235.57 309.00 289.90 241.00 230.00 216.00
 [290] 248.16 261.00 214.99 217.14 236.67 236.50 259.00 216.50 219.00 219.00 256.00 219.00 246.00 231.00 221.00 246.00 231.00
 [307] 221.00 229.00 219.00 217.33 230.00 219.00 314.50 266.50 258.00 212.00 216.50 286.79 219.00 281.00 239.00 219.00 239.00
 [324] 231.00 219.00 274.00 219.00 227.92 214.00 214.00 275.00 237.00 222.00 222.00 222.00 237.00 247.33 237.00 256.75 222.00
 [341] 288.00 222.00 251.86 238.16 226.14 212.00 259.00 234.00 274.00 227.00 304.00 286.00 329.00 231.00 231.00 231.00 235.67
 [358] 281.00 214.00 226.73 251.73 274.00 219.00 231.00 249.00 229.00 271.00 322.00 241.00 287.00 224.00 239.00 239.10 219.00
 [375] 248.00 220.49 269.00 229.00 214.60 214.00 214.00 226.50 265.67 249.50 240.00 249.50 262.00 253.00 232.25 322.00 269.00
 [392] 234.00 221.00 240.00 243.80 213.80 241.75 247.57 221.00 246.67 246.67 231.80 231.80 223.29 216.00 234.00 227.10 221.00
 [409] 240.60 252.00 219.00 264.00 216.00 219.00 254.00 246.00 221.07 292.40 212.86 233.00 217.00 246.02 340.00 384.00 250.00
 [426] 302.11 250.00 382.00 275.00 229.40 275.00 243.00 223.00 213.00 213.00 225.50 228.00 228.00 262.50 223.00 212.00 213.33
 [443] 215.00 223.00 228.00 228.00 233.00 260.00 212.00 238.00 273.00 261.00 248.00 248.00 311.00 212.00 248.00 258.00 228.00
 [460] 288.00 228.00 222.00 222.00 238.00 216.00 248.00 265.00 260.00 220.00 250.00 243.00 217.50 238.00 300.86 292.00 238.71
 [477] 243.71 232.00 259.86 242.00 223.57 219.14 241.00 264.00 247.00 241.00 265.00 274.67 270.00 239.00 303.00 242.75 212.00
 [494] 212.00 293.00 222.00 222.00 232.00 275.00 260.00 230.86 218.00 270.00 260.00 219.50 272.00 230.30 215.00 219.00 293.33
 [511] 253.25 311.00 217.71 240.00 233.10 289.60 214.00 240.00 252.00 252.00 232.00 229.00 229.00 212.00 234.67 242.00 213.00
 [528] 212.54 216.93 338.00 230.00 229.00 302.00 243.16 342.29 274.45 244.00 216.25 234.56 219.50 290.67 290.67 260.00 255.00
 [545] 226.00 255.00 225.00 306.00 232.91 303.00 249.50 250.00 217.50 237.34 245.00 237.00 289.00 229.00 229.00 278.00 289.50
 [562] 317.00 353.00 257.00 315.00 244.00 265.00 244.00 212.00 220.00 212.00 212.00 230.00 248.00 278.57 225.00 219.00 315.00
 [579] 234.00 245.00 277.00 270.71 277.00 244.00 225.00 213.00 228.00 292.00 237.00 305.00 237.00 299.00 224.00 224.00 232.00
 [596] 232.00 245.00 262.00 292.00 224.00 213.33 215.33 211.30 244.00 221.60 255.00 212.16 224.16 245.00 212.16 255.00 221.00
 [613] 245.00 220.00 267.86 245.00 221.00 220.00 266.50 292.00 222.00 212.14 222.00 292.00 257.00 249.00 229.50 279.50 310.00
 [630] 245.00 257.00 315.00 252.00 224.44 278.00 315.00 220.00 287.00 225.00 237.50 244.00 363.00 363.00 248.00 220.00 246.00
 [647] 225.00 305.00 219.29 244.00 242.10 229.33 266.60 266.60 257.00 252.00 311.70 294.86 219.00 212.17 250.00 230.00 229.00
 [664] 248.00 299.00 309.10 257.00 212.00 224.00 218.00 220.00 229.17 266.30 228.57 227.80 230.00 230.00 230.00 218.00 218.18
 [681] 231.00 301.43 258.27 215.71 242.25 315.71 244.72 450.00 264.00 300.40 300.40 253.33 241.60 257.34 213.75 229.00 225.00
 [698] 213.75 215.67 213.33 266.00 282.29 230.00 250.00 270.00 269.50 212.50 212.50 230.00 283.60 223.75 378.00 244.00 358.75
 [715] 220.00 328.00 230.00 252.00 330.00 220.00 214.00 214.00 259.33 214.00 230.00 292.00 250.00 269.00 298.00 378.00 230.00
 [732] 310.00 262.00 230.00 230.00 231.00 220.00 239.00 323.00 252.00 297.00 269.00 239.00 239.00 239.00 220.00 239.00 225.60
 [749] 259.00 303.70 218.00 230.00 250.00 294.50 216.00 275.00 240.00 378.00 240.00 220.00 220.00 317.00 262.00 298.00 248.33
 [766] 212.00 220.00 252.00 230.00 262.00 292.00 292.00 220.00 215.00 216.00 231.84 297.00 230.00 259.00 258.00 392.00 294.50
 [783] 280.00 273.25 230.00 222.00 230.00 230.00 270.00 264.29 250.00 231.60 230.00 252.00 250.00 259.43 262.00 229.52 297.38
 [800] 230.00 300.00 232.33 303.20 340.00 230.00 256.57 262.00 212.00 225.50 228.00 232.00 232.00 230.00 225.33 261.00 230.00
 [817] 437.00 249.00 219.60 230.00 225.00 230.00 264.00 230.00 388.00 215.00 249.00 274.50 262.00 221.00 254.00 310.00 240.00
 [834] 262.00 297.00 308.00 246.80 259.00 244.00 230.00 224.33 230.00 230.00 273.00 245.00 224.00 231.43 270.00 230.00 310.00
 [851] 230.00 249.00 230.00 229.00 230.00 252.00 230.00 230.00 264.00 308.00 215.00 215.00 262.00 241.00 289.80 378.00 338.00
 [868] 311.50 212.00 318.00 240.00 289.80 247.00 217.60 222.00 217.60 222.00 290.00 260.00 238.57 270.00 290.00 217.50 270.00
 [885] 217.50 237.50 213.00 230.00 230.00 282.00 262.00 220.00 270.00 249.00 330.00 250.00 265.00 257.60 257.60 250.00 231.60
 [902] 227.22 234.00 212.00 238.00 250.00 218.00 340.00 214.84 248.00 238.00 230.00 235.71 230.00 247.20 227.10 244.00 244.00
 [919] 270.00 250.00 268.00 236.00 343.00 254.00 230.00 289.60 255.45 255.45 234.62 260.00 270.00 340.00 270.00 244.00 297.00
 [936] 378.00 295.50 242.00 232.00 230.00 240.91 278.14 260.00 280.00 230.00 237.50 319.00 268.00 225.60 270.00 216.67 222.00
 [953] 225.71 238.57 230.00 252.00 240.00 255.00 220.00 239.14 229.43 216.67 250.00 260.00 270.00 249.00 229.00 331.33 214.00
 [970] 251.43 259.00 249.00 235.00 240.00 243.33 303.33 295.67 295.67 220.00 242.00 342.17 262.38 284.86 251.43 340.86 251.00
 [987] 299.43 294.29 293.86 245.30 290.00 290.00 242.00 229.00 244.16 222.00 295.00 289.80 253.80 230.00
 [ reached getOption("max.print") -- omitted 2793 entries ]
```
```R
#Resumen de las columnas que tienen más outliers
summary(data_hotel$adr)


   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  -6.38   69.29   94.58  101.83  126.00 5400.00 
```
```R
summary(data_hotel$lead_time)

   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
      0      18      69     104     160     737 

```
```R
boxplot.stats(data_hotel$adr)$out

[1] 225.00 213.75 230.67 216.13 249.00 241.50 214.00 214.00 240.64 217.05 233.00 222.67 240.00 233.05 219.43 240.00 250.33
  [18] 280.74 219.50 214.00 252.00 233.00 237.00 222.14 220.55 221.00 230.50 230.50 241.00 242.60 268.00 217.20 239.30 267.00
  [35] 226.00 277.50 221.00 250.00 211.75 246.00 252.00 276.43 228.00 211.50 277.00 214.00 254.00 221.00 233.00 214.00 241.00
  [52] 274.93 252.00 258.33 255.00 243.00 222.20 243.00 266.40 236.00 271.00 232.00 223.00 229.00 266.00 262.00 234.00 242.50
  [69] 248.00 299.33 218.00 248.00 223.99 214.00 225.90 213.00 213.00 236.00 229.67 239.50 220.40 241.00 241.00 241.00 222.07
  [86] 229.00 213.50 236.00 248.00 260.71 222.00 221.43 218.50 259.00 229.00 233.00 231.60 261.40 219.33 212.83 221.20 332.00
 [103] 270.00 276.60 232.00 214.00 220.00 225.00 220.00 220.00 272.00 222.00 219.00 219.00 224.00 260.00 238.63 225.80 235.00
 [120] 231.43 237.33 280.00 215.33 212.14 236.67 212.00 240.00 240.00 224.00 224.00 212.00 239.00 227.00 242.00 250.00 237.00
 [137] 233.00 252.00 287.00 259.00 212.00 227.00 247.00 252.00 240.00 240.00 240.00 216.00 212.00 226.00 259.00 224.43 240.00
 [154] 223.00 212.00 227.00 288.00 222.33 226.00 226.00 226.00 226.00 262.00 222.00 226.00 243.32 259.00 219.80 241.00 222.00
 [171] 292.00 259.00 266.50 253.57 241.00 240.00 232.00 259.00 212.14 256.50 212.00 252.00 244.50 282.00 250.00 240.00 221.00
 [188] 219.00 283.32 231.00 231.00 272.70 221.00 230.00 240.00 231.00 246.00 241.00 236.00 259.00 233.00 221.00 299.00 245.67
 [205] 248.75 248.89 298.00 289.00 262.00 251.00 213.00 224.00 274.00 230.00 299.00 241.00 273.00 269.00 269.00 254.00 259.00
 [222] 236.71 259.00 243.63 231.00 219.00 243.63 369.00 262.00 278.60 246.50 271.00 216.00 234.00 222.50 218.00 240.00 240.00
 [239] 216.00 254.31 240.00 261.50 240.00 240.00 214.00 246.00 259.00 224.00 224.00 225.67 219.00 231.50 226.50 231.50 251.00
 [256] 241.00 256.00 216.00 259.00 291.00 241.00 249.00 219.00 225.67 221.00 219.00 225.67 214.00 251.50 234.60 234.00 279.00
 [273] 241.00 259.00 241.00 254.00 277.67 299.00 227.92 258.00 247.67 269.00 263.00 235.57 309.00 289.90 241.00 230.00 216.00
 [290] 248.16 261.00 214.99 217.14 236.67 236.50 259.00 216.50 219.00 219.00 256.00 219.00 246.00 231.00 221.00 246.00 231.00
 [307] 221.00 229.00 219.00 217.33 230.00 219.00 314.50 266.50 258.00 212.00 216.50 286.79 219.00 281.00 239.00 219.00 239.00
 [324] 231.00 219.00 274.00 219.00 227.92 214.00 214.00 275.00 237.00 222.00 222.00 222.00 237.00 247.33 237.00 256.75 222.00
 [341] 288.00 222.00 251.86 238.16 226.14 212.00 259.00 234.00 274.00 227.00 304.00 286.00 329.00 231.00 231.00 231.00 235.67
 [358] 281.00 214.00 226.73 251.73 274.00 219.00 231.00 249.00 229.00 271.00 322.00 241.00 287.00 224.00 239.00 239.10 219.00
 [375] 248.00 220.49 269.00 229.00 214.60 214.00 214.00 226.50 265.67 249.50 240.00 249.50 262.00 253.00 232.25 322.00 269.00
 [392] 234.00 221.00 240.00 243.80 213.80 241.75 247.57 221.00 246.67 246.67 231.80 231.80 223.29 216.00 234.00 227.10 221.00
 [409] 240.60 252.00 219.00 264.00 216.00 219.00 254.00 246.00 221.07 292.40 212.86 233.00 217.00 246.02 340.00 384.00 250.00
 [426] 302.11 250.00 382.00 275.00 229.40 275.00 243.00 223.00 213.00 213.00 225.50 228.00 228.00 262.50 223.00 212.00 213.33
 [443] 215.00 223.00 228.00 228.00 233.00 260.00 212.00 238.00 273.00 261.00 248.00 248.00 311.00 212.00 248.00 258.00 228.00
 [460] 288.00 228.00 222.00 222.00 238.00 216.00 248.00 265.00 260.00 220.00 250.00 243.00 217.50 238.00 300.86 292.00 238.71
 [477] 243.71 232.00 259.86 242.00 223.57 219.14 241.00 264.00 247.00 241.00 265.00 274.67 270.00 239.00 303.00 242.75 212.00
 [494] 212.00 293.00 222.00 222.00 232.00 275.00 260.00 230.86 218.00 270.00 260.00 219.50 272.00 230.30 215.00 219.00 293.33
 [511] 253.25 311.00 217.71 240.00 233.10 289.60 214.00 240.00 252.00 252.00 232.00 229.00 229.00 212.00 234.67 242.00 213.00
 [528] 212.54 216.93 338.00 230.00 229.00 302.00 243.16 342.29 274.45 244.00 216.25 234.56 219.50 290.67 290.67 260.00 255.00
 [545] 226.00 255.00 225.00 306.00 232.91 303.00 249.50 250.00 217.50 237.34 245.00 237.00 289.00 229.00 229.00 278.00 289.50
 [562] 317.00 353.00 257.00 315.00 244.00 265.00 244.00 212.00 220.00 212.00 212.00 230.00 248.00 278.57 225.00 219.00 315.00
 [579] 234.00 245.00 277.00 270.71 277.00 244.00 225.00 213.00 228.00 292.00 237.00 305.00 237.00 299.00 224.00 224.00 232.00
 [596] 232.00 245.00 262.00 292.00 224.00 213.33 215.33 211.30 244.00 221.60 255.00 212.16 224.16 245.00 212.16 255.00 221.00
 [613] 245.00 220.00 267.86 245.00 221.00 220.00 266.50 292.00 222.00 212.14 222.00 292.00 257.00 249.00 229.50 279.50 310.00
 [630] 245.00 257.00 315.00 252.00 224.44 278.00 315.00 220.00 287.00 225.00 237.50 244.00 363.00 363.00 248.00 220.00 246.00
 [647] 225.00 305.00 219.29 244.00 242.10 229.33 266.60 266.60 257.00 252.00 311.70 294.86 219.00 212.17 250.00 230.00 229.00
 [664] 248.00 299.00 309.10 257.00 212.00 224.00 218.00 220.00 229.17 266.30 228.57 227.80 230.00 230.00 230.00 218.00 218.18
 [681] 231.00 301.43 258.27 215.71 242.25 315.71 244.72 450.00 264.00 300.40 300.40 253.33 241.60 257.34 213.75 229.00 225.00
 [698] 213.75 215.67 213.33 266.00 282.29 230.00 250.00 270.00 269.50 212.50 212.50 230.00 283.60 223.75 378.00 244.00 358.75
 [715] 220.00 328.00 230.00 252.00 330.00 220.00 214.00 214.00 259.33 214.00 230.00 292.00 250.00 269.00 298.00 378.00 230.00
 [732] 310.00 262.00 230.00 230.00 231.00 220.00 239.00 323.00 252.00 297.00 269.00 239.00 239.00 239.00 220.00 239.00 225.60
 [749] 259.00 303.70 218.00 230.00 250.00 294.50 216.00 275.00 240.00 378.00 240.00 220.00 220.00 317.00 262.00 298.00 248.33
 [766] 212.00 220.00 252.00 230.00 262.00 292.00 292.00 220.00 215.00 216.00 231.84 297.00 230.00 259.00 258.00 392.00 294.50
 [783] 280.00 273.25 230.00 222.00 230.00 230.00 270.00 264.29 250.00 231.60 230.00 252.00 250.00 259.43 262.00 229.52 297.38
 [800] 230.00 300.00 232.33 303.20 340.00 230.00 256.57 262.00 212.00 225.50 228.00 232.00 232.00 230.00 225.33 261.00 230.00
 [817] 437.00 249.00 219.60 230.00 225.00 230.00 264.00 230.00 388.00 215.00 249.00 274.50 262.00 221.00 254.00 310.00 240.00
 [834] 262.00 297.00 308.00 246.80 259.00 244.00 230.00 224.33 230.00 230.00 273.00 245.00 224.00 231.43 270.00 230.00 310.00
 [851] 230.00 249.00 230.00 229.00 230.00 252.00 230.00 230.00 264.00 308.00 215.00 215.00 262.00 241.00 289.80 378.00 338.00
 [868] 311.50 212.00 318.00 240.00 289.80 247.00 217.60 222.00 217.60 222.00 290.00 260.00 238.57 270.00 290.00 217.50 270.00
 [885] 217.50 237.50 213.00 230.00 230.00 282.00 262.00 220.00 270.00 249.00 330.00 250.00 265.00 257.60 257.60 250.00 231.60
 [902] 227.22 234.00 212.00 238.00 250.00 218.00 340.00 214.84 248.00 238.00 230.00 235.71 230.00 247.20 227.10 244.00 244.00
 [919] 270.00 250.00 268.00 236.00 343.00 254.00 230.00 289.60 255.45 255.45 234.62 260.00 270.00 340.00 270.00 244.00 297.00
 [936] 378.00 295.50 242.00 232.00 230.00 240.91 278.14 260.00 280.00 230.00 237.50 319.00 268.00 225.60 270.00 216.67 222.00
 [953] 225.71 238.57 230.00 252.00 240.00 255.00 220.00 239.14 229.43 216.67 250.00 260.00 270.00 249.00 229.00 331.33 214.00
 [970] 251.43 259.00 249.00 235.00 240.00 243.33 303.33 295.67 295.67 220.00 242.00 342.17 262.38 284.86 251.43 340.86 251.00
 [987] 299.43 294.29 293.86 245.30 290.00 290.00 242.00 229.00 244.16 222.00 295.00 289.80 253.80 230.00
 [ reached getOption("max.print") -- omitted 2793 entries ]
 ```
```R
boxplot.stats(data_hotel$lead_time)$out

[1] 737 394 460 381 382 709 468 468 468 468 468 468 468 468 468 468 398 424 434 374 406 406 406 406 406 400 379 399 385 422 390
  [32] 390 394 376 376 376 375 385 385 385 397 397 385 385 385 397 397 397 385 385 397 397 397 397 397 385 385 385 385 385 397 397
  [63] 397 385 385 397 397 385 385 397 397 385 385 385 542 542 542 542 542 542 542 542 542 542 403 403 383 383 383 383 383 383 383
  [94] 383 383 383 383 383 383 383 383 383 383 383 383 383 383 383 383 383 383 383 383 383 383 383 383 383 383 383 383 383 383 383
 [125] 383 383 383 383 383 383 383 383 383 383 383 383 383 384 385 393 393 393 393 393 393 393 393 393 393 393 393 393 393 393 393
 [156] 393 393 393 393 393 393 393 393 393 393 393 393 435 375 382 386 386 385 385 385 385 385 385 386 386 386 386 386 386 386 386
 [187] 386 386 386 386 386 386 386 378 378 378 378 378 378 378 378 378 378 378 378 378 378 378 378 378 378 471 471 471 471 471 471
 [218] 462 462 462 462 462 462 462 462 462 462 462 462 462 462 462 462 462 462 462 462 411 411 411 411 411 411 411 411 411 411 411
 [249] 411 411 411 411 411 411 411 411 411 411 450 411 411 411 390 381 378 454 399 468 468 468 468 468 468 468 468 468 468 468 468
 [280] 468 468 468 468 468 468 468 468 460 460 532 468 468 468 468 468 468 468 468 468 468 468 468 468 468 468 468 468 383 386 383
 [311] 406 422 445 542 542 542 542 445 445 542 542 542 542 542 542 542 542 542 383 383 383 383 383 383 383 383 383 383 383 383 383
 [342] 383 384 383 383 383 383 383 386 386 386 386 386 386 386 386 386 386 386 386 390 386 386 389 389 386 386 386 386 386 386 386
 [373] 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386 385 386 386 386 386 386 386 386 386 386 386 386 386 386 386
 [404] 388 388 388 388 388 388 388 388 388 388 388 388 388 388 388 388 388 388 388 388 379 379 407 407 379 379 393 393 393 393 393
 [435] 393 393 393 393 393 393 393 393 393 393 393 393 393 393 393 393 393 393 393 393 393 393 393 393 393 443 443 443 443 443 443
 [466] 443 443 443 443 443 443 443 443 443 443 443 443 443 443 443 443 437 437 437 437 437 437 437 437 437 437 437 437 437 437 437
 [497] 437 437 437 437 437 437 437 437 437 437 437 437 437 437 437 451 451 451 451 451 451 451 451 451 451 451 451 451 451 451 451
 [528] 451 451 451 451 451 451 451 451 451 451 451 451 451 451 384 384 384 384 384 384 384 384 384 384 384 384 384 384 384 384 384
 [559] 384 384 384 384 384 384 379 379 379 379 379 379 379 379 379 379 379 379 379 379 379 379 379 379 379 379 379 379 379 379 379
 [590] 379 379 379 379 379 379 379 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 386
 [621] 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386 386
 [652] 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391 391
 [683] 391 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 398 398 398 398 398 398 398
 [714] 398 398 398 398 398 398 398 398 398 398 398 398 398 398 398 398 398 398 398 398 398 398 398 398 398 405 405 405 405 405 405
 [745] 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 405 412 412 412 412 412
 [776] 412 412 412 412 412 412 412 412 412 412 412 412 412 412 412 412 412 412 412 412 412 412 412 412 412 412 412 419 419 419 419
 [807] 419 419 419 419 419 419 419 419 419 419 419 419 419 419 419 419 419 419 419 419 419 419 419 419 419 419 419 419 420 420 420
 [838] 420 420 420 420 420 420 420 420 420 420 420 420 420 420 420 420 420 420 420 420 420 420 420 420 420 420 420 426 426 426 426
 [869] 426 426 426 426 426 426 426 426 426 426 426 426 426 426 426 426 426 426 426 426 426 426 426 426 426 426 426 426 433 433 433
 [900] 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433
 [931] 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 433 422 422 422 422 422 422 422 422 422 422 422 422 422
 [962] 422 422 440 440 440 440 440 440 440 440 440 440 440 440 440 440 440 440 440 440 440 440 440 440 440 440 440 440 440 440 440
 [993] 440 440 440 429 429 429 429 429
```
```R
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
 ```
## 4. Desarrollo de las preguntas="data4"></a>

### 4.1. ¿Cuántas reservas se realizan por tipo de hotel? o ¿Qué tipo de hotel prefiere la gente?<a name="data41"></a>


```R
#1. RESERVAS POR TIPO DE HOTEL
   reservas_por_tipo <- table(data_hotel$hotel)
   print(reservas_por_tipo)
   barplot(reservas_por_tipo, main = "Reservas por Tipo de Hotel", xlab = "Tipo de Hotel", ylab = "Número de Reservas")
   
   porcentaje_reservas <- prop.table(reservas_por_tipo) * 100
   print(porcentaje_reservas)
```



### 4.2. ¿Está aumentando la demanda con el tiempo?<a name="data42"></a>
```R
 #2.Aumento de reservas a lo largo del tiempo
   data_hotel$reservation_status_date <- as.Date(data_hotel$reservation_status_date)
   reservas_por_año <- table(format(data_hotel$reservation_status_date, "%Y"))
   
   # 2.Graficar la demanda de reservas a lo largo del tiempo
   plot(as.numeric(names(reservas_por_año)), reservas_por_año, type = "o", 
        xlab = "Año", ylab = "Número de Reservas", main = "Demanda de Reservas a lo largo del Tiempo")
```
### 4.3. ¿Cuándo se producen las temporadas de reservas: alta, media y baja?<a name="data43"></a>


```R
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
```

### 4.4. ¿Cuándo es menor la demanda de reservas?<a name="data44"></a>
```R
# Calcular el número total de reservas por año
   reservas_por_año_total <- data_hotel %>%
     group_by(arrival_date_year) %>%
     summarise(total_reservas = n()) %>%
     arrange(total_reservas)
   
   # Encontrar el año con el menor número total de reservas
   año_peor_demanda <- reservas_por_año_total$arrival_date_year[1]
   
   cat("El año con la menor demanda de reservas es:", año_peor_demanda)
```
### 4.5. ¿Cuántas reservas incluyen niños y/o bebes?<a name="data45"></a>


```R
  
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
   
```

### 4.6. ¿Es importante contar con espacios de estacionamiento?<a name="data46"></a>
```R
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
```
### 4.7. ¿En qué meses del año se producen más cancelaciones de reservas?<a name="data47"></a>
```R
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
```
### 4.8. ¿Existe alguna relación entre el tipo de habitación reservada y la probabilidad de cancelación de la reserva?<a name="data48"></a>
```R
 # Agrupa los datos por tipo de habitación reservada y calcula la tasa de cancelación promedio para cada tipo de habitación
   tasa_cancelacion_por_habitacion <- data_hotel %>%
     group_by(reserved_room_type) %>%
     summarise(tasa_cancelacion = mean(is_canceled))
   
   # Visualiza las tasas de cancelación por tipo de habitación reservada
   ggplot(tasa_cancelacion_por_habitacion, aes(x = reserved_room_type, y = tasa_cancelacion)) +
     geom_bar(stat = "identity", fill = "purple", width = 0.5) +
     labs(x = "Tipo de Habitación Reservada", y = "Tasa de Cancelación Promedio", title = "Tasa de Cancelación Promedio por Tipo de Habitación Reservada") +
     theme(axis.text.x = element_text(angle = 45, hjust = 1))
```     
### 4.9. ¿Cuál es el país de origen más común entre los huéspedes que realizan reservas en el hotel?<a name="data49"></a> 
```R
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
```
### 4.10. ¿Qué tipo de alimentación es más solicitada por los huéspedes durante su estadía en el hotel?<a name="data410"></a> 
```R
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
```
  ## 5. Conclusiones<a name="data5"></a>    
  
En base a nuestro análisis de estudio sobre el conjunto de datos “Hotel booking demand Datasets" y los objetivos, concluimos que:

La gente prefiere city hotel sobre los resort hotel, duplicando el número de reservas con un 66.45 % y 33.45% respectivamente.
La demanda de reservas  prácticamente se estaba incrementando hasta inicios del año 2016, Año en el cual empezó a experimentar una baja considerable.

Las temporadas bajas ocurrieron en julio, noviembre del 2015 y enero del 2016. Las temporada alta se experimentó en en el mes de mayo de 2017 y en los meses restantes, predominó la temporada media 

El mes con menor demanda en los tres años es enero.

917 reservas incluyen bebés y 8590 reservas con niños.

No es importante los espacios de estacionamiento, ya que solo el 6.18% de las reservas son con estacionamiento.
El mes con más cancelaciones es el mes de agosto con un total de 5239 cancelaciones.
El tipo P de reservaciones es la que mayor tasa de cancelaciones tiene-
El origen de las personas que realizan más reservas es Portugal.
El régimen de alojamiento que más eligen las personas es el de BB que significa Bed & Breakfast en español significa que prefiero un cuarto con desayuno incluido.

Basándome en el análisis que has proporcionado, aquí tienes algunas recomendaciones para futuros análisis:

Segmentación del mercado: Considera segmentar aún más los datos según variables demográficas como la edad, el género o el origen geográfico para comprender mejor las preferencias de reserva de diferentes grupos de clientes.
Análisis de tendencias a largo plazo: Realiza un análisis de tendencias a más largo plazo para identificar patrones estacionales o cambios en las preferencias de reserva que pueden no ser evidentes en el período de tres años analizado.
Análisis de la satisfacción del cliente: Investiga la relación entre la cancelación de reservas y la satisfacción del cliente. ¿Hay algún patrón que sugiera que ciertos tipos de reserva (por ejemplo, tipo P) están relacionados con una experiencia menos satisfactoria?
Investigación de mercado local: Examina las preferencias de reserva y las tendencias de cancelación en el mercado local de Portugal en comparación con otros países. ¿Existen diferencias significativas que puedan influir en las estrategias de marketing y gestión de reservas?
Impacto de servicios adicionales: Analiza cómo la disponibilidad de servicios adicionales, como desayuno incluido o estacionamiento, afecta las decisiones de reserva y la probabilidad de cancelación.

Lecciones aprendidas:

Es importante monitorear las tendencias a lo largo del tiempo para identificar cambios significativos en la demanda y ajustar las estrategias en consecuencia.
La segmentación del mercado puede proporcionar información valiosa para personalizar las ofertas y mejorar la experiencia del cliente.
La satisfacción del cliente juega un papel crucial en la retención y fidelización, por lo que entender las razones detrás de las cancelaciones puede ayudar a mejorar los servicios y la calidad general del alojamiento.
Los servicios adicionales pueden influir en las decisiones de reserva, por lo que es importante considerar cómo se pueden utilizar para atraer y retener clientes.






