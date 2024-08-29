**-----------------------------------------**
* Título: Modelo de regresión lineal simple *
* Autor: Sadan De la Cruz Almanza			*
* 		 	Universidad de Pamplona			*
**-----------------------------------------**

*- Cargar archivo 

use "/Users/macbookait/Documents/UNIPAMPLONA/CURSOS/Econometría/Econometría II/Practico/Modelos de Elección Discreta/bd_pobreza.dta", clear

describe

* Nota: Los datos corresponde a la Encuesta de Pobreza Monetaria 2020

*- Análisis descriptivo

* Nota: Cuando la variable es discreta regularmente nos interesa realizar tablas de frecuencia.

table pobre 
table pobre [iw = fex_c] // el factor de expansión permite tener la información para la muestra completa
tabulate pobre [iw = fex_c] // Otra opción de diseño de tabla

tabulate pobre p6020 [iw = fex_c] 
tabulate pobre p6020 [iw= fex_c], nofreq col
tabulate pobre p6020 [iw= fex_c], row col // La opción permite realizar un análisis cruzado de cada participación
tabulate pobre p6020 [aw= fex_c], summarize(p6040) //  La otra opción permite realizar análisis de frecuencia con variables continuas

*- Gráficas

graph bar (sum) pobre [aw= fex_c], over(p6020) blabel(bar)

hist ingtot
hist ingtot if ingtot < 10000000
hist ingtot if ingtot < 5000000

*- MLP

reg pobre p6020 p6040 p6050 p6090 p6210 p6240 ingtot p6430, robust
reg pobre p6020 p6040 p6050 p6090 p6210 p6240 ingtot p6430 [pw = fex_c], robust

* Interpretación: un incremento unitario de la edad disminuye la probabilidad de ser pobre en 0.67%. Nota: el valor del coeficiente se multipla por 100 para ofrecer una interpretación en terminos %.











