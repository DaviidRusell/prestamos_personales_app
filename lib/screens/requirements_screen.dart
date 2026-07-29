import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RequirementsScreen extends StatelessWidget {
  const RequirementsScreen({super.key});

  static const _requirements = [
    'Ser mayor de 18 años.',
    'Cédula de ciudadanía colombiana vigente.',
    'Número de celular activo y correo electrónico.',
    'Cuenta bancaria a tu nombre para recibir el desembolso.',
    'No es obligatorio tener un historial crediticio perfecto: cada entidad evalúa con sus propios criterios.',
  ];

  static const _ranges = [
    (
      'Monto',
      '\$100.000 – \$10.000.000 COP (referencial, varía según la entidad)'
    ),
    (
      'Plazo',
      'Desde 2 meses hasta 12 meses (referencial, varía según la entidad)'
    ),
    ('Tiempo de respuesta', 'Generalmente entre minutos y algunas horas'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Requisitos')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Requisitos generales',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ..._requirements.map(
            (r) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle,
                      color: AppTheme.primary, size: 20),
                  const SizedBox(width: 10),
                  Expanded(child: Text(r)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Rangos habituales',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ..._ranges.map(
            (item) => Card(
              margin: const EdgeInsets.only(bottom: 10),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: ListTile(
                title: Text(item.$1,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(item.$2),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: const Text(
              'Los montos, plazos y tasas finales dependen siempre de la entidad '
              'financiera que apruebe la solicitud. Verifica las condiciones exactas '
              'antes de firmar cualquier contrato.',
              style: TextStyle(fontSize: 13, color: AppTheme.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}
