// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class BugModel {
  final String id;
  final String bugName;
  final String projectName;
  final String orgName;
  final String status;
  final String priority;
  final String assignedBy;
  final List<dynamic> assignedTo;
  final DateTime? createdAt;
  const BugModel({
    required this.id,
    required this.bugName,
    required this.projectName,
    required this.orgName,
    required this.status,
    required this.priority,
    required this.assignedBy,
    required this.assignedTo,
    this.createdAt,
  });

  BugModel copyWith({
    String? id,
    String? bugName,
    String? projectName,
    String? orgName,
    String? status,
    String? priority,
    String? assignedBy,
    List<dynamic>? assignedTo,
    DateTime? createdAt,
  }) {
    return BugModel(
      id: id ?? this.id,
      bugName: bugName ?? this.bugName,
      projectName: projectName ?? this.projectName,
      orgName: orgName ?? this.orgName,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      assignedBy: assignedBy ?? this.assignedBy,
      assignedTo: assignedTo ?? this.assignedTo,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bugName': bugName,
      'projectName': projectName,
      'orgName': orgName,
      'status': status,
      'priority': priority,
      'assignedBy': assignedBy,
      'assignedTo': assignedTo,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory BugModel.fromMap(Map<String, dynamic> map) {
    return BugModel(
      id: (map["id"] ?? '') as String,
      bugName: (map["bugName"] ?? '') as String,
      projectName: (map["projectName"] ?? '') as String,
      orgName: (map["orgName"] ?? '') as String,
      status: (map["status"] ?? '') as String,
      priority: (map["priority"] ?? '') as String,
      assignedBy: (map["assignedBy"] ?? '') as String,
      assignedTo: List<dynamic>.from(((map['assignedTo'] ?? const <dynamic>[]) as List<dynamic>),),
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch((map["createdAt"]??0) ?? 0 as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BugModel.fromJson(String source) =>
      BugModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BugModel(id: $id, bugName: $bugName, projectName: $projectName, orgName: $orgName, status: $status, priority: $priority, assignedBy: $assignedBy, assignedTo: $assignedTo, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant BugModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.bugName == bugName &&
      other.projectName == projectName &&
      other.orgName == orgName &&
      other.status == status &&
      other.priority == priority &&
      other.assignedBy == assignedBy &&
      listEquals(other.assignedTo, assignedTo) &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      bugName.hashCode ^
      projectName.hashCode ^
      orgName.hashCode ^
      status.hashCode ^
      priority.hashCode ^
      assignedBy.hashCode ^
      assignedTo.hashCode ^
      createdAt.hashCode;
  }
}
