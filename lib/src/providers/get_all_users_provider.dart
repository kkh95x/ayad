import 'package:ayad/users/domain/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fakeUsers = <AppUser>[
  AppUser(
      fullName: "أحمد خالد",
      phone: "+3237872332",
      username: "sksdi321",
      type: UserType.customer,
      password: "123445",
      createdAt: DateTime.now()),
  AppUser(
      fullName: "محمد خالد",
      phone: "+3237872332",
      username: "sksdi321",
      type: UserType.customer,
      password: "123445",
      //isAdmin: true,
      createdAt: DateTime.now()),
  AppUser(
      fullName: "محمد الاحمد",
      phone: "+3237872332",
      username: "sksdi321",
      type: UserType.customer,
      password: "123445",
      createdAt: DateTime.now()),
  AppUser(
      fullName: "بسام الخالد",
      phone: "+3237872332",
      username: "sksdi321",
      type: UserType.customer,
      password: "123445",
      createdAt: DateTime.now()),
  AppUser(
      fullName: "سمير حمدان",
      phone: "+3237872332",
      username: "sksdi321",
      type: UserType.customer,
      password: "123445",
      //isAdmin: true,
      createdAt: DateTime.now())
];
final getAllUserProvider = FutureProvider<List<AppUser>>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return fakeUsers;
});
