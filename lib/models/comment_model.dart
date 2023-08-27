// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Comment {
  final String id;
  final String content;
  final DateTime createdAt;
  final String bugId;
  final String userId;
  final String userImage;
  final String userName;
  final List<dynamic> mentionUserIds;
  const Comment({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.bugId,
    required this.userId,
    required this.userImage,
    required this.userName,
    required this.mentionUserIds,
  });

  Comment copyWith({
    String? id,
    String? content,
    DateTime? createdAt,
    String? bugId,
    String? userId,
    String? userImage,
    String? userName,
    List<dynamic>? mentionUserIds,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      bugId: bugId ?? this.bugId,
      userId: userId ?? this.userId,
      userImage: userImage ?? this.userImage,
      userName: userName ?? this.userName,
      mentionUserIds: mentionUserIds ?? this.mentionUserIds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'bugId': bugId,
      'userId': userId,
      'userImage': userImage,
      'userName': userName,
      'mentionUserIds': mentionUserIds,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: (map["id"] ?? '') as String,
      content: (map["content"] ?? '') as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch((map["createdAt"]??0) as int),
      bugId: (map["bugId"] ?? '') as String,
      userId: (map["userId"] ?? '') as String,
      userImage: (map["userImage"] ?? '') as String,
      userName: (map["userName"] ?? '') as String,
      mentionUserIds: List<dynamic>.from(((map['mentionUserIds'] ?? const <dynamic>[]) as List<dynamic>),),
    );
  }

  @override
  String toString() {
    return 'Comment(id: $id, content: $content, createdAt: $createdAt, bugId: $bugId, userId: $userId, userImage: $userImage, userName: $userName, mentionUserIds: $mentionUserIds)';
  }

  @override
  bool operator ==(covariant Comment other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.content == content &&
      other.createdAt == createdAt &&
      other.bugId == bugId &&
      other.userId == userId &&
      other.userImage == userImage &&
      other.userName == userName &&
      listEquals(other.mentionUserIds, mentionUserIds);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      content.hashCode ^
      createdAt.hashCode ^
      bugId.hashCode ^
      userId.hashCode ^
      userImage.hashCode ^
      userName.hashCode ^
      mentionUserIds.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source) as Map<String, dynamic>);
}
