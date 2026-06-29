import 'package:flutter/material.dart';
import 'package:mentorly/models/online_class.dart';

class ClassProvider extends ChangeNotifier {
  final List<OnlineClass> _classes = [];

  bool _isLoading = false;

  List<OnlineClass> get classes => _classes;

  bool get isLoading => _isLoading;

  List<OnlineClass> get liveClasses => classes.where((e) => e.isLive).toList();

  List<OnlineClass> get upComingClasses =>
      classes.where((e) => e.isUpcoming).toList()
        ..sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));

  List<OnlineClass> get completedClasses =>
      classes.where((e) => e.isCompleted).toList()
        ..sort((a, b) => b.scheduledTime.compareTo(a.scheduledTime));

  ClassProvider() {
    _initClasses();
  }

  Future<void> _initClasses() async {
    _classes.addAll([
      OnlineClass(
        id: '1',
        title: 'Flutter for Beginners',
        instructor: 'John Doe',
        subject: 'Mobile Development',
        scheduledTime: DateTime.now().subtract(const Duration(minutes: 30)),
        duration: 60,
        description: 'Learn the basics of Flutter development.',
      ),
      OnlineClass(
        id: '2',
        title: 'Advanced Flutter Widgets',
        instructor: 'Sarah Wilson',
        subject: 'Mobile Development',
        scheduledTime: DateTime.now().add(const Duration(hours: 1)),
        duration: 90,
        description: 'Master custom widgets, animations, and state management.',
      ),
      OnlineClass(
        id: '3',
        title: 'Python for Data Science',
        instructor: 'Emily Brown',
        subject: 'Data Science',
        scheduledTime: DateTime.now().add(const Duration(hours: 3)),
        duration: 120,
        description: 'Explore NumPy, Pandas, and data visualization.',
      ),
      OnlineClass(
        id: '4',
        title: 'Machine Learning Fundamentals',
        instructor: 'David Miller',
        subject: 'Machine Learning',
        scheduledTime: DateTime.now().add(const Duration(days: 1)),
        duration: 90,
        description: 'Introduction to supervised and unsupervised learning.',
      ),
      OnlineClass(
        id: '5',
        title: 'Modern JavaScript',
        instructor: 'Michael Scott',
        subject: 'Web Development',
        scheduledTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
        duration: 75,
        description: 'Learn ES6+, async programming, and modules.',
      ),
      OnlineClass(
        id: '6',
        title: 'Node.js REST APIs',
        instructor: 'Chris Evans',
        subject: 'Backend Development',
        scheduledTime: DateTime.now().add(const Duration(days: 2)),
        duration: 90,
        description: 'Build scalable REST APIs using Express and MongoDB.',
      ),
      OnlineClass(
        id: '7',
        title: 'AWS Cloud Essentials',
        instructor: 'Lisa Anderson',
        subject: 'Cloud Computing',
        scheduledTime: DateTime.now().add(const Duration(days: 2, hours: 4)),
        duration: 120,
        description: 'Understand EC2, S3, IAM, and cloud architecture.',
      ),
      OnlineClass(
        id: '8',
        title: 'Cybersecurity Basics',
        instructor: 'Robert Lee',
        subject: 'Cybersecurity',
        scheduledTime: DateTime.now().add(const Duration(days: 3)),
        duration: 60,
        description: 'Learn about common threats and security best practices.',
      ),
      OnlineClass(
        id: '9',
        title: 'UI/UX Design Principles',
        instructor: 'Sophia Martinez',
        subject: 'UI/UX Design',
        scheduledTime: DateTime.now().add(const Duration(days: 3, hours: 3)),
        duration: 90,
        description: 'Design user-friendly and visually appealing interfaces.',
      ),
      OnlineClass(
        id: '10',
        title: 'Introduction to AI',
        instructor: 'James Wilson',
        subject: 'Artificial Intelligence',
        scheduledTime: DateTime.now().add(const Duration(days: 4)),
        duration: 120,
        description: 'Understand AI concepts, applications, and future trends.',
      ),
    ]);

    notifyListeners();
  }

  Future<void> onRefreshClasses() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();
  }

  void onJoinClass(String classID, String userID) {
    final classIndex = _classes.indexWhere((element) => element.id == classID);
    if (classIndex != -1) {
      final onlineClass = _classes[classIndex];
      if (!onlineClass.participants.contains(userID)) {
        final newParticipant = [...onlineClass.participants, userID];
        _classes[classIndex] = onlineClass.copyWith(participants: newParticipant);
        notifyListeners();
      }
    }
  }

  OnlineClass? getClassByID(String id) {
    try {
      return _classes.firstWhere((element) => element.id == id);
    } catch (e) {
      return null;
    }
  }
}
