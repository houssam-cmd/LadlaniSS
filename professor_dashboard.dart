
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/guard_session_card.dart';
import 'notifications_screen.dart';
import '../repositories/auth_repository.dart';
import 'package:provider/provider.dart';

class ProfessorDashboard extends StatefulWidget {
  @override
  _ProfessorDashboardState createState() => _ProfessorDashboardState();
}

class _ProfessorDashboardState extends State<ProfessorDashboard> {
  late Professor _currentProfessor;
  List<ExamSession> _upcomingSessions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfessorData();
  }

  Future<void> _loadProfessorData() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId != null) {
      final professor = await _fetchProfessor(userId);
      final sessions = await _fetchUpcomingSessions(userId);

      setState(() {
        _currentProfessor = professor;
        _upcomingSessions = sessions;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ladlani - جدول حراستك'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationsScreen())),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => context.read<AuthRepository>().signOut(),
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _upcomingSessions.isEmpty
              ? Center(child: Text('لا توجد حراسات قادمة'))
              : ListView.builder(
                  itemCount: _upcomingSessions.length,
                  itemBuilder: (context, index) {
                    final session = _upcomingSessions[index];
                    final isExempt = session.subject == _currentProfessor.specialty &&
                                     _currentProfessor.exemptFromOwnSubject;

                    return GuardSessionCard(
                      session: session,
                      isExempt: isExempt,
                      onSetReminder: () => _setReminder(session),
                    );
                  },
                ),
    );
  }

  void _setReminder(ExamSession session) {
    // إعداد تذكير للإشعار
  }
}
