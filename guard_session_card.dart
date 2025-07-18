
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExamSession {
  final String subject;
  final DateTime date;
  final String startTime;
  final String endTime;
  final String classroom;

  ExamSession({required this.subject, required this.date, required this.startTime, required this.endTime, required this.classroom});
}

class GuardSessionCard extends StatelessWidget {
  final ExamSession session;
  final bool isExempt;
  final VoidCallback onSetReminder;

  GuardSessionCard({
    required this.session,
    required this.isExempt,
    required this.onSetReminder,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      color: isExempt ? Colors.green[50] : null,
      child: ListTile(
        leading: Icon(Icons.event, color: isExempt ? Colors.green : Colors.blue),
        title: Text(session.subject),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('التاريخ: ${DateFormat.yMMMd('ar').format(session.date)}'),
            Text('الوقت: ${session.startTime} - ${session.endTime}'),
            Text('القاعة: ${session.classroom}'),
            if (isExempt)
              Text('تم إعفاؤك من هذه الحراسة', 
                   style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.notifications_active),
          onPressed: onSetReminder,
        ),
      ),
    );
  }
}
