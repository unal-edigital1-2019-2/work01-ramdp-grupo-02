# Electrónica Digital - 2019-2 - Grupo 02
## Javier Andres Africano Pachon	NIT: 1193381320	
## David Miguel Garcia Palacios		NIT: 1001315936

***

#TRABAJO 01 - EVALUACION DE MEMORIA MAXIMA

## Desarrollo

Esta primera semana se relaciona con la prueba del **Buffer RAM Dual-Port** de memoria. Se requiere probar que este buffer ocupe menos del 80% de la memoria de la FPGA a usar con las diferentes configuraciones, realizar una testbench y una serie de pruebas para su funcionamiento, ademas de realizar el planteamiento en mapa de flujo del proceso que debe llevar a cabo el modulo de **Captura de Datos**.

## Memoria del Buffer
Previo a realizar pruebas de capacidad en memoria dentro de ISE, se realiza una breve consulta acerca de las tarjetas programables disponibles en los laboratorios DIEE, y revisar mediante sus datasheets su capacidad en memoria BLOCK RAM.

* Nexys 2-500: FPGA (Spartan-3E) RAM (72 Kb)
* Nexys 3: FPGA (Spartan-6E) RAM (576 Kb)
* Nexys 4: FPGA (Artix-7) RAM (4860 Kb)
* Nexys A7-50: FPGA (Artix-7) RAM (600 Kb)

Al consultar la BLOCK RAM de cada tarjeta, es claro que trabajar con la Nexys 4 es la mejor opción disponible y por lo tanto se configura los próximos proyectos para trabajar con esta tarjeta.

Realizando los cálculos para cada configuración de memoria obtenemos los siguientes resultados:

* (640x480) 16b pixel => 4.915.200 b
* (320x240) 16b piexl => 1.228.800 b
* (160x120) 16b pixel => 307.200 b
* (160x120) 8b pixel => 153.600 b

Comparando los resultados con la información de memoria para la tarjeta Nexys 4, se espera que la configuración adecuada sea **(320x240) 16b pixel**. Ocupando un total del **25.28% de la memoria BLOCK RAM**.

***

Pasando a probar las capacidades en memoria mediante ISE, se hace uso del archivo enviado por correo **buffer_ram_dp.v** configurando para la Nexys 4, y se inicia con la configuración mas alta de memoria **(640x480) 16b pixel**. Se espera que esta configuración falle.

Se calcula la longitud que se requiere de Address para la memoria.

**Log_2 (640x480) = 18,2288 => 19**

Siendo asi, se ajustan los valores parámetro. Con: **AW = 19 , DW = 16.**

Los resultados de errores y advertencias nos indican que se esta usando mas de la capacidad de la FPGA:

`ERROR:Map:237 - The design is too large to fit the device.  Please check the Design Summary section to see which resource requirement for your design exceeds the resources available in the device. Note that the number of slices reported may not be reflected accurately as their packing might not have been completed.`

`WARNING:Xst:1336 -  (*) More than 100% of Device resources are used`

***

Se cambian los parametros para ajustarse a la siguiente configuración propuesta, **(320x240) 16b pixel**. Se espera que esta configuración sea exitosa.

Se calcula la longitud que se requiere de Address para la memoria.

**Log_2 (320x240) = 16,2288 => 17**

Ajustando **AW = 17 , DW = 16.**

Los resulados de advertencias no incluyen problemas de memoria, y su sientesis fue exitosa:

`WARNING:LIT:701 - PAD symbol "clk" has an undefined IOSTANDARD.`


**Por lo tanto, para la realización del proyecto se determina que se debería usar una tarjeta programable Nexys 4 con una configuración para (320x240) con 16b pixel, de Buffer RAM Dual Port con parámetros AW=17 y DW=16. Esperando que este modulo ocupe menos del 26% de la Bock RAM de la FPGA.**

***

Teniendo en cuenta la configuracion necesaria para la imagen y la memoria, se busca en la Datasheet de la camara OV7670 para hallar registros que puedan ser importantes y definir aquellos parametros que deben ser cambiados.

* 0C	COM3	Bit[3]		1	Scale Enable
* 0D	COM4	Bit[5:4]	01	1/2 Window