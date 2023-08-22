// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class VersionModel {
  final String id;
  final String orgName;
  final String projectName;
  final String name;
  final String assignedBy;
  final List<dynamic> unsolvedBugs;
  final List<dynamic> inProgressBugs;
  final List<dynamic> inReviewBugs;
  final List<dynamic> resolvedBugs;
  final DateTime? createdAt;
  const VersionModel({
    required this.id,
    required this.orgName,
    required this.projectName,
    required this.name,
    required this.assignedBy,
    required this.unsolvedBugs,
    required this.inProgressBugs,
    required this.inReviewBugs,
    required this.resolvedBugs,
    this.createdAt,
  });

  VersionModel copyWith({
    String? id,
    String? orgName,
    String? projectName,
    String? name,
    String? assignedBy,
    List<dynamic>? unsolvedBugs,
    List<dynamic>? inProgressBugs,
    List<dynamic>? inReviewBugs,
    List<dynamic>? resolvedBugs,
    DateTime? createdAt,
  }) {
    return VersionModel(
      id: id ?? this.id,
      orgName: orgName ?? this.orgName,
      projectName: projectName ?? this.projectName,
      name: name ?? this.name,
      assignedBy: assignedBy ?? this.assignedBy,
      unsolvedBugs: unsolvedBugs ?? this.unsolvedBugs,
      inProgressBugs: inProgressBugs ?? this.inProgressBugs,
      inReviewBugs: inReviewBugs ?? this.inReviewBugs,
      resolvedBugs: resolvedBugs ?? this.resolvedBugs,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orgName': orgName,
      'projectName': projectName,
      'name': name,
      'assignedBy': assignedBy,
      'unsolvedBugs': unsolvedBugs,
      'inProgressBugs': inProgressBugs,
      'inReviewBugs': inReviewBugs,
      'resolvedBugs': resolvedBugs,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory VersionModel.fromMap(Map<String, dynamic> map) {
    return VersionModel(
      id: (map["id"] ?? '') as String,
      orgName: (map["orgName"] ?? '') as String,
      projectName: (map["projectName"] ?? '') as String,
      name: (map["name"] ?? '') as String,
      assignedBy: (map["assignedBy"] ?? '') as String,
      unsolvedBugs: List<dynamic>.from(
        ((map['unsolvedBugs'] ?? const <dynamic>[]) as List<dynamic>),
      ),
      inProgressBugs: List<dynamic>.from(
        ((map['inProgressBugs'] ?? const <dynamic>[]) as List<dynamic>),
      ),
      inReviewBugs: List<dynamic>.from(
        ((map['inReviewBugs'] ?? const <dynamic>[]) as List<dynamic>),
      ),
      resolvedBugs: List<dynamic>.from(
        ((map['resolvedBugs'] ?? const <dynamic>[]) as List<dynamic>),
      ),
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map["createdAt"] ?? 0)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VersionModel.fromJson(String source) =>
      VersionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VersionModel(id: $id, orgName: $orgName, projectName: $projectName, name: $name, assignedBy: $assignedBy, unsolvedBugs: $unsolvedBugs, inProgressBugs: $inProgressBugs, inReviewBugs: $inReviewBugs, resolvedBugs: $resolvedBugs, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant VersionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.orgName == orgName &&
        other.projectName == projectName &&
        other.name == name &&
        other.assignedBy == assignedBy &&
        listEquals(other.unsolvedBugs, unsolvedBugs) &&
        listEquals(other.inProgressBugs, inProgressBugs) &&
        listEquals(other.inReviewBugs, inReviewBugs) &&
        listEquals(other.resolvedBugs, resolvedBugs) &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orgName.hashCode ^
        projectName.hashCode ^
        name.hashCode ^
        assignedBy.hashCode ^
        unsolvedBugs.hashCode ^
        inProgressBugs.hashCode ^
        inReviewBugs.hashCode ^
        resolvedBugs.hashCode ^
        createdAt.hashCode;
  }
}
