import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentorly/models/online_class.dart';
import 'package:mentorly/theme/app_theme.dart';

class ClassCard extends StatelessWidget {
  final OnlineClass classItem;
  final String type;

  const ClassCard({super.key, required this.classItem, required this.type});

  Color _getSubjectColors() {
    return Color(SubjectColors.colors[classItem.subject] ?? SubjectColors.colors['default']!);
  }

  @override
  Widget build(BuildContext context) {
    final time_format = DateFormat('h:mm a');
    final date_format = DateFormat('MMM dd, yyyy');
    return Card(
      margin: .only(bottom: 16),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => ClassDetailsScreen(classItem: classItem)),
          // );
        },
        borderRadius: .circular(16),
        child: Padding(
          padding: .all(16),
          child: Row(
            children: [
              Container(
                padding: .all(12),
                decoration: BoxDecoration(
                  color: _getSubjectColors().withValues(alpha: .1),
                  borderRadius: .circular(12),
                ),
                child: Icon(Icons.book_outlined, color: _getSubjectColors(), size: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
