// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class BugModel {
  final String id;
  final String bugName;
  final String description;
  final String steps;
  final String projectName;
  final String orgName;
  final String status;
  final String imageUrl;
  final String priority;
  final String assignedBy;
  final String updatedBy;
  final String platformDevice;
  final String version;
  final List<dynamic> comments;
  final List<dynamic> assignedTo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const BugModel({
    required this.id,
    required this.bugName,
    required this.description,
    required this.steps,
    required this.projectName,
    required this.orgName,
    required this.status,
    required this.imageUrl,
    required this.priority,
    required this.assignedBy,
    required this.updatedBy,
    required this.platformDevice,
    required this.version,
    required this.comments,
    required this.assignedTo,
    this.createdAt,
    this.updatedAt,
  });

  BugModel copyWith({
    String? id,
    String? bugName,
    String? description,
    String? steps,
    String? projectName,
    String? orgName,
    String? status,
    String? imageUrl,
    String? priority,
    String? assignedBy,
    String? updatedBy,
    String? platformDevice,
    String? version,
    List<dynamic>? comments,
    List<dynamic>? assignedTo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BugModel(
      id: id ?? this.id,
      bugName: bugName ?? this.bugName,
      description: description ?? this.description,
      steps: steps ?? this.steps,
      projectName: projectName ?? this.projectName,
      orgName: orgName ?? this.orgName,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      priority: priority ?? this.priority,
      assignedBy: assignedBy ?? this.assignedBy,
      updatedBy: updatedBy ?? this.updatedBy,
      platformDevice: platformDevice ?? this.platformDevice,
      version: version ?? this.version,
      comments: comments ?? this.comments,
      assignedTo: assignedTo ?? this.assignedTo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bugName': bugName,
      'description': description,
      'steps': steps,
      'projectName': projectName,
      'orgName': orgName,
      'status': status,
      'imageUrl': imageUrl,
      'priority': priority,
      'assignedBy': assignedBy,
      'updatedBy': updatedBy,
      'platformDevice': platformDevice,
      'version': version,
      'comments': comments,
      'assignedTo': assignedTo,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory BugModel.fromMap(Map<String, dynamic> map) {
    return BugModel(
      id: (map["id"] ?? '') as String,
      bugName: (map["bugName"] ?? '') as String,
      description: (map["description"] ?? '') as String,
      steps: (map["steps"] ?? '') as String,
      projectName: (map["projectName"] ?? '') as String,
      orgName: (map["orgName"] ?? '') as String,
      status: (map["status"] ?? '') as String,
      imageUrl: (map["imageUrl"] ?? '') as String,
      priority: (map["priority"] ?? '') as String,
      assignedBy: (map["assignedBy"] ?? '') as String,
      updatedBy: (map["updatedBy"] ?? '') as String,
      platformDevice: (map["platformDevice"] ?? '') as String,
      version: (map["version"] ?? '') as String,
      comments: List<dynamic>.from(
        ((map['comments'] ?? const <dynamic>[]) as List<dynamic>),
      ),
      assignedTo: List<dynamic>.from(
        ((map['assignedTo'] ?? const <dynamic>[]) as List<dynamic>),
      ),
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map["createdAt"] ?? 0)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map["updatedAt"] ?? 0)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BugModel.fromJson(String source) =>
      BugModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BugModel(id: $id, bugName: $bugName, description: $description, steps: $steps, projectName: $projectName, orgName: $orgName, status: $status, imageUrl: $imageUrl, priority: $priority, assignedBy: $assignedBy, updatedBy: $updatedBy, platformDevice: $platformDevice, version: $version, comments: $comments, assignedTo: $assignedTo, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant BugModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.bugName == bugName &&
        other.description == description &&
        other.steps == steps &&
        other.projectName == projectName &&
        other.orgName == orgName &&
        other.status == status &&
        other.imageUrl == imageUrl &&
        other.priority == priority &&
        other.assignedBy == assignedBy &&
        other.updatedBy == updatedBy &&
        other.platformDevice == platformDevice &&
        other.version == version &&
        listEquals(other.comments, comments) &&
        listEquals(other.assignedTo, assignedTo) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        bugName.hashCode ^
        description.hashCode ^
        steps.hashCode ^
        projectName.hashCode ^
        orgName.hashCode ^
        status.hashCode ^
        imageUrl.hashCode ^
        priority.hashCode ^
        assignedBy.hashCode ^
        updatedBy.hashCode ^
        platformDevice.hashCode ^
        version.hashCode ^
        comments.hashCode ^
        assignedTo.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
