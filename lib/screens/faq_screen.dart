import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  static const _faqs = [
    (
      '¿Usar esta app tiene algún costo?',
      'No. Consultar información y comparar opciones es gratuito. Cada entidad informa por su cuenta si aplica algún cobro sobre el crédito otorgado.',
    ),
    (
      '¿Necesito tener buen historial crediticio?',
      'No siempre. Distintas entidades evalúan con criterios distintos, por lo que puedes recibir opciones incluso si tu historial no es perfecto.',
    ),
    (
      '¿Quién otorga el crédito finalmente?',
      'El desembolso lo realiza la entidad financiera aliada que apruebe tu solicitud, no esta aplicación.',
    ),
    (
      '¿Mis datos están seguros?',
      'La información que compartes se usa únicamente para gestionar tu solicitud y contactarte con opciones relevantes.',
    ),
    (
      '¿Cuánto tiempo tarda la respuesta?',
      'Varía según la entidad, pero muchas solicitudes reciben una primera respuesta en minutos.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preguntas frecuentes')),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _faqs.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final (question, answer) = _faqs[index];
          return Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: ExpansionTile(
                iconColor: AppTheme.primary,
                collapsedIconColor: AppTheme.textMuted,
                title: Text(question, style: const TextStyle(fontWeight: FontWeight.w600)),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(answer, style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
