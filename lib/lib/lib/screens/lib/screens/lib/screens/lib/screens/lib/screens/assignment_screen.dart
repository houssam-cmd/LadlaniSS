import 'package:flutter/material.dart';

class AssignmentScreen extends StatefulWidget {
  @override
  _AssignmentScreenState createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  final List<Map<String, String>> _assignments = [];

  final _teacherController = TextEditingController();
  final _roomController = TextEditingController();
  final _subjectController = TextEditingController();

  void _addAssignment() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("توزيع حراسة"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _teacherController,
              decoration: InputDecoration(labelText: 'الأستاذ'),
            ),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(labelText: 'المادة'),
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
                _assignments.add({
                  "teacher": _teacherController.text,
                  "subject": _subjectController.text,
                  "room": _roomController.text,
                });
                _teacherController.clear();
                _subjectController.clear();
                _roomController.clear();
              });
              Navigator.pop(context);
            },
            child: Text("حفظ"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addAssignment,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _assignments.length,
        itemBuilder: (context, index) {
          final assignment = _assignments[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text("الأستاذ: ${assignment["teacher"]}"),
              subtitle: Text("المادة: ${assignment["subject"]} - القاعة: ${assignment["room"]}"),
            ),
          );
        },
      ),
    );
  }
}
