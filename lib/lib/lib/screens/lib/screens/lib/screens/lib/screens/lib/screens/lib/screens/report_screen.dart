import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  final List<Map<String, dynamic>> reports = [
    {
      'teacher': 'أ. سامي',
      'date': '2025-06-12',
      'status': 'تمت الحراسة',
    },
    {
      'teacher': 'أ. ليلى',
      'date': '2025-06-13',
      'status': 'لم تحضر',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تقارير الحراسة')),
      body: ListView.separated(
        itemCount: reports.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final report = reports[index];
          return ListTile(
            leading: Icon(
              report['status'] == 'تمت الحراسة'
                  ? Icons.check_circle
                  : Icons.error,
              color: report['status'] == 'تمت الحراسة'
                  ? Colors.green
                  : Colors.red,
            ),
            title: Text(report['teacher']),
            subtitle: Text("تاريخ: ${report['date']}"),
            trailing: Text(report['status']),
          );
        },
      ),
    );
  }
}
