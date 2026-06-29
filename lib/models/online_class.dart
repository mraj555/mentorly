class OnlineClass {
  final String id;
  final String title;
  final String instructor;
  final String subject;
  final DateTime scheduledTime;
  final int duration;
  final String description;
  final String? imageUrl;
  final List<String> participants;
  final ClassStatus status;

  OnlineClass({
    required this.id,
    required this.title,
    required this.instructor,
    required this.subject,
    required this.scheduledTime,
    required this.duration,
    required this.description,
    this.imageUrl,
    this.participants = const [],
    this.status = ClassStatus.scheduled,
  });

  bool get isLive {
    final now = DateTime.now();
    final endTime = scheduledTime.add(Duration(minutes: duration));
    return now.isAfter(scheduledTime) && now.isBefore(endTime);
  }

  bool get isUpcoming {
    return DateTime.now().isBefore(scheduledTime);
  }

  bool get isCompleted {
    final endTime = scheduledTime.add(Duration(minutes: duration));
    return DateTime.now().isAfter(endTime);
  }

  OnlineClass copyWith({
    String? id,
    String? title,
    String? instructor,
    String? subject,
    DateTime? scheduledTime,
    int? duration,
    String? description,
    String? imageUrl,
    List<String>? participants,
    ClassStatus? status,
  }) {
    return OnlineClass(
      id: id ?? this.id,
      title: title ?? this.title,
      instructor: instructor ?? this.instructor,
      subject: subject ?? this.subject,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      participants: participants ?? this.participants,
      status: status ?? this.status,
    );
  }
}

enum ClassStatus { scheduled, live, completed, cancelled }
