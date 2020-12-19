import 'package:ddd_app/domain/auth/user.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../domain/reporter/reporting_services.dart';

@LazySingleton(as: ReportingServices)
class ReportingServicesImpl implements ReportingServices {
  final FirebaseAnalytics _firebaseAnalytics;
  final FirebaseCrashlytics _firebaseCrashlytics;

  const ReportingServicesImpl(
      this._firebaseAnalytics, this._firebaseCrashlytics);

  @override
  NavigatorObserver get navigationReporter =>
      FirebaseAnalyticsObserver(analytics: _firebaseAnalytics);

  @override
  Future<void> setUser(User user) =>
      _firebaseAnalytics.setUserId(user.id.getOrCrash());

  @override
  Future<void> loggedIn(AuthMethod authMethod) =>
      _firebaseAnalytics.logLogin(loginMethod: getAuthMethodValue(authMethod));

  @override
  Future<void> signedIn(AuthMethod authMethod) => _firebaseAnalytics.logSignUp(
      signUpMethod: getAuthMethodValue(authMethod));

  @override
  Future<void> error(dynamic exception, StackTrace stack,
          {dynamic reason,
          Iterable<DiagnosticsNode> information,
          bool printDetails}) =>
      _firebaseCrashlytics.recordError(
        exception,
        stack,
        reason: reason,
        information: information,
        printDetails: printDetails,
      );

  @override
  Future<void> flutterError(FlutterErrorDetails details) =>
      _firebaseCrashlytics.recordFlutterError(details);
}
