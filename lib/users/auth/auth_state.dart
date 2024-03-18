

import 'package:equatable/equatable.dart';

enum AuthStatus { authorized, unAuthorized, initial }
//TODO BUILD USING FREEZED
class AuthState implements Equatable {
  final AuthStatus authStatus;

  const AuthState(
      {required this.authStatus,
   });

  AuthState copyWith({
    AuthStatus? authStatus,

  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
     
    );
  }
  
  @override
  List<Object?> get props => [authStatus];
  
  @override
  bool? get stringify => true;
}
