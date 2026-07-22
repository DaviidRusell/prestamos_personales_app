import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';
import '../utils/loan_simulator.dart';
import 'redirect_screen.dart';

class LoanSimulatorScreen extends StatelessWidget {
  final double montoSolicitado;
  final int meses;

  const LoanSimulatorScreen({
    super.key,
    required this.montoSolicitado,
    required this.meses,
  });

  @override
  Widget build(BuildContext context) {
    final sim = LoanSimulator.simulate(
      montoSolicitado: montoSolicitado,
      meses: meses,
    );
    final currency = NumberFormat.currency(locale: 'es_CO', symbol: '\$', decimalDigits: 0);
    final dateFormat = DateFormat('d MMMM yyyy', 'es_CO');

    return Scaffold(
      appBar: AppBar(title: const Text('Simulación de tu crédito')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.06),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.primary.withOpacity(0.25)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SimRow(label: 'Monto solicitado', value: currency.format(sim.montoSolicitado)),
                _SimRow(label: 'Fecha de solicitud', value: dateFormat.format(sim.fechaSolicitud)),
                _SimRow(label: 'Fecha del primer pago', value: dateFormat.format(sim.fechaPrimerPago)),
                _SimRow(label: 'Número de cuotas', value: '${sim.numeroCuotas}'),
                _SimRow(
                  label: 'Tasa de interés efectiva anual (E.A.)',
                  value: '${(sim.tasaEfectivaAnual * 100).toStringAsFixed(1)}%',
                ),
                const Divider(height: 28),
                _SimRow(
                  label: 'Total estimado a pagar',
                  value: currency.format(sim.totalAPagar),
                  emphasize: true,
                ),
                _SimRow(
                  label: 'Valor estimado por cuota',
                  value: currency.format(sim.valorPorCuota),
                  emphasize: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text('Plan de pago estimado', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: Column(
              children: sim.planDePago.map((cuota) {
                return ListTile(
                  dense: true,
                  leading: CircleAvatar(
                    radius: 14,
                    backgroundColor: AppTheme.primary.withOpacity(0.12),
                    child: Text(
                      '${cuota.numero}',
                      style: const TextStyle(fontSize: 12, color: AppTheme.primaryDark),
                    ),
                  ),
                  title: Text('Cuota ${cuota.numero}'),
                  subtitle: Text(dateFormat.format(cuota.fecha)),
                  trailing: Text(currency.format(cuota.valor)),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: const Text(
              'Esta simulación es referencial. La tasa efectiva anual mostrada es generada '
              'de forma aleatoria dentro de un rango entre 0% y 36% únicamente con fines '
              'ilustrativos. Los valores reales (tasa, monto aprobado, fechas y número de '
              'cuotas) siempre dependen de la entidad prestadora que finalmente evalúe tu '
              'solicitud.',
              style: TextStyle(fontSize: 13, color: AppTheme.textMuted),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '¿Estás de acuerdo con esta simulación? ¿Deseas continuar?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
                  child: const Text('No, volver'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RedirectScreen()),
                    );
                  },
                  child: const Text('Sí, continuar'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SimRow extends StatelessWidget {
  final String label;
  final String value;
  final bool emphasize;

  const _SimRow({required this.label, required this.value, this.emphasize = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppTheme.textMuted)),
          Text(
            value,
            style: TextStyle(
              fontWeight: emphasize ? FontWeight.bold : FontWeight.w600,
              fontSize: emphasize ? 17 : 15,
              color: AppTheme.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
