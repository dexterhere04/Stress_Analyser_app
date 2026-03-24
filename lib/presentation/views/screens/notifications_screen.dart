import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:destresser/presentation/viewmodels/notification_viewmodel.dart';
import 'package:destresser/presentation/views/widgets/notification_list_item.dart';
import 'package:destresser/presentation/views/widgets/stat_card.dart';
import 'package:destresser/core/theme/app_theme.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _previewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(notificationViewModelProvider.notifier)
          .loadRecentNotifications();
    });
  }

  @override
  void dispose() {
    _sourceController.dispose();
    _previewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(notificationViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref
                  .read(notificationViewModelProvider.notifier)
                  .loadRecentNotifications();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddNotificationDialog(),
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsSection(vm),
            const SizedBox(height: 24),
            _buildNotificationsList(vm),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(NotificationViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sentiment Overview',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'Total',
                value: '${vm.totalCount}',
                icon: Icons.notifications,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                title: 'Stress Score',
                value: '${vm.stressScore.round()}',
                icon: Icons.analytics,
                color: AppTheme.getStressColor(vm.stressScore),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sentiment Distribution',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                _buildSentimentBar(vm),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSentimentLegend(
                      'Positive',
                      vm.positiveCount,
                      AppTheme.positiveSentiment,
                    ),
                    _buildSentimentLegend(
                      'Neutral',
                      vm.neutralCount,
                      AppTheme.neutralSentiment,
                    ),
                    _buildSentimentLegend(
                      'Negative',
                      vm.negativeCount,
                      AppTheme.negativeSentiment,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSentimentBar(NotificationViewModel vm) {
    final total = vm.totalCount;
    if (total == 0) {
      return Container(
        height: 20,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
      );
    }

    final positiveWidth = vm.positiveCount / total;
    final neutralWidth = vm.neutralCount / total;
    final negativeWidth = vm.negativeCount / total;

    return Container(
      height: 20,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            flex: (positiveWidth * 100).round(),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.positiveSentiment,
                borderRadius: BorderRadius.horizontal(
                  left: const Radius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            flex: (neutralWidth * 100).round(),
            child: Container(color: AppTheme.neutralSentiment),
          ),
          Expanded(
            flex: (negativeWidth * 100).round(),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.negativeSentiment,
                borderRadius: BorderRadius.horizontal(
                  right: const Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSentimentLegend(String label, int count, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text('$label ($count)', style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildNotificationsList(NotificationViewModel vm) {
    final notifications = vm.recentNotifications;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Notifications',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        if (notifications.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.inbox, size: 48, color: Colors.grey.shade400),
                    const SizedBox(height: 12),
                    Text(
                      'No notifications analyzed yet',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap the + button to add a notification',
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
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return NotificationListItem(notification: notifications[index]);
            },
          ),
      ],
    );
  }

  void _showAddNotificationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Notification'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _sourceController,
              decoration: const InputDecoration(
                labelText: 'Source (e.g., Email, Slack)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _previewController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Notification Preview',
                border: OutlineInputBorder(),
                hintText: 'Enter the notification text...',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_sourceController.text.isNotEmpty &&
                  _previewController.text.isNotEmpty) {
                ref
                    .read(notificationViewModelProvider.notifier)
                    .addNotification(
                      source: _sourceController.text,
                      preview: _previewController.text,
                    );
                _sourceController.clear();
                _previewController.clear();
                Navigator.pop(context);
              }
            },
            child: const Text('Analyze'),
          ),
        ],
      ),
    );
  }
}
