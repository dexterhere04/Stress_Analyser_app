import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:destresser/presentation/viewmodels/dashboard_viewmodel.dart';
import 'package:destresser/presentation/viewmodels/notification_viewmodel.dart';
import 'package:destresser/presentation/views/widgets/stress_gauge_widget.dart';
import 'package:destresser/presentation/views/widgets/stat_card.dart';
import 'package:destresser/presentation/views/widgets/stress_trend_chart.dart';
import 'package:destresser/core/theme/app_theme.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(dashboardViewModelProvider.notifier).loadDashboardData();
      ref
          .read(notificationViewModelProvider.notifier)
          .loadRecentNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardVM = ref.watch(dashboardViewModelProvider);
    final notificationVM = ref.watch(notificationViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DeStresser'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(dashboardViewModelProvider.notifier).loadDashboardData();
              ref
                  .read(notificationViewModelProvider.notifier)
                  .loadRecentNotifications();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(dashboardViewModelProvider.notifier)
              .loadDashboardData();
          await ref
              .read(notificationViewModelProvider.notifier)
              .loadRecentNotifications();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStressSection(dashboardVM),
              const SizedBox(height: 24),
              _buildQuickStats(dashboardVM, notificationVM),
              const SizedBox(height: 24),
              _buildTrendSection(dashboardVM),
              const SizedBox(height: 24),
              _buildRecentActivity(notificationVM),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStressSection(DashboardViewModel vm) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Current Stress Level',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            StressGaugeWidget(score: vm.currentStressScore, size: 200),
            const SizedBox(height: 16),
            Text(
              'Based on your typing patterns and notifications',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats(
    DashboardViewModel dashboardVM,
    NotificationViewModel notificationVM,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Stats', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'Avg Stress',
                value: '${dashboardVM.averageStress.round()}',
                icon: Icons.analytics,
                color: AppTheme.getStressColor(dashboardVM.averageStress),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                title: 'Notifications',
                value: '${notificationVM.totalCount}',
                icon: Icons.notifications,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'Positive',
                value: '${notificationVM.positiveCount}',
                icon: Icons.sentiment_satisfied,
                color: AppTheme.positiveSentiment,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                title: 'Negative',
                value: '${notificationVM.negativeCount}',
                icon: Icons.sentiment_dissatisfied,
                color: AppTheme.negativeSentiment,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrendSection(DashboardViewModel vm) {
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

  Widget _buildRecentActivity(NotificationViewModel vm) {
    final recentNotifications = vm.recentNotifications.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Activity', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        if (recentNotifications.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'No recent notifications analyzed',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          )
        else
          ...recentNotifications.map(
            (notification) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: _getSentimentIcon(notification.sentiment.name),
                title: Text(notification.source),
                subtitle: Text(
                  notification.preview,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _getSentimentIcon(String sentiment) {
    IconData icon;
    Color color;

    switch (sentiment) {
      case 'positive':
        icon = Icons.sentiment_satisfied;
        color = AppTheme.positiveSentiment;
      case 'negative':
        icon = Icons.sentiment_dissatisfied;
        color = AppTheme.negativeSentiment;
      default:
        icon = Icons.sentiment_neutral;
        color = AppTheme.neutralSentiment;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color),
    );
  }
}
