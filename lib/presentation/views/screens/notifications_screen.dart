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

class _NotificationsScreenState extends ConsumerState<NotificationsScreen>
    with WidgetsBindingObserver {
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _previewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.microtask(() {
      ref
          .read(notificationViewModelProvider.notifier)
          .loadRecentNotifications();
      ref.read(notificationViewModelProvider.notifier).checkPermission();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sourceController.dispose();
    _previewController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(notificationViewModelProvider.notifier).onAppResumed();
    }
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
            _buildAutoListeningCard(vm),
            const SizedBox(height: 24),
            _buildStatsSection(vm),
            const SizedBox(height: 24),
            _buildNotificationsList(vm),
          ],
        ),
      ),
    );
  }

  Widget _buildAutoListeningCard(NotificationViewModel vm) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFF3F0FF),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.03),
              AppColors.surfaceLight,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
                      gradient: LinearGradient(
                        colors: [
                          (vm.isAutoListening
                                  ? AppColors.primary
                                  : AppColors.textSecondaryLight)
                              .withValues(alpha: 0.15),
                          AppColors.surfaceLight,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.notifications_active,
                      color: vm.isAutoListening
                          ? AppColors.primary
                          : AppColors.textSecondaryLight,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Auto Notification Analysis',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          vm.isAutoListening
                              ? 'Listening for new notifications'
                              : 'Enable to analyze notifications automatically',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: vm.isAutoListening,
                    onChanged: (value) {
                      if (value) {
                        ref
                            .read(notificationViewModelProvider.notifier)
                            .startAutoListening();
                      } else {
                        ref
                            .read(notificationViewModelProvider.notifier)
                            .stopAutoListening();
                      }
                    },
                  ),
                ],
              ),
              if (!vm.hasPermission) ...[
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.stressedColor.withValues(alpha: 0.12),
                        AppColors.stressedColor.withValues(alpha: 0.04),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.stressedColor.withValues(alpha: 0.2),
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: AppColors.stressedColor,
                        size: 18,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Permission required to read notifications',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.stressedColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          ref
                              .read(notificationViewModelProvider.notifier)
                              .requestPermission();
                        },
                        child: Text(
                          'Enable',
                          style: TextStyle(
                            color: AppColors.stressedColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (vm.isAutoListening) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.calmColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Listening for notifications from all apps',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondaryLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
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
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'Total',
                value: '${vm.totalCount}',
                icon: Icons.notifications,
                color: AppColors.primary,
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
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFF3F0FF),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  AppColors.accent.withValues(alpha: 0.02),
                  AppColors.surfaceLight,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sentiment Distribution',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSentimentBar(vm),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSentimentLegend(
                        'Positive',
                        vm.positiveCount,
                        AppColors.positiveSentiment,
                      ),
                      _buildSentimentLegend(
                        'Neutral',
                        vm.neutralCount,
                        AppColors.neutralSentiment,
                      ),
                      _buildSentimentLegend(
                        'Negative',
                        vm.negativeCount,
                        AppColors.negativeSentiment,
                      ),
                    ],
                  ),
                ],
              ),
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
        height: 24,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F0FF),
          borderRadius: BorderRadius.circular(12),
        ),
      );
    }

    final positiveWidth = vm.positiveCount / total;
    final neutralWidth = vm.neutralCount / total;
    final negativeWidth = vm.negativeCount / total;

    return Container(
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimaryLight.withValues(alpha: 0.06),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: (positiveWidth * 100).round().clamp(1, 100),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.positiveSentiment,
                    AppColors.positiveSentiment.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.horizontal(
                  left: const Radius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            flex: (neutralWidth * 100).round().clamp(1, 100),
            child: Container(
              color: AppColors.neutralSentiment.withValues(alpha: 0.8),
            ),
          ),
          Expanded(
            flex: (negativeWidth * 100).round().clamp(1, 100),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.negativeSentiment.withValues(alpha: 0.8),
                    AppColors.negativeSentiment,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.horizontal(
                  right: const Radius.circular(12),
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
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '$label ($count)',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationsList(NotificationViewModel vm) {
    final notifications = vm.recentNotifications;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Notifications',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            if (vm.isAutoListening)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.calmColor.withValues(alpha: 0.15),
                      AppColors.calmColor.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.calmColor.withValues(alpha: 0.2),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.calmColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Live',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.calmColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 14),
        if (notifications.isEmpty)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFF3F0FF),
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withValues(alpha: 0.1),
                            AppColors.surfaceLight,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Icon(
                        Icons.inbox,
                        size: 48,
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'No notifications analyzed yet',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enable auto-listening or tap + to add',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondaryLight,
                      ),
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
