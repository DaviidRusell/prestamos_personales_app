import 'dart:math';

/// Simulador simple de crédito. Los valores son referenciales y NO
/// representan una oferta real: cada entidad prestadora define sus
/// propias tasas y condiciones finales.
class LoanInstallment {
  final int numero;
  final DateTime fecha;
  final double valor;

  const LoanInstallment({
    required this.numero,
    required this.fecha,
    required this.valor,
  });
}

class LoanSimulation {
  final double montoSolicitado;
  final int numeroCuotas;
  final double
      tasaEfectivaAnual; // ej: 0.18 = 18% E.A., aleatoria entre 0% y 36%
  final double tasaMensualEquivalente;
  final double totalAPagar;
  final double valorPorCuota;
  final DateTime fechaSolicitud;
  final DateTime fechaPrimerPago;
  final List<LoanInstallment> planDePago;

  const LoanSimulation({
    required this.montoSolicitado,
    required this.numeroCuotas,
    required this.tasaEfectivaAnual,
    required this.tasaMensualEquivalente,
    required this.totalAPagar,
    required this.valorPorCuota,
    required this.fechaSolicitud,
    required this.fechaPrimerPago,
    required this.planDePago,
  });
}

class LoanSimulator {
  static const double kMinTasaEA = 0.0; // 0%
  static const double kMaxTasaEA = 0.35; // 36%

  static final Random _random = Random();

  /// Genera una Tasa Efectiva Anual aleatoria entre kMinTasaEA y kMaxTasaEA.
  static double _randomTasaEA() {
    return kMinTasaEA + _random.nextDouble() * (kMaxTasaEA - kMinTasaEA);
  }

  /// Convierte una tasa efectiva anual a su equivalente mensual.
  static double _tasaMensualDesdeEA(double tasaEA) {
    return pow(1 + tasaEA, 1 / 12).toDouble() - 1;
  }

  /// Suma [months] meses calendario a una fecha (respeta fin de mes de forma simple).
  static DateTime _addMonths(DateTime date, int months) {
    final totalMonth = date.month + months;
    final year = date.year + ((totalMonth - 1) ~/ 12);
    final month = ((totalMonth - 1) % 12) + 1;
    final lastDayOfTargetMonth = DateTime(year, month + 1, 0).day;
    final day =
        date.day > lastDayOfTargetMonth ? lastDayOfTargetMonth : date.day;
    return DateTime(year, month, day);
  }

  static LoanSimulation simulate({
    required double montoSolicitado,
    required int meses,
    DateTime? fechaSolicitud,
    double? tasaEfectivaAnual,
  }) {
    final solicitud = fechaSolicitud ?? DateTime.now();
    final primerPago = _addMonths(solicitud, 1);

    final tasaEA = tasaEfectivaAnual ?? _randomTasaEA();
    final tasaMensual = _tasaMensualDesdeEA(tasaEA);

    final interesTotal = montoSolicitado * tasaMensual * meses;
    final totalAPagar = montoSolicitado + interesTotal;
    final valorCuota = totalAPagar / meses;

    final plan = List.generate(meses, (i) {
      return LoanInstallment(
        numero: i + 1,
        fecha: _addMonths(primerPago, i),
        valor: valorCuota,
      );
    });

    return LoanSimulation(
      montoSolicitado: montoSolicitado,
      numeroCuotas: meses,
      tasaEfectivaAnual: tasaEA,
      tasaMensualEquivalente: tasaMensual,
      totalAPagar: totalAPagar,
      valorPorCuota: valorCuota,
      fechaSolicitud: solicitud,
      fechaPrimerPago: primerPago,
      planDePago: plan,
    );
  }
}
