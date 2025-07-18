import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ladlani_ss/screens/dashboard_home.dart';
import 'package:ladlani_ss/screens/professors_screen.dart';
import 'package:ladlani_ss/screens/exam_schedule_screen.dart';
import 'package:ladlani_ss/screens/assignment_screen.dart';
import 'package:ladlani_ss/screens/reports_screen.dart';
import 'package:ladlani_ss/screens/settings_screen.dart';
import 'package:ladlani_ss/screens/notifications_screen.dart';
import 'package:ladlani_ss/dialogs/add_schedule_dialog.dart';
import 'package:ladlani_ss/repositories/auth_repository.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    DashboardHome(),
    ProfessorsScreen(),
    ExamScheduleScreen(),
    AssignmentScreen(),
    ReportsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Image.asset('assets/logo.png', width: 30, height: 30),
          SizedBox(width: 10),
          Text('Ladlani - لوحة التحكم'),
        ]),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => NotificationsScreen()),
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => context.read<AuthRepository>().signOut(),
          )
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'الأساتذة'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'الجدول'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'التوزيع'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'التقارير'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
      floatingActionButton: _currentIndex == 2
          ? FloatingActionButton(
              onPressed: () => _showAddScheduleDialog(context),
              child: Icon(Icons.add),
            )
          : null,
    );
  }

  void _showAddScheduleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddScheduleDialog(),
    );
  }
}
