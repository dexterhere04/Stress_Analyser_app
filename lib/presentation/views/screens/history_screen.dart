import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:destresser/presentation/viewmodels/dashboard_viewmodel.dart';
import 'package:destresser/presentation/views/widgets/stat_card.dart';
import 'package:destresser/presentation/views/widgets/stress_trend_chart.dart';
import 'package:destresser/core/theme/app_theme.dart';
import 'package:destresser/core/utils/date_utils.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(dashboardViewModelProvider.notifier).loadDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(dashboardViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(dashboardViewModelProvider.notifier).loadDashboardData();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverviewStats(vm),
            const SizedBox(height: 24),
            _buildWeeklyTrend(vm),
            const SizedBox(height: 24),
            _buildReadingsList(vm),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewStats(DashboardViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Overview', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'Average Stress',
                value: '${vm.averageStress.round()}',
                icon: Icons.analytics,
                color: AppTheme.getStressColor(vm.averageStress),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                title: 'Readings',
                value: '${vm.recentReadings.length}',
                icon: Icons.history,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeeklyTrend(DashboardViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Weekly Trend', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: StressTrendChart(data: vm.weeklyTrend, height: 200),
          ),
        ),
      ],
    );
  }

  Widget _buildReadingsList(DashboardViewModel vm) {
    final readings = vm.recentReadings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Readings', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        if (readings.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.history, size: 48, color: Colors.grey.shade400),
                    const SizedBox(height: 12),
                    Text(
                      'No readings recorded yet',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Start using the app to track your stress',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: readings.length,
            itemBuilder: (context, index) {
              final reading = readings[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppTheme.getStressColor(
                        reading.overallScore,
                      ).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${reading.overallScore.round()}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.getStressColor(reading.overallScore),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    reading.stressLabel,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    DateTimeUtils.formatDateTime(reading.timestamp),
                  ),
                  trailing: Icon(
                    _getStressIcon(reading.overallScore),
                    color: AppTheme.getStressColor(reading.overallScore),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  IconData _getStressIcon(double score) {
    if (score < 33) return Icons.sentiment_satisfied;
    if (score < 66) return Icons.sentiment_neutral;
    return Icons.sentiment_dissatisfied;
  }
}
