# iOSRappiTest

Descripción del proyecto

El proyecto fue desarrollado usando como patrón de diseño MVVM, por lo cual contiene los módulos correspondientes a Vistas (donde se encuentran los View controllers y xib utilizados), Managers(clases encargadas de llamadas a servicios web y controladores de los xib implementados) y View models en los cuales se realiza la transferencia de los datos obtenidos por medio de los servicios web a las variables usadas en el proyecto.

En el módulo Manager existe la clase ConnectionManager.swift encargada de gestionar y revisar la conectividad del dispositivos a internet, además la clase RequestManager.swift contiene la configuración necesaria de la sesión para realizar las peticiones al servidor.

Se encontrarán las siguientes carpetas: 
  - Utils: Contiene clases con funciones genéricas usadas en la personalización de la interfaz y la clase contenedora de las constantes del proyecto como la url base de los servicios web, de las imagenes y videos usados, además del apikey de usuario para el proyecto.
  - Cells: Contiene las clases correspondientes a las celdas usadas.
  - Strings: Contiene los archivos y clases gestoras de la función multi idioma del app.
  - Adapters: Contiene la clase encargada de controlar las políticas de cache, gestorá del consumo de datos almacenados en la situación de no presentar conexión a la red.

Preguntas

1. El principio de responsabilidad única es el más relevante y la base de SOLID. Este principio establece que cada clase debe tener una única responsabilidad, para evitar redundancia de funciones y/o clases, contribuyendo así a un bajo acoplamiento.

2. Para que un código fuente pueda ser considerado como limpio, debe poseer caracteristicas como bajo acoplamiento, para garantizar buen nivel de escalabilidad,también debe tener alta coherencia, además cada variable, función y clase debe tener un nombre entendible facilmente y relacionado a su objetivo dentro del proyecto, para facilitar la comprensión de su utilidad.
