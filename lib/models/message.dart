class Message {
  final int id;
  final String content;
  final bool seen;
  final int senderId;
  final int receiverId;
  final DateTime timestamp;


  Message({
    required this.id,
    required this.content,
    required this.seen,
    required this.senderId,
    required this.receiverId,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as int,
      content: json['content'] as String,
      seen: json['seen'] as bool,
      senderId: json['senderid'] as int,
      receiverId: json['receiverid'] as int,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['seen'] = seen;
    data['senderid'] = senderId;
    data['receiverid'] = receiverId;
    data['timestamp'] = timestamp.toIso8601String();
    return data;
  }
}
