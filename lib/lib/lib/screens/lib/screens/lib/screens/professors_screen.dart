import 'package:flutter/material.dart';

class ProfessorsScreen extends StatefulWidget {
  @override
  _ProfessorsScreenState createState() => _ProfessorsScreenState();
}

class _ProfessorsScreenState extends State<ProfessorsScreen> {
  List<Map<String, dynamic>> _professors = [
    {"name": "سلمان عبد القادر", "subject": "رياضيات", "isExcused": false},
    {"name": "سمية لزهر", "subject": "عربية", "isExcused": true},
  ];

  void _toggleExcuse(int index) {
    setState(() {
      _professors[index]["isExcused"] = !_professors[index]["isExcused"];
    });
  }

  void _addProfessorDialog() {
    final _nameController = TextEditingController();
    final _subjectController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('إضافة أستاذ'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'الاسم'),
            ),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(labelText: 'المادة'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _professors.add({
                  "name": _nameController.text,
                  "subject": _subjectController.text,
                  "isExcused": false,
                });
              });
              Navigator.pop(context);
            },
            child: Text('حفظ'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _professors.length,
        itemBuilder: (context, index) {
          final prof = _professors[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(prof["name"]),
              subtitle: Text(prof["subject"]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(prof["isExcused"] ? "معفى" : "غير معفى"),
                  Switch(
                    value: prof["isExcused"],
                    onChanged: (_) => _toggleExcuse(index),
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProfessorDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
