/// Lógica de validación de edad mínima.
/// Es 100% local (no depende de ningún servicio externo).
/// Si más adelante quieres validar contra un documento real (cédula),
/// este es el lugar donde reemplazarías el cálculo por una llamada a una
/// API de verificación de identidad (ver README.md del proyecto).
class AgeValidator {
  static const int minAge = 18;

  /// Calcula la edad exacta a partir de la fecha de nacimiento.
  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    final hasHadBirthdayThisYear = (now.month > birthDate.month) ||
        (now.month == birthDate.month && now.day >= birthDate.day);
    if (!hasHadBirthdayThisYear) age--;
    return age;
  }

  static bool isOfLegalAge(DateTime birthDate) {
    return calculateAge(birthDate) >= minAge;
  }
}
