import 'package:flutter/material.dart';

class CommentModel {
  final int id;
  final int shopCode;
  final String content;
  final String name;
  final double rating;
  final String create;
  CommentModel({
    this.id,
    this.shopCode,
    this.content,
    this.name,
    this.rating,
    this.create,
  });
  factory CommentModel.fromJson(Map<String, dynamic> jsonData) {
    return CommentModel(
      id: jsonData['id'],
      shopCode: jsonData['shopCode'],
      content: jsonData['content'],
      name: jsonData['name'],
      rating: double.parse(jsonData['rating'].toString()),
      create: jsonData['create'],
    );
  }
}
