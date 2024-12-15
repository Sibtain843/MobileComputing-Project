import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class NotificationTriggerScreen extends StatelessWidget {
  final NotificationService _notificationService = NotificationService();

  Future<void> _sendReminderNotification() async {
    await _notificationService.showNotification(
      'Reminder',
      'Don’t forget to complete your tasks for today!',
    );
  }

  Future<void> _sendMilestoneNotification() async {
    await _notificationService.showNotification(
      'Congratulations!',
      'You’ve reached 50% progress in your skill development journey!',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Notifications', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue[900],
          foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _sendReminderNotification,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue[900],
              ),
              child: Text('Send Reminder Notification'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendMilestoneNotification,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.green,
              ),
              child: Text('Send Milestone Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
