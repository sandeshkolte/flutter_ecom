import 'dart:convert';

import 'package:collection/collection.dart';

import 'response.dart';

class UserModel {
  String? status;
  Response? response;

  UserModel({this.status, this.response});

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        status: data['status'] as String?,
        response: data['response'] == null
            ? null
            : Response.fromMap(data['response'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'response': response?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserModel].
  factory UserModel.fromJson(String data) {
    return UserModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserModel] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UserModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => status.hashCode ^ response.hashCode;
}
