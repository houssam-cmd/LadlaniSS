import 'package:flutter/material.dart';

class ExamScheduleScreen extends StatefulWidget {
  @override
  _ExamScheduleScreenState createState() => _ExamScheduleScreenState();
}

class _ExamScheduleScreenState extends State<ExamScheduleScreen> {
  List<Map<String, String>> _schedule = [
    {"date": "2025-06-01", "subject": "رياضيات", "room": "قاعة 1"},
    {"date": "2025-06-02", "subject": "عربية", "room": "قاعة 2"},
  ];

  void _showAddDialog() {
    final _subjectController = TextEditingController();
    final _dateController = TextEditingController();
    final _roomController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('إضافة حصة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(labelText: 'المادة'),
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'التاريخ (YYYY-MM-DD)'),
            ),
            TextField(
              controller: _roomController,
              decoration: InputDecoration(labelText: 'القاعة'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _schedule.add({
                  "subject": _subjectController.text,
                  "date": _dateController.text,
                  "room": _roomController.text,
                });
              });
              Navigator.pop(context);
            },
            child: Text('إضافة'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _schedule.length,
      itemBuilder: (context, index) {
        final item = _schedule[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('${item["subject"]}'),
            subtitle: Text('التاريخ: ${item["date"]} - القاعة: ${item["room"]}'),
          ),
        );
      },
    );
  }
}
