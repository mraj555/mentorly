import 'package:flutter/material.dart';
import 'package:mentorly/models/online_class.dart';
import 'package:mentorly/widgets/class_card.dart';

class ClassListview extends StatelessWidget {
  final List<OnlineClass> classes;
  final String type;

  const ClassListview({super.key, required this.classes, required this.type});

  @override
  Widget build(BuildContext context) {
    return classes.isEmpty
        ? Center(
            child: Text(
              type == 'live'
                  ? 'No live classes at the moment.'
                  : type == 'upcoming'
                  ? 'No upcoming classes scheduled.'
                  : 'No completed classes yet.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          )
        : ListView.builder(
            itemCount: classes.length,
            itemBuilder: (context, index) {
              final classItem = classes[index];
              return ClassCard(classItem: classItem, type: type);
            },
          );
  }
}
