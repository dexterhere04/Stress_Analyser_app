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
      body: RefreshIndicator(
        onRefresh: () => vm.loadRecentSessions(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildKeyboardCard(vm),
              const SizedBox(height: 24),
              _buildTypingSessionCard(vm),
              const SizedBox(height: 24),
              _buildStatsGrid(vm),
              const SizedBox(height: 24),
              _buildRecentSessions(vm),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKeyboardCard(TypingViewModel vm) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : const Color(0xFFF3F0FF),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : AppColors.primary).withValues(
              alpha: 0.08,
            ),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.keyboard,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'System-Wide Keyboard',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Enable DeStresser keyboard for continuous monitoring',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: vm.isKeyboardFullyEnabled,
                  onChanged: (value) {
                    if (value) {
                      vm.openKeyboardSettings();
                    } else {
                      vm.disableKeyboard();
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        (vm.isKeyboardEnabled
                                ? AppColors.calmColor
                                : AppColors.textSecondaryLight)
                            .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: vm.isKeyboardEnabled
                              ? AppColors.calmColor
                              : AppColors.textSecondaryLight,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        vm.isKeyboardEnabled ? 'Installed' : 'Not Installed',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: vm.isKeyboardEnabled
                              ? AppColors.calmColor
                              : AppColors.textSecondaryLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        (vm.isKeyboardSelected
                                ? AppColors.calmColor
                                : AppColors.warningColor)
                            .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: vm.isKeyboardSelected
                              ? AppColors.calmColor
                              : AppColors.warningColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        vm.isKeyboardSelected ? 'Active' : 'Set as Default',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: vm.isKeyboardSelected
                              ? AppColors.calmColor
                              : AppColors.warningColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (!vm.isKeyboardSelected) ...[
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => vm.openKeyboardSettings(),
                  icon: const Icon(Icons.settings, size: 18),
                  label: const Text('Open Keyboard Settings'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Go to Settings > keyboards > DeStresser Keyboard',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
                textAlign: TextAlign.center,
              ),
            ],
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
