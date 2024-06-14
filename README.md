# Función para Extraer Bloques de Texto y Devolver una Tabla

## Descripción del Código

Este script en R proporciona una función para procesar archivos JSON generados por Google Document AI, extrayendo bloques de texto y devolviendo una tabla con la confianza y el texto de cada bloque. A continuación se detallan los pasos realizados por la función `procesar_json`:

1. **Carga de Datos**:
   - Se carga el contenido del archivo JSON especificado.

2. **Extracción de Bloques de Texto**:
   - Se extrae la lista de bloques de texto anidados en el archivo JSON.
   - Se extrae el texto crudo completo del documento.

3. **Procesamiento de Bloques**:
   - Se define una función interna para extraer el texto correspondiente a cada bloque basado en los índices de inicio y fin.
   - Se aplica esta función a cada bloque para obtener una lista de textos de los bloques.

4. **Agregación de Datos**:
   - Se agregan los textos extraídos de vuelta al objeto de datos JSON original.
   - Se asignan identificadores únicos a cada bloque de texto.

5. **Creación de la Tabla**:
   - Se crea una tabla que incluye el identificador de cada bloque, el texto del bloque y la confianza asociada.

6. **Salida del Resultado**:
   - Se imprime la tabla resultante en la consola.
   - Se guarda el JSON modificado en un nuevo archivo con un nombre diferente.

## Ejecución del Script

Para utilizar la función y obtener la tabla con los bloques de texto, simplemente llama a la función `procesar_json` con la ruta al archivo JSON y luego imprime o manipula la tabla resultante según sea necesario.

```r
# Ruta al archivo JSON
json <- "documentai.json"

# Llamar a la función y obtener la tabla
tabla_bloques <- procesar_json(json)

# Imprimir la tabla resultante
print(tabla_bloques)

# Definir nombre para el nuevo JSON
nombre <- gsub("documentai", "documentai_mod", json)

# Escribir el JSON modificado a un archivo
writeLines(jsonlite::toJSON(data, auto_unbox = TRUE), nombre)
```
Este script es útil para aquellos que necesitan analizar y manipular bloques de texto extraídos de documentos procesados con Google Document AI, proporcionando una forma estructurada de trabajar con los datos extraídos.
