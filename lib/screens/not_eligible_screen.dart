import 'package:flutter/material.dart';

class NotEligibleScreen extends StatelessWidget {
  const NotEligibleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solicitar préstamo')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.block, size: 64, color: Colors.red.shade400),
            const SizedBox(height: 20),
            Text(
              'En este momento no puedes continuar',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              'Según tu respuesta, no cumples con uno de los requisitos mínimos '
              '(ser mayor de edad y contar con cédula de ciudadanía colombiana vigente) '
              'para continuar con este proceso.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
              child: const Text('Volver al inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
