// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class OrganisationModel {
  final String id;
  final String name;
  final String orgImage;
  final List<dynamic> projects;
  final List<dynamic> teamMembers;
  final List<dynamic> teamLead;
  final DateTime? createdAt;
  const OrganisationModel({
    required this.id,
    required this.name,
    required this.orgImage,
    required this.projects,
    required this.teamMembers,
    required this.teamLead,
    this.createdAt,
  });

  OrganisationModel copyWith({
    String? id,
    String? name,
    String? orgImage,
    List<dynamic>? projects,
    List<dynamic>? teamMembers,
    List<dynamic>? teamLead,
    DateTime? createdAt,
  }) {
    return OrganisationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      orgImage: orgImage ?? this.orgImage,
      projects: projects ?? this.projects,
      teamMembers: teamMembers ?? this.teamMembers,
      teamLead: teamLead ?? this.teamLead,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'orgImage': orgImage,
      'projects': projects,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'teamMembers': teamMembers,
      'teamLead': teamLead,
    };
  }

  factory OrganisationModel.fromMap(Map<String, dynamic> map) {
    return OrganisationModel(
      id: map["id"] ?? '',
      name: map["name"] ?? '',
      orgImage: map["orgImage"] ?? '',
      projects: map['projects'] ?? [],
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch((map["createdAt"] ?? 0))
          : null,
      teamMembers: map['teamMembers'] ?? [],
      teamLead: map['teamLead'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrganisationModel.fromJson(String source) =>
      OrganisationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrganisationModel(id: $id, name: $name, orgImage: $orgImage, projects: $projects, teamMembers: $teamMembers, teamLead: $teamLead, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant OrganisationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.orgImage == orgImage &&
        listEquals(other.projects, projects) &&
        listEquals(other.teamMembers, teamMembers) &&
        listEquals(other.teamLead, teamLead) &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        orgImage.hashCode ^
        projects.hashCode ^
        teamMembers.hashCode ^
        teamLead.hashCode ^
        createdAt.hashCode;
  }
}
