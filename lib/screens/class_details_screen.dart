import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentorly/models/online_class.dart';
import 'package:mentorly/theme/app_theme.dart';

class ClassDetailsScreen extends StatelessWidget {
  final OnlineClass classItem;

  const ClassDetailsScreen({super.key, required this.classItem});

  Color _getSubjectColors() {
    return Color(SubjectColors.colors[classItem.subject] ?? SubjectColors.colors['default']!);
  }

  @override
  Widget build(BuildContext context) {
    final time_format = DateFormat('h:mm a');
    final date_format = DateFormat('MMM dd, yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text(classItem.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: .all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_getSubjectColors(), _getSubjectColors().withValues(alpha: .7)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Container(
                      padding: .symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .3),
                        borderRadius: .circular(20),
                      ),
                      child: Text(
                        classItem.subject,
                        style: TextStyle(color: Colors.white, fontWeight: .bold),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      classItem.title,
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: .bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Instructor: ${classItem.instructor}",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
