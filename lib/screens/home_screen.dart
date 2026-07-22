import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'questionnaire_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.primary, AppTheme.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Encuentra el crédito que se ajuste a ti',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Comparamos opciones de distintas entidades para que elijas '
                  'la que más te convenga, de forma gratuita e informativa.',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.primaryDark,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const QuestionnaireScreen()),
                    );
                  },
                  child: const Text('Solicitar préstamo'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('¿Por qué usar este comparador?', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          const _FeatureTile(
            icon: Icons.speed,
            title: 'Respuesta rápida',
            subtitle: 'La mayoría de solicitudes se procesan en minutos.',
          ),
          const _FeatureTile(
            icon: Icons.compare_arrows,
            title: 'Varias opciones',
            subtitle: 'Comparamos condiciones de distintas entidades a la vez.',
          ),
          const _FeatureTile(
            icon: Icons.lock_outline,
            title: 'Datos protegidos',
            subtitle: 'Tu información se usa únicamente para gestionar tu solicitud.',
          ),
          const _FeatureTile(
            icon: Icons.money_off,
            title: 'Sin costo por usar el comparador',
            subtitle: 'Consultar y comparar información no tiene ningún cargo.',
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
              'Este comparador no otorga créditos directamente. El desembolso final '
              'siempre depende de una entidad financiera aliada, que es responsable '
              'de aprobar y entregar el crédito.',
              style: TextStyle(fontSize: 13, color: AppTheme.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureTile({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.primary.withOpacity(0.1),
          child: Icon(icon, color: AppTheme.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
