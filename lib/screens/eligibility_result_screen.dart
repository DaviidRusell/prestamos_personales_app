import 'package:flutter/material.dart';
import '../data/questionnaire_data.dart';
import '../theme/app_theme.dart';
import '../utils/eligibility_calculator.dart';
import 'loan_simulator_screen.dart';

class EligibilityResultScreen extends StatelessWidget {
  final List<int?> answers;

  const EligibilityResultScreen({super.key, required this.answers});

  @override
  Widget build(BuildContext context) {
    final favorable = EligibilityCalculator.isFavorableProfile(answers);

    return Scaffold(
      appBar: AppBar(title: const Text('Resultado')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              favorable ? Icons.thumb_up_alt_outlined : Icons.info_outline,
              size: 64,
              color: AppTheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              favorable
                  ? 'Usted cumple con la mayoría de los requisitos'
                  : 'Tu perfil tiene algunos puntos por mejorar',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              favorable
                  ? 'De acuerdo a tus respuestas, tu perfil se ajusta bien a las condiciones '
                    'habituales que piden las entidades prestadoras. Puedes continuar para '
                    'ver una simulación de tu posible crédito.'
                  : 'Algunas de tus respuestas podrían dificultar la aprobación con ciertas '
                    'entidades, pero aún puedes continuar para ver una simulación referencial.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => LoanSimulatorScreen(
                      montoSolicitado:
                          answers[kLoanAmountQuestionIndex]!.toDouble(),
                      meses: monthsFromInstallmentsOptionIndex(
                        answers[kInstallmentsQuestionIndex]!,
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Ver simulación de mi crédito'),
            ),
          ],
        ),
      ),
    );
  }
}
