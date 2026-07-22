/// Calcula un puntaje simple de elegibilidad a partir de las respuestas
/// del cuestionario (índices seleccionados por pregunta).
/// No es un cálculo financiero real: es solo una guía informativa para
/// mostrarle al usuario si su perfil luce favorable antes de continuar.
class EligibilityCalculator {
  /// answers debe tener el mismo largo que quizQuestions, con el índice
  /// de la opción elegida en cada posición.
  static int calculateScore(List<int?> answers) {
    int score = 0;

    // Pregunta 3: ¿Tienes ingresos actualmente? (Sí = índice 0)
    if (answers[2] == 0) score += 2;

    // Pregunta 4: situación laboral (Empleado/Independiente/Pensionado suman, Estudiante no)
    if (answers[3] != null && answers[3]! <= 2) score += 1;

    // Pregunta 5: rango de ingresos mensuales (a mayor rango, más puntos)
    if (answers[4] != null) score += answers[4]!;

    // Pregunta 6: ¿Cuenta bancaria activa? (Sí = índice 0)
    if (answers[5] == 0) score += 2;

    // Pregunta 7: ¿Deudas activas? (No = índice 1 es lo favorable)
    if (answers[6] == 1) score += 1;

    // Pregunta 8: ¿Reportes negativos? (No = índice 1 es lo favorable)
    if (answers[7] == 1) score += 2;

    return score;
  }

  static const int maxScore = 11;
  static const int passingThreshold = 6;

  static bool isFavorableProfile(List<int?> answers) {
    return calculateScore(answers) >= passingThreshold;
  }
}
