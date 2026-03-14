-- PostgreSQL -> https://www.postgresql.org/docs/ (documentacion oficial)

/*
 * PostgreSQL es un potente sistema de base de datos relacional de código abierto que utiliza
 * y amplía el lenguaje SQL, junto con numerosas funciones que almacenan y escalan de forma
 * segura las cargas de trabajo de datos más complejas.
 * Los orígenes de PostgreSQL se remontan a 1986 como parte del proyecto POSTGRES de la Universidad
 * de California en Berkeley, y cuenta con casi 40 años de desarrollo activo en su plataforma principal.
 * 
 * PostrgreSQL incluye numerosas funciones diseñadas para ayudar a desarrolladores a crear aplicaciones, 
 * a los administradores a proteger la identidad de los datos y a crear tolerancia a fallos, a gestionas sus 
 * datos independientemente del tamño del conjunto de datos. Además de ser gratuito y de código abierto, es
 * altamente extensible. Por ejemplo, puede definir sus propios tipos de datos, crear funciones personalizadas
 * e incluso escribir código desde diferentes lenguajes de programación.
 * 
 * PostgreSQL utiliza SQL (Structure Query Language. Es el lenguaje estándar que se usa para comunicarse con
 * bases de datos relacionales.
 * 
 * PL/pgSQL es el lenguaje de programación interno de PostgreSQL. Nos permite ir más allá del SQL tradicional
 * agregando características típicas de la programación estructuradas directamente dentro del motor de la
 * base de datos, tales como:
 * - declaración de variables
 * - estructuras de control (condicionales y bucles)
 * - manejo de errores y excepciones
 * - creación de funciones complejas y disparadores (triggers)
 * - agrupar múltiples consultas y ejecutar lógica de negocio a máxima velocidad en el servidor.
 * 
 * =========================================================================================================
 * 
 * Organización lógica en PostgreSQL:
 * 
 * Servidor PostgreSQL: el motor corriendo.
 * Base de Datos: contenedor lógico.
 * Schema: suborganización interna dentro de una base.
 * Tabla: estructura donde se almacenan flas y columnas.
 * 
 * En PostgreSQL, por defecto existe un schema llamado public. Si no indicamos otros schema, generalmente los
 * objetos se crean allí. 
 * 
 * */