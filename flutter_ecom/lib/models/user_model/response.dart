import 'dart:convert';

import 'package:collection/collection.dart';

import 'created_user.dart';

class Response {
  CreatedUser? createdUser;
  String? token;

  Response({this.createdUser, this.token});

  factory Response.fromMap(Map<String, dynamic> data) => Response(
        createdUser: data['createdUser'] == null
            ? null
            : CreatedUser.fromMap(data['createdUser'] as Map<String, dynamic>),
        token: data['token'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'createdUser': createdUser?.toMap(),
        'token': token,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Response].
  factory Response.fromJson(String data) {
    return Response.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Response] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Response) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => createdUser.hashCode ^ token.hashCode;
}
