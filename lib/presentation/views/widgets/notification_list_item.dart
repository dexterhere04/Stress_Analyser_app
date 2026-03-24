import 'package:flutter/material.dart';
import '../../../data/models/notification_sentiment.dart';
import '../../../data/models/typing_metrics.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/date_utils.dart';

class NotificationListItem extends StatelessWidget {
  final NotificationSentiment notification;

  const NotificationListItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: _buildSentimentIcon(),
        title: Text(
          notification.source,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.preview,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              DateTimeUtils.formatRelative(notification.timestamp),
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ],
        ),
        trailing: _buildScoreChip(),
      ),
    );
  }

  Widget _buildSentimentIcon() {
    IconData icon;
    Color color;

    switch (notification.sentiment) {
      case SentimentType.positive:
        icon = Icons.sentiment_satisfied;
        color = AppTheme.positiveSentiment;
      case SentimentType.neutral:
        icon = Icons.sentiment_neutral;
        color = AppTheme.neutralSentiment;
      case SentimentType.negative:
        icon = Icons.sentiment_dissatisfied;
        color = AppTheme.negativeSentiment;
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

  Widget _buildScoreChip() {
    Color color;
    String label;

    switch (notification.sentiment) {
      case SentimentType.positive:
        color = AppTheme.positiveSentiment;
        label = 'Positive';
      case SentimentType.neutral:
        color = AppTheme.neutralSentiment;
        label = 'Neutral';
      case SentimentType.negative:
        color = AppTheme.negativeSentiment;
        label = 'Negative';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
