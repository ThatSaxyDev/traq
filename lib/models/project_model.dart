// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProjectModel {
  final String id;

  final String orgName;
  final String name;
  final List<dynamic> assignedTo;
  final String assignedBy;
  final List<dynamic> versions;
  final DateTime? createdAt;
  const ProjectModel({
    required this.id,
    required this.orgName,
    required this.name,
    required this.assignedTo,
    required this.assignedBy,
    required this.versions,
    this.createdAt,
  });

  ProjectModel copyWith({
    String? id,
    String? orgName,
    String? name,
    List<dynamic>? assignedTo,
    String? assignedBy,
    List<dynamic>? versions,
    DateTime? createdAt,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      orgName: orgName ?? this.orgName,
      name: name ?? this.name,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedBy: assignedBy ?? this.assignedBy,
      versions: versions ?? this.versions,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orgName': orgName,
      'name': name,
      'assignedTo': assignedTo,
      'assignedBy': assignedBy,
      'versions': versions,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: (map["id"] ?? '') as String,
      orgName: (map["orgName"] ?? '') as String,
      name: (map["name"] ?? '') as String,
      assignedTo: List<dynamic>.from(
        ((map['assignedTo'] ?? const <dynamic>[]) as List<dynamic>),
      ),
      assignedBy: (map["assignedBy"] ?? '') as String,
      versions: List<dynamic>.from(
        ((map['versions'] ?? const <dynamic>[]) as List<dynamic>),
      ),
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (map["createdAt"] ?? 0) ?? 0)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProjectModel.fromJson(String source) =>
      ProjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProjectModel(id: $id, orgName: $orgName, name: $name, assignedTo: $assignedTo, assignedBy: $assignedBy, versions: $versions, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant ProjectModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.orgName == orgName &&
        other.name == name &&
        listEquals(other.assignedTo, assignedTo) &&
        other.assignedBy == assignedBy &&
        listEquals(other.versions, versions) &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orgName.hashCode ^
        name.hashCode ^
        assignedTo.hashCode ^
        assignedBy.hashCode ^
        versions.hashCode ^
        createdAt.hashCode;
  }
}
