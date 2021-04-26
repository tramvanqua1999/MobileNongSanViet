import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Customer {
  final int id;
  final String userID;
  final String name;
  final String email;
  final String address;
  final DateTime create;

  Customer({
    @required this.id,
    @required this.userID,
    @required this.name,
    @required this.email,
    @required this.address,
    @required this.create,
  });
  factory Customer.fromJson(Map<String, dynamic> jsonData) {
    return Customer(
      id: jsonData['id'],
      userID: jsonData['userID'],
      name: jsonData['name'],
      email: jsonData['email'],
      address: jsonData['address'],
      create: DateTime.parse(jsonData['create']),
    );
  }
}
