# Proyecto1_Verificacion
## Consigna
* Test plan de todas las capacidades del diseño y diagramas mostrando los 
módulos, interfaces de comunicación entre módulos y formato de los 
paquetes de comunicación. (10%)
* Todas las unidades del ambiente de pruebas aleatorizadas controladas vistas 
en clase. Cada unidad debe correr en un proceso independiente. (10%)
* Código con comentarios. (10%)
* Diseño con inclusión de aserciones en todas las interfaces principales.(10%)
* El diseño de las pruebas debe incluir capacidad de aleatorización de: (30%)
  * Número de transacciones x terminal.
  * Número de terminales en el diseño
  * Profundidad y largo de de las fifos de entrada.
  * Tiempos de envío de mensajes.
  * Mensajes con errores (hacia dispositivos que no existen en el sistema).
  * Direcciones de destino de los mensajes
  * Identificador de “broadcast”
* Identificación e implementación de casos de esquina. (10%)
* El ambiente de pruebas debe ser capaz de generar datos de: (20%)
  1. Retraso promedio en la entrega de paquetes x terminal y general en 
función de la cantidad de dispositivos y las profundidad de las FIFOs.
  2. Ancho de banda promedio máximo y mínimo, en función de la 
cantidad de dispositivos y las profundidad de las FIFOs.
  3. Debe ser capaz de entregar un reporte de los paquetes enviados 
recibidos en formato csv. Se debe incluir tiempo de envío terminal 
de procedencia, terminal de destino tiempo de recibido, retraso en 
el envío.
  4. Usando GNUplot pueden usar los resultados del reporte anterior y 
generar los gráficos que se solicitan en la parte 1 y 2. (10% Extra)

## El dispositivo a analizar (DUT):
Consta de un controlador de bus paralelo con la siguiente definicion:
```Verilog
bs_gnrtr_n_rbtr 
#( 
  parameter bits = 1,
  parameter drvrs = 4, 
  parameter pckg_sz = 16, 
  parameter broadcast = {8{1'b1}}
)(
  input clk,
  input reset,
  input pndng[bits-1:0][drvrs-1:0],
  output push[bits-1:0][drvrs-1:0],
  output pop[bits-1:0][drvrs-1:0],
  input [pckg_sz-1:0] D_pop[bits-1:0][drvrs-1:0],
  output [pckg_sz-1:0] D_push[bits-1:0][drvrs-1:0]
);
```

## Testplan
### Casos de uso comun:
Se aleatorizaran:
* La cantidad de dispositivos conectados.
* La cantidad de mensajes enviados por cada dispositivo.
* Profundidad y largo de de las fifos.
* Tiempos de espera entre envío de mensajes.
* Mensajes a dispositivos que no existen en el sistema.
* Direcciones de destino de los mensajes.
* Identificador de “broadcast”.

### Casos de esquina:
* Dos (o mas) dispositivos envian datos a la vez.
* Un dispositivo desea enviar un mensaje muy largo.
* Se aplicara un reset en medio de una transmision.

### Estructura del ambiente
![alt text](https://github.com/Pablopabota/Proyecto1_Verificacion/blob/main/Estructura_del_ambiente.jpg?raw=true)
