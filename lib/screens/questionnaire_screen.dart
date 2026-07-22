import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/questionnaire_data.dart';
import '../theme/app_theme.dart';
import 'not_eligible_screen.dart';
import 'eligibility_result_screen.dart';

/// Cuestionario del flujo de solicitud. La mayoría de preguntas son de
/// selección múltiple (se toca una opción y avanza solo); la pregunta del
/// monto a solicitar es la única que se ingresa como número.
class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  int _currentIndex = 0;
  late final List<int?> _answers =
      List<int?>.filled(quizQuestions.length, null);

  final TextEditingController _amountController = TextEditingController();
  String? _amountError;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_currentIndex == quizQuestions.length - 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => EligibilityResultScreen(answers: _answers),
        ),
      );
      return;
    }
    setState(() => _currentIndex++);
  }

  void _selectOption(int optionIndex) {
    final question = quizQuestions[_currentIndex];
    setState(() => _answers[_currentIndex] = optionIndex);

    if (question.blockingOptionIndex != null &&
        optionIndex == question.blockingOptionIndex) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const NotEligibleScreen()),
      );
      return;
    }

    Future.delayed(const Duration(milliseconds: 150), () {
      if (!mounted) return;
      _goNext();
    });
  }

  void _submitAmount() {
    final question = quizQuestions[_currentIndex];
    final raw = _amountController.text.trim();

    if (raw.isEmpty) {
      setState(() => _amountError = 'Ingresa un valor.');
      return;
    }

    final value = int.tryParse(raw);
    if (value == null || value <= 0) {
      setState(() => _amountError = 'Ingresa solo números positivos.');
      return;
    }

    if (value < question.minValue! || value > question.maxValue!) {
      setState(() {
        _amountError =
            'El monto debe estar entre \$${question.minValue} y \$${question.maxValue}.';
      });
      return;
    }

    setState(() {
      _answers[_currentIndex] = value;
      _amountError = null;
    });
    _goNext();
  }

  @override
  Widget build(BuildContext context) {
    final question = quizQuestions[_currentIndex];
    final progress = (_currentIndex + 1) / quizQuestions.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Solicitar préstamo')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade200,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pregunta ${_currentIndex + 1} de ${quizQuestions.length}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 24),
              Text(
                question.question,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: question.type == QuestionType.numericInput
                    ? _buildNumericInput(question)
                    : _buildOptionsList(question),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionsList(QuizQuestion question) {
    return ListView.separated(
      itemCount: question.options.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final selected = _answers[_currentIndex] == i;
        return InkWell(
          onTap: () => _selectOption(i),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            decoration: BoxDecoration(
              color: selected ? AppTheme.primary.withOpacity(0.08) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected ? AppTheme.primary : Colors.grey.shade300,
                width: selected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    question.options[i],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                      color: selected ? AppTheme.primaryDark : AppTheme.textDark,
                    ),
                  ),
                ),
                if (selected)
                  const Icon(Icons.check_circle, color: AppTheme.primary)
                else
                  Icon(Icons.circle_outlined, color: Colors.grey.shade400),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNumericInput(QuizQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Entre \$${question.minValue} y \$${question.maxValue}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(8),
          ],
          style: const TextStyle(fontSize: 20),
          decoration: InputDecoration(
            prefixText: '\$ ',
            hintText: 'Ej: 1500000',
            border: const OutlineInputBorder(),
            errorText: _amountError,
          ),
          onSubmitted: (_) => _submitAmount(),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _submitAmount,
          child: const Text('Continuar'),
        ),
      ],
    );
  }
}
