# Función para extraer bloques de texto y devolver una tabla

procesar_json <- function(json_path) {
  # Cargar datos del archivo JSON
  data <- jsonlite::fromJSON(json_path)
  
  # Extraer la lista de bloques de texto
  lista_bloques <- data$pages$blocks[[1]]$layout$textAnchor$textSegments
  
  # Extraer el texto crudo completo
  texto_crudo <- data$text
  
  # Función para extraer un bloque de texto
  extraer_bloque <- function(texto_crudo, bloque) {
    start <- ifelse(is.null(bloque$startIndex), 1, as.numeric(bloque$startIndex) + 1)
    end <- as.numeric(bloque$endIndex)
    substring(texto_crudo, start, end)
  }
  
  # Aplicar la función a cada bloque y guardar los resultados en una lista
  lista_texto_bloques <- lapply(lista_bloques, function(bloque) {
    extraer_bloque(texto_crudo, bloque)
  })
  
  # Agregar los bloques de texto extraídos de nuevo al objeto data
  data$pages$blocks[[1]]$layout$bloques_texto <- unlist(lista_texto_bloques)
  data$pages$blocks[[1]]$layout$bloques_id <- seq_along(lista_texto_bloques)
  
  # Crear Tabla con las variables confidence y bloques_texto
  tabla_bloques <- subset(data$pages$blocks[[1]]$layout, select = c(bloques_id, bloques_texto, confidence))
  
  # Definir nombre para el nuevo JSON
  nombre <- gsub("documentai", "documentai_mod", json)
  
  # Escribir el JSON modificado a un archivo
  writeLines(jsonlite::toJSON(data, auto_unbox = TRUE), nombre)
  
  return(tabla_bloques)
}

# Ruta al archivo JSON
json <- "demo/jsons/la_prensa_1902_documentai.json"

# Llamar a la función y obtener la tabla
tabla_bloques <- procesar_json(json)

# Imprimir la tabla resultante
print(tabla_bloques)
