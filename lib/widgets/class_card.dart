import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentorly/models/online_class.dart';
import 'package:mentorly/screens/class_details_screen.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: .only(bottom: 16),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ClassDetailsScreen(classItem: classItem)),
            );
          },
          borderRadius: .circular(16),
          child: Padding(
            padding: .all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: .all(12),
                      decoration: BoxDecoration(
                        color: _getSubjectColors().withValues(alpha: .1),
                        borderRadius: .circular(12),
                      ),
                      child: Icon(Icons.book_outlined, color: _getSubjectColors(), size: 24),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            classItem.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: .bold,
                              color: Color(AppTheme.textPrimary),
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.person_outline, size: 14, color: Colors.grey[600]),
                              SizedBox(width: 4),
                              Text(
                                classItem.instructor,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(AppTheme.textSecondary),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (type == 'live') ...[
                      SizedBox(height: 8),
                      Container(
                        padding: .symmetric(vertical: 6, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: .circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.circle, color: Colors.white, size: 10),
                            SizedBox(width: 6),
                            Text(
                              "LIVE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: .bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  padding: .symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(color: Colors.grey[200], borderRadius: .circular(12)),
                  child: Row(
                    children: [
                      Icon(Icons.schedule, size: 16, color: Colors.grey[700]),
                      SizedBox(width: 6),
                      Text(
                        type == 'completed'
                            ? '${date_format.format(classItem.scheduledTime)} at ${time_format.format(classItem.scheduledTime.add(Duration(minutes: classItem.duration)))}'
                            : '${time_format.format(classItem.scheduledTime)} - ${time_format.format(classItem.scheduledTime.add(Duration(minutes: classItem.duration)))}',
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: .symmetric(vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: _getSubjectColors().withValues(alpha: .1),
                        borderRadius: .circular(20),
                      ),
                      child: Text(
                        classItem.subject,
                        style: TextStyle(
                          color: _getSubjectColors(),
                          fontSize: 12,
                          fontWeight: .bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.people_outline, size: 16, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      '${classItem.participants.length} participants',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
