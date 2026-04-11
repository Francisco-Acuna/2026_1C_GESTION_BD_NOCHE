/*
 * Tipos de datos:
 * 
 *  ## Enteros
 * 
 *  - SMALLINT => 2 bytes -> -32.768 a 32.767
 *  - INTEGER o INT => 4 bytes -> -2.147.483.648 a 2.147.483.647
 *  - BIGINT => 8 bytes -> -9 trillones a 9 trillones (aproximadamente)
 * 
 * ## Decimales
 * 
 *  - NUMERIC(p,s) => tamaño variable. Es exacto, p es la cantidad de dígitos y s los decimales.
 * 					Ejemplo: NUMERIC(5,2) guarda hasta el 999,99. No tiene límite real. Puede
 * 					guardar miles de dígitos. Es un tipo exacto de precisión arbitraria, muy
 * 					útil para importes, cálculos contables y valores donde no queremos errores
 * 					de redondeo típicos de los tipos flotantes.
 *  - DECIMAL(p,s) => equivalente de NUMERIC(p,s)
 *  - REAL => 4 bytes -> inexacto (precisión variable). Precisión de 6 dígitos decimales.
 *  - DOUBLE PRECISION => 8 bytes -> inexacto (precisión variable). Precisión de 15 dígitos decimales.
 * 
 * ## Texto
 * 
 *  - CHAR(n) => texto de longitud fija. Si guardamos un "Hola" en un CHAR(10), ocupa los 10 espacios rellenando con 
 * 				espacios en blanco al final. En PostgreSQL, CHAR(n) no da ventaja de rendimiento ni, en general, ahorro
 * 				de espacio en memoria frente a VARCHAR o TEXT. Suele ser el más lento de los tipos de datos de texto 
 * 				por su costo adicional de almacenamiento.
 *  - VARCHAR(n) => texto dde longitud variable, hasta un límite que se defina. Si guardamos "Hola" en un VARCHAR(100),
 * 				solo ocupa el espacio de "Hola" (más 1 byte estructural). En PostgreSQL, CHARACTER VARYING es lo mismo
 * 				que VARCHAR, solo que ese es el nombre más formal/estándard del tipo. Suele verse así cuando se muestra
 * 				en metadatos, en herramientas gráficas o en alguna devolución de sentencias que muestran las estructuras.
 * - TEXT => texto sin límite de longitud especificado. Es el tipo de dato recomendado en PostgreSQL si no necesitamos
 * 			forzar un límite de caracteres por reglas de negocio.
 * 
 * char(10)
 * ana -> 10
 * maximilian -> 10
 * 
 * varchar(10)
 * ana -> 3 + 1 
 * maximilian -> 10 + 1
 * 
 * ## Fecha y hora
 * 
 *  - DATE => 4 bytes -> solo fecha (AAAA-MM-DD) -> '2026-03-20'
 *  - TIME => 8 bytes -> solo hora de un día (HH:MM:SS) -> '21:37:12'
 *  - TIMESTAMP => 8 bytes -> fecha y hora juntas. Es el equivalente a DATETIME de MySQL '2026-03-20 21:37:12'
 * 							Lo utilizamos cuando la fecha u hora es local y no necesitamos compararla globalmente.
 * 							Ejemplos de uso: horario de una clase, turno de atención médica, hora que figura en un
 * 							cartel, agenda local sin necesidad de convertir a zonas.
 *  - TIMESTAMP WITH TIME ZONE o TIMESTAMPZ => fecha, hora y el uso horario. Es una excelente práctica usar este por
 * 											defecto para sistemas modernos -> '2026-03-20 21:43:15-03'.
 * 											Ejemplos de uso: fecha de creación de registros, auditoría, eventos de 
 * 											usuarios conectados desde distintos países, APIs, logs.
 * 
 *  ## Booleano
 * 
 *  - BOOLEAN => 1 byte -> estados de verdadero y falso. TRUE, FALSE y NULL (desconocido).
 * 						Acepta varias formas de entrada que luego interpreta como verdadero o falso.
 * 	VERDADERO			FALSO
 * 	TRUE				FALSE
 * 	'true'				'false'
 *  't'					'f'
 * 	'yes'				'no'
 * 	'on'				'off'
 *  '1'					'0'
 * 
 *  Después PostgreSQL lo normaliza internamente como booleano.
 *  PostgreSQL maneja el booleano como un tipo más nativo y flexible en la entrada de valores.
 *  En MySQL muchas veces el booleano se termina tratando en la práctica como un 1 o un 0. Porque históricamente BOOLEAN
 * en MySQL suele ser un alias de TINYINT(1).
 *  Igualemente en PostgreSQL conviene escribir TRUE y FALSE por claridad.
 *  
 * 
 * ## Otros tipos de datos
 * 
 * UUID => 16 bytes -> es un identificador muy largo, diseñado para ser prácticamente único a escala global, no solo
 * 						dentro de una tabla. 
 * 						Sirven especialmente para sistemas distribuidos, donde ofrecen mejor garantía de unicidad que
 * 						una secuencia local.
 * 
 * BYTEA => tamaño variable -> es el tipo para datos binarios, o sea, para una secuencia de bytes. PostgreSQL lo llama
 * 								internamente "byte array". Permite guardar bytes. Sirve para: archivos pequeños, imágenes,
 * 								PDFs, contenido binario crudo.
 * 								Aunque BYTEA puede guardar archivos, en sistemas reales, muchas veces no conviene guardar
 * 								archivos grandes dentro de la base. A veces se guarda el archivo en disco, nube o 
 * 								almacenamiento externo y en la base, solo se guarda la ruta o URL.
 * 
 * JSON/JSONB => tamaño variable -> son tipos para almacenar documentos del tipo JSON. Tienen la ventaja de validad el
 * 									formato JSON y de ofrecer funciones y operadores específicos.
 * 									JSON significa JavaScript Object Notation. Es un formato de texto muy usado para
 * 									representar datos estructurados en pares clave/valor, arreglos y objetos anidados. 
 * 									Es una forma muy común de intercambiar datos entre sistemas, APIs, aplicaciones web
 * 									y bases de datos.
 * 
 * ## Seudotipos de datos
 * 
 * SMALLSERIAL -> crea una columna tipo smallint -> ocupa 2 bytes en la columna
 * SERIAL -> crea una columna tipo integer -> ocupa 4 bytes (era el estándar)
 * BIGSERIAL -> crea una columna del tipo bigint -> ocupa 8 bytes
 * No son verdaderos tipos de datos. Son una comodidad sintáctica para crear columnas incrementales. Es similar al
 * auto_increment de MySQL.
 * 
 * Aunque SERIAL se utiliza en todas partes y hay muchísimas bases de datos que lo tienen, ya no es el estándar 
 * oficial. Desde hace un par de versiones, PostgreSQL adoptó el estándar SQL puro para los autoincrementales:
 * las columnas IDENTITY.
 * 
 * Con SERIAL, si alguien hace un insert manual forzando un ID, la secuencia no se entera. Luego cuando la secuencia
 * llegue naturalmente a ese número va a dar error de primary key duplicada.
 * 
 * En lugar de usar SERIAL, la forma recomendada hoy en día es con GENERATED ALWAYS AS IDENTITY, PostgreSQL bloquea
 * la columna y no permite que un programador inserte un ID a mano, protegiendo así la integridad de los datos.
 * 
 * IDENTITY tiene otra variedad: GENERATED BY DEFAULT AS IDENTITY
 * 
 * Diferencias entre ALWAYS y DEFAULT
 * GENERATED ALWAYS AS IDENTITY: el motor debe generarl el valor siempre. Si intentamos insertar manualmente el valor
 * en esa columna, PostgreSQL dará error, salvo que usemos la cláusula especial OVERRIDING SYSTEM VALUE.
 * GENERATED BY DEFAULT AS IDENTITY: el motor genera el valor, pero se puede especificar uno manualmente también.
 * 
 * Las identity columns deben ser de tipo: smallint, integer y bigint.
 * IDENTITY no es un tipo de dato, el tipo real sigue siendo el entero. IDENTITY es una propiedad/comportamiento de 
 * generación automática. 
 *
 */

