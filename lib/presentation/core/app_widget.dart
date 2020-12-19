import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/auth/auth_bloc.dart';
import '../../domain/reporter/reporting_services.dart';
import '../../injection.dart';
import '../routes/router.gr.dart' as app_router;

class AppWidget extends StatelessWidget {
  AppWidget() {
    FlutterError.onError = getIt<ReportingServices>().flutterError;
  }
  @override
  Widget build(BuildContext context) {
    return runZonedGuarded<Widget>(
      () {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) =>
                  getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Note App',
            builder: ExtendedNavigator.builder(
                router: app_router.Router(),
                observers: [
                  getIt<ReportingServices>().navigationReporter,
                ]),
            theme: ThemeData.light().copyWith(
              primaryColor: Colors.green[800],
              accentColor: Colors.blueAccent,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.blue[900],
              ),
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        );
      },
      getIt<ReportingServices>().error,
    );
  }
}
