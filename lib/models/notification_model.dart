class NotificationModel {
  final String title;
  final String message;
  final String time;
  final bool read;
  final String type;
  final bool actionable;
  final String? actionText;

  NotificationModel({
    required this.title,
    required this.message,
    required this.time,
    required this.read,
    required this.type,
    required this.actionable,
    this.actionText,
  });

  NotificationModel copyWith({
    String? title,
    String? message,
    String? time,
    bool? read,
    String? type,
    bool? actionable,
    String? actionText,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      message: message ?? this.message,
      time: time ?? this.time,
      read: read ?? this.read,
      type: type ?? this.type,
      actionable: actionable ?? this.actionable,
      actionText: actionText ?? this.actionText,
    );
  }
}
