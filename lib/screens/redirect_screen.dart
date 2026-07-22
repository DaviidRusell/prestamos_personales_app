import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

/// Última pantalla del flujo: informa al usuario que será dirigido
/// a la entidad prestadora aliada y abre el enlace externo correspondiente.
class RedirectScreen extends StatelessWidget {
  const RedirectScreen({super.key});

  // TODO: si en el futuro el enlace depende del perfil del usuario,
  // reemplaza esta constante por un valor calculado a partir de las respuestas.
  static const String _entityUrl =
      'https://7aab2.bemobtrcks.com/go/7ba27b58-faa0-458c-b504-d95fc41e7d45';

  Future<void> _openEntityLink(BuildContext context) async {
    final uri = Uri.parse(_entityUrl);
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No fue posible abrir el enlace. Intenta de nuevo.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Redirigiendo')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.handshake_outlined, size: 64, color: AppTheme.primary),
            const SizedBox(height: 20),
            Text(
              'Te estamos dirigiendo con la entidad que mejor se ajusta a tu perfil crediticio',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              'Vas a salir de esta app para continuar el proceso directamente con la entidad aliada.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              onPressed: () => _openEntityLink(context),
              icon: const Icon(Icons.open_in_new),
              label: const Text('Continuar con la entidad'),
            ),
          ],
        ),
      ),
    );
  }
}
