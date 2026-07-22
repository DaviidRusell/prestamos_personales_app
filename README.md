# Info Crédito App (Flutter)

App informativa de comparación de créditos personales en Colombia. El contenido está
escrito de forma genérica para que puedas adaptarlo a tu propia marca y a las entidades
reales con las que trabajes.

## Cómo ejecutar el proyecto

1. Instala Flutter (https://docs.flutter.dev/get-started/install) si no lo tienes.
2. Descomprime este proyecto y entra a la carpeta:
   ```
   cd credito_informativo_app
   ```
3. Instala las dependencias:
   ```
   flutter pub get
   ```
4. Corre la app en un emulador o dispositivo conectado:
   ```
   flutter run
   ```

## Estructura del proyecto

```
lib/
  main.dart                        -> punto de entrada, abre directo la app principal
  theme/app_theme.dart             -> colores y estilos centralizados (cámbialos por tu marca)
  data/questionnaire_data.dart      -> las 10 preguntas del cuestionario y sus opciones
  utils/eligibility_calculator.dart -> puntaje de elegibilidad a partir de las respuestas
  utils/loan_simulator.dart         -> cálculo referencial de monto, tasa, cuotas y total a pagar
  screens/
    main_navigation.dart            -> barra de navegación inferior
    home_screen.dart                -> pantalla de inicio (botón "Solicitar préstamo")
    how_it_works_screen.dart        -> explicación del proceso paso a paso
    requirements_screen.dart        -> requisitos y rangos de monto/plazo
    faq_screen.dart                 -> preguntas frecuentes
    questionnaire_screen.dart       -> cuestionario de 10 preguntas, 100% seleccionable
    not_eligible_screen.dart        -> bloqueo si es menor de edad o sin cédula vigente
    eligibility_result_screen.dart  -> "Usted cumple con la mayoría de los requisitos"
    loan_simulator_screen.dart      -> simulación de crédito y plan de pago
    redirect_screen.dart            -> mensaje final + botón que sale a la entidad aliada
```

## Flujo completo de solicitud

1. En Inicio, el usuario toca **"Solicitar préstamo"**.
2. Responde el cuestionario: edad, cédula vigente, ingresos, situación laboral, rango
   de ingresos mensuales, cuenta bancaria, deudas activas, reportes negativos, monto
   que necesita y a cuántos meses prefiere pagar.
   - Todas las preguntas son de selección (toca una opción y avanza solo), **excepto
     el monto**, que se ingresa con un teclado numérico. Solo acepta números positivos
     entre \$100.000 y \$10.000.000 (`kMinLoanAmount` / `kMaxLoanAmount` en
     `questionnaire_data.dart`); cualquier otro valor muestra un error y no deja avanzar.
   - La pregunta de plazo ofrece opciones de "2 meses" a "12 meses".
   - Si responde "No" a ser mayor de edad o a tener cédula vigente, se le lleva de
     inmediato a la pantalla de **no elegible** (`not_eligible_screen.dart`).
3. Al terminar, ve la pantalla de resultado: **"Usted cumple con la mayoría de los
   requisitos"** (o un mensaje más cauteloso si el puntaje es bajo), con un botón para
   ver la simulación.
4. En el **simulador de crédito**, se muestra el monto exacto ingresado, una **tasa de
   interés efectiva anual (E.A.) generada aleatoriamente entre 0% y 36%** en cada
   simulación, la fecha de solicitud (hoy), la fecha del primer pago (un mes después) y
   el plan de pago cuota por cuota con su fecha real (una cuota por mes desde el primer
   pago), junto con el aviso de que estos valores son referenciales y pueden variar
   según la entidad prestadora. Se pregunta si desea continuar.
5. Si acepta, pasa a la pantalla final: **"Te estamos dirigiendo con la entidad que
   mejor se ajusta a tu perfil crediticio"**, con un botón que abre, fuera de la app,
   el enlace de la entidad aliada configurado en `redirect_screen.dart`.

## Cómo ajustar el puntaje de elegibilidad o la simulación

- El puntaje se calcula en `eligibility_calculator.dart`. Puedes cambiar el peso de
  cada respuesta o el umbral (`passingThreshold`) según tus propios criterios de negocio.
- La simulación (monto ingresado, tasa efectiva anual aleatoria y relación cuotas/meses)
  está en `loan_simulator.dart`. Ajusta `kMinTasaEA` y `kMaxTasaEA` si necesitas cambiar
  el rango de la tasa aleatoria (actualmente 0% a 36% E.A.), o pasa un valor fijo con el
  parámetro opcional `tasaEfectivaAnual` de `LoanSimulator.simulate()` si prefieres una
  tasa fija en vez de aleatoria.

## Notas legales importantes

- La app está redactada como **comparador informativo**: dejamos explícito en varias
  pantallas que el crédito final lo otorga una entidad financiera aliada, no la app, y
  que los valores del simulador son referenciales.
- Antes de publicarla, revisa con un abogado los textos legales, tratamiento de datos
  personales (Ley 1581 de 2012 en Colombia) y cualquier autorización de consulta en
  centrales de riesgo que necesites agregar.
- El enlace de redirección final es una URL externa de un tercero (entidad/afiliado):
  verifica que cumpla con la normativa de publicidad y protección al consumidor
  aplicable antes de publicar la app.