create database Demo;
use Demo; -- en Postrges no existe el use
/*
 * En MySQL un mismo cliente puede conectarse al servidor y luego con el 'use + nombre de la base' trabajábamos sobre
 * esa base.
 * En PostgreSQL, una conexión queda atada a una sola base de datos.
 * La lógica sería:
 * 1) primero nos conectamos a una base al establecer la conexión. (postgres)
 * 2) creamos una base
 * 3) cambiamos la conexión a esa base para poder trabajar dentro de ella.
 * */

select current_database(), current_user;
-- muestra la base de datos en donde estamos parados y el usuario con el que estamos conectados.

create table alumnos(
	id integer generated always as identity primary key,
	nombre text
);
-- si no especificamos un schema, la tabla se crea directamente en public.
-- Utilizamos esquemas aparte cuando queremos organizar objetos por módulos, separar áreas del sistema, mandar
-- permisos más prolijos o evitar conflictos de nombres.

-- esto funciona:
insert into alumnos (nombre) values ('Mauro');

-- esto va a dar error:
insert into alumnos (id, nombre) values (10, 'Samuel');
-- da error porque en ALWAYS no se debería poder cargar el ID a mano (salvo que fuerce el comportamiento)

create table alumnos2(
	id integer generated by default as identity primary key,
	nombre text
);

-- esto funciona:
insert into alumnos2 (nombre) values ('María');
-- y esto también funciona:
insert into alumnos2 (id, nombre) values (3, 'Agus');

select * from alumnos2;

-- pero... qué pasa si sigo insertando registros? eh?
insert into alumnos2 (nombre) values ('Ana');
-- esto da error porque la secuencia no se interrumpió, 
insert into alumnos2 (nombre) values ('AloqueKevin');
-- el default sirve para migración de datos, por ejemplo. Es para cuando queremos traer una gran cantidad de datos
-- ya asignados.

select setval( -- setval significa set value (establecer un valor). Es una función interna de Postgres que se usa
-- para manipular manualmente el contador de una secuencia.
	pg_get_serial_sequence('alumnos2','id'), -- busca cómo se llama la secuencia de esta tabla/columna
	coalesce((select max(id) from alumnos2), 1), -- busca el ID más alto actual
	(select max(id) is not null from alumnos2) -- is_called -> true si el valor anterior fue utilizado, y false si no.
);
-- coalesce devuelve el primer valor no nulo de una lista de expresiones. PostgreSQL lo incluye entre las 
-- expresiones condicionales.
insert into alumnos (nombre) values (null);
select * from alumnos;
select coalesce (nombre, 'SIN NOMBRE') from alumnos;














