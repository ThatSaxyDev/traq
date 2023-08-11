// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String? uid;
  final String? name;
  final String? nickName;
  final String? email;
  final String? profilePic;
  final bool? isUserTypePicked;
  final bool? isTeamLead;
  final bool? createdAtLeastOneOrg;
  final List<dynamic>? organisationsCreated;
  final List<dynamic>? organisationsJoined;

  const UserModel({
    this.uid,
    this.name,
    this.nickName,
    this.email,
    this.profilePic,
    this.isUserTypePicked,
    this.isTeamLead,
    this.createdAtLeastOneOrg,
    this.organisationsCreated,
    this.organisationsJoined,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? nickName,
    String? email,
    String? profilePic,
    bool? isUserTypePicked,
    bool? isTeamLead,
    bool? createdAtLeastOneOrg,
    List<dynamic>? organisationsCreated,
    List<dynamic>? organisationsJoined,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      nickName: nickName ?? this.nickName,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      isUserTypePicked: isUserTypePicked ?? this.isUserTypePicked,
      isTeamLead: isTeamLead ?? this.isTeamLead,
      createdAtLeastOneOrg: createdAtLeastOneOrg ?? this.createdAtLeastOneOrg,
      organisationsCreated: organisationsCreated ?? this.organisationsCreated,
      organisationsJoined: organisationsJoined ?? this.organisationsJoined,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'nickName': nickName,
      'email': email,
      'profilePic': profilePic,
      'isTeamLead': isTeamLead,
      'createdAtLeastOneOrg': createdAtLeastOneOrg,
      'isUserTypePicked': isUserTypePicked,
      'organisationsCreated': organisationsCreated,
      'organisationsJoined': organisationsJoined,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map["uid"] ?? '',
      name: map["name"] ?? '',
      nickName: map["nickName"] ?? '',
      email: map["email"] ?? '',
      profilePic: map['profilePic'] ?? '',
      isTeamLead: map['isTeamLead'] ?? false,
      createdAtLeastOneOrg: map['createdAtLeastOneOrg'] ?? false,
      isUserTypePicked: map['isUserTypePicked'] ?? false,
      organisationsCreated: map['organisationsCreated'] ?? [],
      organisationsJoined: map['organisationsJoined'] ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, nickName: $nickName, email: $email, profilePic: $profilePic, isUserTypePicked: $isUserTypePicked, isTeamLead: $isTeamLead, createdAtLeastOneOrg: $createdAtLeastOneOrg, organisationsCreated: $organisationsCreated, organisationsJoined: $organisationsJoined)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.nickName == nickName &&
        other.email == email &&
        other.profilePic == profilePic &&
        other.isUserTypePicked == isUserTypePicked &&
        other.isTeamLead == isTeamLead &&
        other.createdAtLeastOneOrg == createdAtLeastOneOrg &&
        listEquals(other.organisationsCreated, organisationsCreated) &&
        listEquals(other.organisationsJoined, organisationsJoined);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        nickName.hashCode ^
        email.hashCode ^
        profilePic.hashCode ^
        isUserTypePicked.hashCode ^
        isTeamLead.hashCode ^
        createdAtLeastOneOrg.hashCode ^
        organisationsCreated.hashCode ^
        organisationsJoined.hashCode;
  }
}
