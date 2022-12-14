# Banco Central de Costa Rica
# Cuenta Satélite de Bioeconomía
# Consultor CEPAL: Renato Vargas

# PREÁMBULO

# Limpiar el área de trabajo
rm(list = ls())

# Llamar librerías
library(readxl)
library(openxlsx)
library(reshape2)
library(stringr)
library(plyr)


# Código iso3 de país

iso <- "CRI"

# Lógica recursiva
# ================

archivo <- "datos/CR_COUs_2017-2020.xlsx"
hojas <- excel_sheets(archivo)

# Eliminamos las que no vamos a usar
hojas <- hojas[-c(5:9)]

# Creamos una lista para llevar registro de
# los objetos que vamos creando.
lista <- c("inicio")

# Índice de la primera iteración
# Escogemos 2018 para referencia
i<- 1

# Iniciamos el bucle
# for (i in 1:length(hojas)) {
  
  # Extraemos el año y la unidad de medida
  info <- read_excel(
    archivo,
    range = paste("'", hojas[i], "'!c5:c6", sep = "") ,
    col_names = FALSE,
    col_types = "text",
  )
  
  # Extraemos el año de la cadena de caracteres
  anio <- as.numeric((str_extract(info[1,], "\\d{4}")))
  
  # Unidad de medida
  unidad <- toString(info[2,])
  
  # Precios  
  precios <- "Corrientes"
  
  
  # Cuadro de Oferta
  # ================
  
  oferta <- as.matrix(read_excel(
    archivo,
    range = paste("'" , hojas[i], "'!C14:QB199", sep = ""),
    col_names = FALSE,
    col_types = "numeric"
  ))
  
  # Si hay algún valor sin dato "N/A" lo cambiamos por cero
  oferta[is.na(oferta)] <- 0.0
  
  # Damos un identificador correlativo a las filas y columnas
  # código ISO en la forma "ISO3of001" o "ISO3oc001"
  
  rownames(oferta) <- c(sprintf(paste(iso, "of%03d", sep = ""), seq(1, dim(oferta)[1])))
  colnames(oferta) <- c(sprintf(paste(iso, "oc%03d", sep = ""), seq(1, dim(oferta)[2])))
  
  # Columnas a eliminar con subtotales y totales
  
  of_omitir_columnas <- c(
    1,4,7,10,13,16,19,22,25,28,31,34,37,40,43,46,49,52,55,
    58,61,64,67,70,73,76,79,82,85,88,91,94,97,100,103,107,
    110,113,117,121,124,127,131,134,137,141,148,151,154,158,
    161,164,168,171,176,179,182,185,188,191,194,197,200,203,
    206,209,212,215,218,221,224,227,230,233,237,240,244,247,
    250,254,257,260,263,266,269,272,275,278,281,284,288,292,
    295,298,301,304,307,310,313,316,320,323,326,329,332,335,
    338,341,344,347,350,353,356,359,360,361,362,365,368,371,
    374,377,380,383,384,385,386,389,392,395,398,401,404,407,
    410,413,414,415,416,417,418,419,420,423,426,427,429,434,
    438,439
    )
  
  of_omitir_filas <- c(
    185
  )
  
  # Matriz con filas y columnas omitidas
  oferta1 <- oferta[-of_omitir_filas,-of_omitir_columnas]

  # Desdoblamos
  oferta <- cbind(anio, precios, 1, "Oferta", melt(oferta1), unidad)
  
  colnames(oferta) <-
    c("Año",
      "Precios",
      "No. Cuadro",
      "Cuadro",
      "Filas",
      "Columnas",
      "Valor",
      "Unidades")
  
  
  # Cuadro de utilización
  # =====================
  
  utilizacion <- as.matrix(read_excel(
    archivo,
    range = paste("'" , hojas[i], "'!C214:QC399", sep = ""),
    col_names = FALSE,
    col_types = "numeric"
  ))
  
  utilizacion[is.na(utilizacion)] <- 0.0
  
  rownames(utilizacion) <- c(sprintf(paste(iso, "uf%03d", sep = ""), seq(1, dim(utilizacion)[1])))
  colnames(utilizacion) <- c(sprintf(paste(iso, "uc%03d", sep = ""), seq(1, dim(utilizacion)[2])))

  ut_omitir_columnas <- c(
    1,4,7,10,13,16,19,22,25,28,31,34,37,40,43,46,49,52,55,
    58,61,64,67,70,73,76,79,82,85,88,91,94,97,100,103,107,
    110,113,117,121,124,127,131,134,137,141,148,151,154,158,
    161,164,168,171,176,179,182,185,188,191,194,197,200,203,
    206,209,212,215,218,221,224,227,230,233,237,240,244,247,
    250,254,257,260,263,266,269,272,275,278,281,284,288,292,
    295,298,301,304,307,310,313,316,320,323,326,329,332,335,
    338,341,344,347,350,353,356,359,360,361,362,365,368,371,
    374,377,380,383,384,385,386,389,392,395,398,401,404,407,
    410,413,414,415,416,417,418,419,420,423,426,427,431,434,
    435,439,440
  )
  
  ut_omitir_filas <- c(
    185
  )
  
  utilizacion1 <- utilizacion[-ut_omitir_filas,-ut_omitir_columnas]
  
  
  round(as.matrix(rowSums(oferta1)) - as.matrix(rowSums(utilizacion1)))
  
  
  # Desdoblamos
  utilizacion <-
    cbind(anio,
          precios,
          2,
          "Utilización",
          melt(utilizacion1),
          unidad)
  
  colnames(utilizacion) <-
    c("Año",
      "Precios",
      "No. Cuadro",
      "Cuadro",
      "Filas",
      "Columnas",
      "Valor",
      "Unidades")
  
  
  # Cuadros de Valor Agregado y empleo solo para precios Corrientes
  # ========================
  
  # Cuadro de Valor Agregado
  # ========================
  
  valorAgregado <- as.data.frame(read_excel(
    archivo,
    range = paste("'" , hojas[i], "'!c167:bn167", sep = ""),
    col_names = FALSE,
    col_types = "numeric"
  ))
  rownames(valorAgregado) <-
    c(sprintf("vf%03d", seq(1, dim(valorAgregado)[1])))
  colnames(valorAgregado) <-
    c(sprintf("vc%03d", seq(1, dim(valorAgregado)[2])))
  valorAgregado[is.na(valorAgregado)] <- 0.0
  
  #   Columnas a eliminar con subtotales y totales
  
  #   vc093	SUBTOTAL DE MERCADO
  #   vc098	SUBTOTAL USO FINAL PROPIO
  #   vc108	SUBTOTAL NO DE MERCADO
  #   vc109 TOTAL
  
  valorAgregado <- valorAgregado[,-c(1, 2, 3)]
  
  # Desdoblamos
  valorAgregado <-
    cbind(anio,
          precios,
          3,
          "Valor Agregado",
          "vf001",
          melt(valorAgregado),
          unidad)
  
  colnames(valorAgregado) <-
    c("Año",
      "Precios",
      "No. Cuadro",
      "Cuadro",
      "Filas",
      "Columnas",
      "Valor",
      "Unidades")
  
  # Empleo
  # ======
  #   empleo <- as.data.frame(read_excel(
  #     archivo,
  #     range = paste("'" , hojas[i], "'!D332:DH332", sep = ""),
  #     col_names = FALSE,
  #     col_types = "numeric"
  #   ))
  #   rownames(empleo) <- c(sprintf("ef%03d", seq(1, dim(empleo)[1])))
  #   colnames(empleo) <- c(sprintf("ec%03d", seq(1, dim(empleo)[2])))
  #
  #   #   Columnas a eliminar con subtotales y totales
  #
  #   #   vc093	SUBTOTAL DE MERCADO
  #   #   vc098	SUBTOTAL USO FINAL PROPIO
  #   #   vc108	SUBTOTAL NO DE MERCADO
  #   #   vc109 TOTAL
  #
  #   empleo <- empleo[, -c(93, 98, 108, 109)]
  #
  #   #Desdoblamos
  #   empleo <- cbind(anio,
  #                   precios,
  #                   4,
  #                   "Empleo",
  #                   "ef001",
  #                   melt(empleo),
  #                   "Puestos de trabajo")
  #
  #   colnames(empleo) <- c("Año",
  #                         "Precios",
  #                         "No. Cuadro",
  #                         "Cuadro",
  #                         "Filas",
  #                         "Columnas",
  #                         "Valor",
  #                         "Unidades")
  #
  #
  # # Unimos todas las partes
  # if (precios == "Corrientes") {
  #   union <- rbind(oferta,
  #                  utilizacion,
  #                  valorAgregado,
  #                  empleo)
  #
  union <- rbind(oferta, utilizacion, valorAgregado)
  assign(paste("COU_", anio, "_", precios, sep = ""),
         union)
  lista <- c(lista, paste("COU_", anio, "_", precios, sep = ""))

  
# } # Cierre del bucle original

# Actualizamos nuestra lista de objetos creados
lista <- lapply(lista[-1], as.name)

# Unimos los objetos de todos los años y precios
SCN <- do.call(rbind.data.frame, lista)

# Y borramos los objetos individuales
do.call(rm,lista)



# Le damos significado a las filas y columnas

clasificacionColumnas <- read_xlsx("COL_Clasificaciones.xlsx",
                                   sheet = "columnas",
                                   col_names = TRUE,)

clasificacionFilas <- read_xlsx("COL_Clasificaciones.xlsx",
                                sheet = "filas",
                                col_names = TRUE,)

#SCN <- join(SCN,clasificacionColumnas,by = "Columnas")
#SCN <- join(SCN,clasificacionFilas, by = "Filas")
gc()

# Y lo exportamos a Excel
write.xlsx(
  SCN,
  "salidas/COL_SCN_BD.xlsx",
  sheetName= "COL_SCN_BD",
  rowNames=FALSE,
  colnames=FALSE,
  overwrite = TRUE,
  asTable = FALSE
)
