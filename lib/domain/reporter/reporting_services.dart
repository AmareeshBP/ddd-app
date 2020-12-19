import 'package:ddd_app/domain/auth/user.dart';
import 'package:flutter/material.dart';

enum AuthMethod { email, google }

abstract class ReportingServices {
  NavigatorObserver get navigationReporter;
  Future<void> setUser(User user);
  Future<void> loggedIn(AuthMethod authMethod);
  Future<void> signedIn(AuthMethod authMethod);
}

String getAuthMethodValue(AuthMethod authMethod) {
  if (authMethod == AuthMethod.email) {
    return 'Email';
  } else {
    return 'Google';
  }
}
