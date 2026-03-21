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
 *
 */


