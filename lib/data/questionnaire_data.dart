/// Tipo de pregunta: selección de una opción, o entrada numérica
/// (usada únicamente para el monto solicitado).
enum QuestionType { singleSelect, numericInput }

/// Modelo de una pregunta del cuestionario.
class QuizQuestion {
  final String question;
  final List<String> options;
  final QuestionType type;

  /// Si el usuario selecciona esta opción, el flujo se detiene
  /// y se muestra la pantalla de "no elegible" (ej: ser menor de edad).
  final int? blockingOptionIndex;

  /// Solo aplica para preguntas de tipo numericInput.
  final int? minValue;
  final int? maxValue;

  const QuizQuestion({
    required this.question,
    this.options = const [],
    this.type = QuestionType.singleSelect,
    this.blockingOptionIndex,
    this.minValue,
    this.maxValue,
  });
}

/// Cantidad mínima y máxima que se puede solicitar.
const int kMinLoanAmount = 100000;
const int kMaxLoanAmount = 10000000;

/// Las 10 preguntas del cuestionario. Todas se responden tocando una opción,
/// excepto el monto a solicitar, que se ingresa como número.
const List<QuizQuestion> quizQuestions = [
  QuizQuestion(
    question: '¿Eres mayor de 18 años?',
    options: ['Sí', 'No'],
    blockingOptionIndex: 1,
  ),
  QuizQuestion(
    question: '¿Tienes cédula de ciudadanía colombiana vigente?',
    options: ['Sí', 'No'],
    blockingOptionIndex: 1,
  ),
  QuizQuestion(
    question: '¿Tienes ingresos actualmente?',
    options: ['Sí', 'No'],
  ),
  QuizQuestion(
    question: '¿Cuál es tu situación laboral?',
    options: ['Empleado', 'Independiente', 'Pensionado', 'Estudiante'],
  ),
  QuizQuestion(
    question: '¿Cuánto ganas al mes aproximadamente?',
    options: [
      'Menos de \$1.000.000',
      '\$1.000.000 - \$2.000.000',
      '\$2.000.000 - \$4.000.000',
      'Más de \$4.000.000',
    ],
  ),
  QuizQuestion(
    question: '¿Tienes una cuenta bancaria activa a tu nombre?',
    options: ['Sí', 'No'],
  ),
  QuizQuestion(
    question: '¿Tienes deudas activas en este momento?',
    options: ['Sí', 'No'],
  ),
  QuizQuestion(
    question: '¿Tienes reportes negativos en centrales de riesgo?',
    options: ['Sí', 'No'],
  ),
  QuizQuestion(
    question: '¿Cuánto necesitas solicitar?',
    type: QuestionType.numericInput,
    minValue: kMinLoanAmount,
    maxValue: kMaxLoanAmount,
  ),
  QuizQuestion(
    question: '¿A cuántos meses prefieres pagar?',
    options: [
      '2 meses',
      '3 meses',
      '4 meses',
      '5 meses',
      '6 meses',
      '7 meses',
      '8 meses',
      '9 meses',
      '10 meses',
      '11 meses',
      '12 meses',
    ],
  ),
];

// Índices fijos (dentro de quizQuestions) de las preguntas que alimentan
// el simulador de crédito.
const int kIncomeRangeQuestionIndex = 4; // ¿Cuánto ganas al mes?
const int kLoanAmountQuestionIndex = 8; // ¿Cuánto necesitas solicitar? (monto exacto ingresado)
const int kInstallmentsQuestionIndex = 9; // ¿A cuántos meses prefieres pagar? (índice de opción)

/// La opción de índice 0 equivale a 2 meses, índice 1 a 3 meses, etc.
int monthsFromInstallmentsOptionIndex(int optionIndex) => optionIndex + 2;
