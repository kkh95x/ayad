import 'package:ayad/src/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fakeUsers = <User>[
  User(
      fullName: "أحمد خالد",
      phone: "+3237872332",
      username: "sksdi321",
      password: "123445",
      createdAt: DateTime.now()),
  User(
      fullName: "محمد خالد",
      phone: "+3237872332",
      username: "sksdi321",
      password: "123445",
      isAdmin: true,
      createdAt: DateTime.now()),
  User(
      fullName: "محمد الاحمد",
      phone: "+3237872332",
      username: "sksdi321",
      password: "123445",
      createdAt: DateTime.now()),
  User(
      fullName: "بسام الخالد",
      phone: "+3237872332",
      username: "sksdi321",
      password: "123445",
      createdAt: DateTime.now()),
  User(
      fullName: "سمير حمدان",
      phone: "+3237872332",
      username: "sksdi321",
      password: "123445",
      isAdmin: true,
      createdAt: DateTime.now())
];
final getAllUserProvider = FutureProvider<List<User>>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return fakeUsers;
});
