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
Conectado de la siguiente manera:
![alt text](https://github.com/Pablopabota/Proyecto1_Verificacion/blob/main/Esquema_bus_paralelo.jpg?raw=true)


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
* Que se reciba y se envie un mensaje a travez del mismo terminal.
* Un dispositivo desea enviar un mensaje muy largo.
* Se aplicara un reset en medio de una transmision.

### Estructura del ambiente
![alt text](https://github.com/Pablopabota/Proyecto1_Verificacion/blob/main/Estructura_del_ambiente.jpg?raw=true)

A continuacion se desarrolla que funcion debe cumplir cada parte del ambiente:

#### Test
Indicara al generador el tipo de prueba que se llevara a cabo. Debera especificar:
* La cantidad de dispositivos conectados (terminales).
* Los distintos tamaños de las FIFOs de los terminales.
* Los dispositivos que se comunicaran y sus destinatarios.

#### Generador (Generator) y Agente (Agent)
En este caso se implementara el generador y el agente bajo un mismo modulo con el fin de simplificar el diagrama del entorno de pruebas. El mismo debera:
* Generar los mensajes a enviar.
* Especificar el tiempo entre mensajes.

Las caracteristicas mencionadas previamentes seran recolectadas en el Scoreboard para luego ser contrastadas en el checker.

#### Driver y Monitor
El driver y el monitor deberan implementar las FIFOs de las distintas terminales conectadas al los controladores del bus. Estos deberan:
* Enviar los datos por la interfaz/terminal que corresponda.
* Leer los datos de las interfaces que hayan recibido mensajes y reportarlos al checker.
* Reportar el tiempo entre mensajes.

#### Scoreboard
Se encargara de recoger los datos de las transacciones a realizar y enviarlas al checker para verificar el funcionamiento.

#### Checker
Debera contrastar los datos enviados con los recibidos y que estos sean correctos.
En caso de direccion de "broadcast" todos los dispositivos deberan haber recibido el mismo mensaje.

#### Aserciones (Assertions)
Se utilizara para verificar el correcto funcionamiento de los controladores. Debe:
* Verificar que si el bus esta ocupado, alguno de los flags de busy esta levantado.
* Que el dispositivo enviando datos sea el que tiene el flag del trn_chang levantado.
