import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  static const _steps = [
    (
      'Completa el formulario',
      'Indica el monto que necesitas, el plazo que buscas y algunos datos básicos de contacto.',
      Icons.edit_note,
    ),
    (
      'Recibe opciones comparadas',
      'Revisamos condiciones de distintas entidades y te mostramos las que mejor encajan con lo que pediste.',
      Icons.fact_check_outlined,
    ),
    (
      'Elige la que más te convenga',
      'Compara tasa, plazo y cuotas antes de decidir. Tú tienes la última palabra.',
      Icons.checklist_rtl,
    ),
    (
      'Continúa directamente con la entidad',
      'Si aceptas una oferta, el trámite final (firma y desembolso) lo gestionas con esa entidad.',
      Icons.account_balance_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cómo funciona')),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _steps.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final (title, description, icon) = _steps[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppTheme.primary,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(icon, size: 18, color: AppTheme.primary),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(description, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
