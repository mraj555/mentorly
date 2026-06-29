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
        imageUrl: null,
        participants: ['user1', 'user2'],
        description: 'Learn the basics of Flutter development.',
      ),

      OnlineClass(
        id: '2',
        title: 'Advanced React.js',
        instructor: 'Sarah Wilson',
        subject: 'Frontend Development',
        scheduledTime: DateTime.now().add(const Duration(hours: 2)),
        duration: 90,
        imageUrl: null,
        participants: ['user3', 'user4', 'user5'],
        description: 'Master hooks, context API, and performance optimization.',
      ),

      OnlineClass(
        id: '3',
        title: 'Node.js REST API',
        instructor: 'Michael Brown',
        subject: 'Backend Development',
        scheduledTime: DateTime.now().subtract(const Duration(days: 1)),
        duration: 75,
        imageUrl: null,
        participants: ['user1'],
        description: 'Build scalable REST APIs using Express.js.',
      ),

      OnlineClass(
        id: '4',
        title: 'Full Stack with MERN',
        instructor: 'Emily Davis',
        subject: 'Full Stack Development',
        scheduledTime: DateTime.now().add(const Duration(days: 1)),
        duration: 120,
        imageUrl: null,
        participants: ['user2', 'user6'],
        description: 'Create complete applications using MongoDB, Express, React, and Node.',
      ),

      OnlineClass(
        id: '5',
        title: 'Python for Data Science',
        instructor: 'David Smith',
        subject: 'Data Science',
        scheduledTime: DateTime.now().subtract(const Duration(hours: 3)),
        duration: 90,
        imageUrl: null,
        participants: ['user7', 'user8'],
        description: 'Data analysis using Pandas and NumPy.',
      ),

      OnlineClass(
        id: '6',
        title: 'Machine Learning Essentials',
        instructor: 'Sophia Taylor',
        subject: 'Machine Learning',
        scheduledTime: DateTime.now().add(const Duration(days: 2)),
        duration: 120,
        imageUrl: null,
        participants: ['user2'],
        description: 'Introduction to supervised and unsupervised learning.',
      ),

      OnlineClass(
        id: '7',
        title: 'AI with TensorFlow',
        instructor: 'James Anderson',
        subject: 'Artificial Intelligence',
        scheduledTime: DateTime.now().subtract(const Duration(days: 2)),
        duration: 90,
        imageUrl: null,
        participants: ['user9'],
        description: 'Build neural networks using TensorFlow.',
      ),

      OnlineClass(
        id: '8',
        title: 'AWS Cloud Fundamentals',
        instructor: 'Olivia Martinez',
        subject: 'Cloud Computing',
        scheduledTime: DateTime.now().add(const Duration(hours: 5)),
        duration: 75,
        imageUrl: null,
        participants: ['user10', 'user11'],
        description: 'Introduction to AWS cloud services.',
      ),

      OnlineClass(
        id: '9',
        title: 'Docker & Kubernetes',
        instructor: 'Daniel Thomas',
        subject: 'DevOps',
        scheduledTime: DateTime.now().subtract(const Duration(minutes: 15)),
        duration: 90,
        imageUrl: null,
        participants: ['user3', 'user5'],
        description: 'Containerization and orchestration with Kubernetes.',
      ),

      OnlineClass(
        id: '10',
        title: 'Ethical Hacking Basics',
        instructor: 'Emma White',
        subject: 'Cybersecurity',
        scheduledTime: DateTime.now().add(const Duration(days: 3)),
        duration: 120,
        imageUrl: null,
        participants: ['user12'],
        description: 'Learn penetration testing fundamentals.',
      ),

      OnlineClass(
        id: '11',
        title: 'Blockchain Fundamentals',
        instructor: 'Liam Harris',
        subject: 'Blockchain',
        scheduledTime: DateTime.now().subtract(const Duration(days: 4)),
        duration: 80,
        imageUrl: null,
        participants: ['user4'],
        description: 'Understand blockchain technology and smart contracts.',
      ),

      OnlineClass(
        id: '12',
        title: 'Unity Game Development',
        instructor: 'Noah Walker',
        subject: 'Game Development',
        scheduledTime: DateTime.now().add(const Duration(days: 5)),
        duration: 100,
        imageUrl: null,
        participants: ['user13'],
        description: 'Create your first 2D game in Unity.',
      ),

      OnlineClass(
        id: '13',
        title: 'Modern UI/UX Design',
        instructor: 'Ava Hall',
        subject: 'UI/UX Design',
        scheduledTime: DateTime.now().subtract(const Duration(hours: 6)),
        duration: 60,
        imageUrl: null,
        participants: ['user7'],
        description: 'Design engaging user interfaces with Figma.',
      ),

      OnlineClass(
        id: '14',
        title: 'SQL Database Mastery',
        instructor: 'Benjamin Young',
        subject: 'Database',
        scheduledTime: DateTime.now().add(const Duration(hours: 8)),
        duration: 90,
        imageUrl: null,
        participants: ['user2', 'user8'],
        description: 'Master SQL queries and database design.',
      ),

      OnlineClass(
        id: '15',
        title: 'Software Engineering Principles',
        instructor: 'Charlotte King',
        subject: 'Software Engineering',
        scheduledTime: DateTime.now().subtract(const Duration(days: 3)),
        duration: 75,
        imageUrl: null,
        participants: ['user15'],
        description: 'Learn SOLID principles and design patterns.',
      ),

      OnlineClass(
        id: '16',
        title: 'Computer Networking',
        instructor: 'William Scott',
        subject: 'Networking',
        scheduledTime: DateTime.now().add(const Duration(days: 6)),
        duration: 90,
        imageUrl: null,
        participants: ['user9', 'user10'],
        description: 'Networking concepts and TCP/IP.',
      ),

      OnlineClass(
        id: '17',
        title: 'Embedded Systems with Arduino',
        instructor: 'Mia Green',
        subject: 'Embedded Systems',
        scheduledTime: DateTime.now().subtract(const Duration(days: 5)),
        duration: 120,
        imageUrl: null,
        participants: ['user6'],
        description: 'Build embedded projects using Arduino.',
      ),

      OnlineClass(
        id: '18',
        title: 'IoT Projects',
        instructor: 'Lucas Adams',
        subject: 'IoT',
        scheduledTime: DateTime.now().add(const Duration(days: 4)),
        duration: 100,
        imageUrl: null,
        participants: ['user16'],
        description: 'Develop IoT applications with ESP32.',
      ),

      OnlineClass(
        id: '19',
        title: 'Programming Fundamentals',
        instructor: 'Ethan Baker',
        subject: 'Programming Fundamentals',
        scheduledTime: DateTime.now().subtract(const Duration(hours: 1)),
        duration: 60,
        imageUrl: null,
        participants: ['user1', 'user3'],
        description: 'Variables, loops, functions, and problem solving.',
      ),

      OnlineClass(
        id: '20',
        title: 'HTML, CSS & JavaScript',
        instructor: 'Grace Carter',
        subject: 'Web Development',
        scheduledTime: DateTime.now().add(const Duration(days: 2)),
        duration: 90,
        imageUrl: null,
        participants: ['user5', 'user6'],
        description: 'Learn the fundamentals of modern web development.',
      ),
    ]);
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
