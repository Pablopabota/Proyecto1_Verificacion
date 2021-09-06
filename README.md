# Proyecto1_Verificacion
ENTREGABLES:
* Test plan de todas las capacidades del diseño y diagramas mostrando los 
módulos, interfaces de comunicación entre módulos y formato de los 
paquetes de comunicación. (10%) 
Se revisará en 1 semana. 
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
* El ambiente de pruebas debe ser capaz de generar datos de: 
(20%)

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
