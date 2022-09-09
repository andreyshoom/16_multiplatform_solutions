import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String email;
  final String imageUrl;

  User({
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

Future<String> fetchFileFromAssets(String assetsPath) async {
  return rootBundle.loadString(assetsPath).then((file) => file);
}

Future<List<User>> parseJson(BuildContext context) async {
  final jsonString = await fetchFileFromAssets('assets/user.json');
  final body = json.decode(jsonString);
  return body.map<User>((user) => User.fromJson(user)).toList();
}
