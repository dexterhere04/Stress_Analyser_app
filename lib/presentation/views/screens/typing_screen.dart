import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:destresser/presentation/viewmodels/typing_viewmodel.dart';
import 'package:destresser/presentation/views/widgets/stat_card.dart';
import 'package:destresser/core/theme/app_theme.dart';
import 'package:destresser/data/models/typing_metrics.dart';

class TypingScreen extends ConsumerStatefulWidget {
  const TypingScreen({super.key});

  @override
  ConsumerState<TypingScreen> createState() => _TypingScreenState();
}

class _TypingScreenState extends ConsumerState<TypingScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(typingViewModelProvider.notifier).loadRecentSessions();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(typingViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Typing Analysis')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTypingSessionCard(vm),
            const SizedBox(height: 24),
            _buildStatsGrid(vm),
            const SizedBox(height: 24),
            _buildRecentSessions(vm),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingSessionCard(TypingViewModel vm) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              vm.isSessionActive ? Icons.keyboard_alt : Icons.keyboard,
              size: 48,
              color: vm.isSessionActive
                  ? AppColors.stressedColor
                  : AppColors.primary,
            ),
            const SizedBox(height: 16),
            Text(
              vm.isSessionActive ? 'Session Active' : 'Start Typing Session',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              vm.isSessionActive
                  ? 'Start typing to track your patterns'
                  : 'Tap the button below to start tracking your typing patterns',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            if (vm.isSessionActive) ...[
              _buildTypingInput(vm),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _endSession(vm),
                    icon: const Icon(Icons.stop),
                    label: const Text('End Session'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.stressedColor,
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _cancelSession(vm),
                    icon: const Icon(Icons.cancel),
                    label: const Text('Cancel'),
                  ),
                ],
              ),
            ] else ...[
              ElevatedButton.icon(
                onPressed: () => _startSession(vm),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Session'),
              ),
            ],
            if (vm.currentMetrics != null) ...[
              const SizedBox(height: 24),
              _buildCurrentMetrics(vm.currentMetrics!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTypingInput(TypingViewModel vm) {
    return TextField(
      controller: _textController,
      autofocus: true,
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      inputFormatters: [
        _KeystrokeFormatter((key) {
          vm.recordKeystroke(key);
        }),
      ],
      decoration: InputDecoration(
        hintText: 'Start typing here...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade50,
        hintStyle: const TextStyle(color: Colors.black54),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }

  Widget _buildCurrentMetrics(TypingMetrics metrics) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 12),
        Text('Session Results', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMetricItem('WPM', '${metrics.wpm.round()}'),
            _buildMetricItem('Errors', '${metrics.errorRate.round()}%'),
            _buildMetricItem('Stress', '${metrics.stressScore.round()}'),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildStatsGrid(TypingViewModel vm) {
    final avgStress = vm.averageStressScore;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Statistics', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'Sessions',
                value: '${vm.recentSessions.length}',
                icon: Icons.history,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                title: 'Avg Stress',
                value: '${avgStress.round()}',
                icon: Icons.analytics,
                color: AppTheme.getStressColor(avgStress),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentSessions(TypingViewModel vm) {
    final sessions = vm.recentSessions.take(10).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Sessions', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        if (sessions.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'No typing sessions yet',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          )
        else
          ...sessions.map(
            (session) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.getStressColor(
                      session.stressScore,
                    ).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.keyboard,
                    color: AppTheme.getStressColor(session.stressScore),
                  ),
                ),
                title: Text('WPM: ${session.wpm.round()}'),
                subtitle: Text(
                  'Errors: ${session.errorRate.round()}% | Stress: ${session.stressScore.round()}',
                ),
                trailing: Text(
                  '${session.timestamp.hour}:${session.timestamp.minute.toString().padLeft(2, '0')}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _startSession(TypingViewModel vm) {
    vm.startSession();
    _textController.clear();
  }

  void _endSession(TypingViewModel vm) async {
    await vm.endSession();
    _textController.clear();
  }

  void _cancelSession(TypingViewModel vm) {
    vm.cancelSession();
    _textController.clear();
  }
}

class _KeystrokeFormatter extends TextInputFormatter {
  final Function(String) onKey;

  _KeystrokeFormatter(this.onKey);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length > oldValue.text.length) {
      final newChar = newValue.text[newValue.text.length - 1];
      onKey(newChar);
    } else if (newValue.text.length < oldValue.text.length) {
      onKey('Backspace');
    }
    return newValue;
  }
}
