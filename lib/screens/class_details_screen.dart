import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentorly/models/online_class.dart';
import 'package:mentorly/screens/video_call_screen.dart';
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
            crossAxisAlignment: .start,
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
              if (classItem.isLive) ...[
                Padding(
                  padding: .only(top: 16, left: 10),
                  child: Container(
                    padding: .symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(color: Colors.redAccent, borderRadius: .circular(20)),
                    child: Row(
                      mainAxisSize: .min,
                      children: [
                        Icon(Icons.circle, color: Colors.white, size: 12),
                        SizedBox(width: 8),
                        Text(
                          'CLASS IS LIVE NOW',
                          style: TextStyle(color: Colors.white, fontWeight: .bold),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: .all(24),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text('Scheduled Time', style: TextStyle(fontSize: 16, fontWeight: .bold)),

                      SizedBox(height: 8),
                      Text(
                        '${date_format.format(classItem.scheduledTime)} at ${time_format.format(classItem.scheduledTime)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Text('Duration', style: TextStyle(fontSize: 16, fontWeight: .bold)),
                      SizedBox(height: 8),
                      Text('${classItem.duration} minutes', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 16),
                      Text('Description', style: TextStyle(fontSize: 16, fontWeight: .bold)),
                      SizedBox(height: 8),
                      Text('${classItem.description} minutes', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: .all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2))],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VideoCallScreen(classID: classItem.id, className: classItem.title),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _getSubjectColors(),
              padding: .symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: .circular(12)),
            ),
            child: Text(
              classItem.isLive ? 'Join Class Now' : 'Class Not Live',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
