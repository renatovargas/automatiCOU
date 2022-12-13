# AutomatiCOU

Formación de capacidades en cuantificación macroeconómica de bioeconomía y automatización de procesos de cuentas satélite con el Cuadro de Oferta y Utilización

## Introducción

En el marco de actividades de cooperación entre el Banco Central de Costa Rica (BCCR) y la Comisión Económica para América Latina (CEPAL) se desarrolló un ejercicio piloto para la elaboración de una Cuenta Satélite de Bioeconomía para Costa Rica. Esta cuenta representa un desarrollo metodológico y una contribución importante al estado de la ciencia en cuanto a la cuantificación macroeconómica de lo que la base biológica contribuye al valor agregado del país y Costa Rica es pionero en su implementación práctica en la región. Además, para cumplir con los objetivos de la cuenta en términos de tiempo y alcance, el ejercicio requirió del uso de tecnologías de información para el manejo y análisis de información que dieron como resultado una serie de rutinas del lenguaje de programación R novedosas.  Estas rutinas constituyen un avance metodológico en sí mismas que pueden ser útiles, no solo para la actualización regular de la Cuenta de Bioeconomía, sino para el manejo de la información para otros ejercicios satélite, como el de cuentas ambientales, por ejemplo. 

Por esa razón se contempla la realización de un taller de formación de capacidades en cuantificación macroeconómica de bioeconomía y automatización de procesos de cuentas satélite con el Cuadro de Oferta y Utilización para funcionarios del Banco Central de Costa Rica.

## Objetivos del taller de formación de capacidades

El objetivo general es presentar a los participantes aplicaciones prácticas sobre el uso de "R" (tecnología de código abierto que proporciona transparencia) para el manejo de datos macroeconómicos para la elaboración de cuentas satélite.

Después de la capacitación, los participantes deberían poder actualizar la Cuenta Satélite de Bioeconomía (CSB) utilizando las rutinas de R aprendidas durante el taller. Además, deberían sentirse cómodos con la aplicación de los conceptos de manejo de datos macroeconómicos para la generación de otras cuentas satélite, así como de otras aplicaciones y procesos internos.

- Trasladar los conceptos básicos de bioeconomía y los desarrollos metodológicos empleados para integrar esa temática al análisis macroeconómico, utilizando los conceptos establecidos en el Sistema de Cuentas Nacionales (en su más reciente revisión de 2008) para la creación de cuentas satélite.
- Trasladar los hallazgos de la CSB a los funcionarios del BCCR.
- Formar a los funcionarios del BCCR en los conceptos básicos del ambiente de programación R que permitan la comprensión de las rutinas de manejo de datos para la elaboración de la CSB.
- Formar a los funcionarios del BCCR en la elaboración de rutinas del manejo de datos macroeconómicos de los cuadros de oferta y utilización con el ambiente de programación R de manera que las rutinas sean útiles para acelerar y automatizar procesos de generación de cuentas satélite y otros análisis.
- Mostrar a los funcionarios del BCCR, otras aplicaciones prácticas para esas rutinas de programación.

## Requisitos

Los requisitos mínimos son tener acceso a una computadora individual con el paquete “R” y el paquete RStudio instalado y de preferencia con permisos de administrador habilitados para poder instalar extensiones de R. Adicionalmente se deberá tener acceso a un programa de hojas de cálculo como Excel o [LibreOffice](https://www.libreoffice.org/download/download/). Las instrucciones se enviarán por adelantado, pero los participantes deben asegurarse de que su computadora no bloquee el acceso a software y materiales de código abierto. Ser usuario de Excel y tener una noción razonable de álgebra será útil, pero no una condición necesaria para participar en la capacitación. Tampoco se requiere ningún conocimiento de programación pues se inciará desde cero y se mostrará lo necesario para la comprensión de las rutinas de análisis desarrolladas para la elaboración de la CSB. El software indispensable a instalar se debe obtener libre de cargos en los siguientes vínculos y deberán ser instalados en este orden antes del taller:

- [R-project](https://cran.microsoft.com/) 
- [RStudio](https://www.rstudio.com/products/rstudio/)

Una vez instalados estos programas, también es importante contar con librerías específicas, las cuales pueden ser instaladas desde la interface de RStudio (menú Tools/ Install packages o Herramientas/Instalar paquetes) o a través de la línea de comando de R, copiando lo siguiente:

```
  install.packages(c("readxl", "openxlsx", "reshape2", 
                   "stringr", "plyr", "RSQLite", 
                   "DBI", "readr", "pivottabler"))
```