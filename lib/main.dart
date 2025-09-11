import 'package:cardholder/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:cardholder/pages/home_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:cardholder/pages/scan_page.dart';
import 'package:cardholder/pages/form_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // debugShowCheckedModeBanner - на экране сверху справа появляется полупрозрачная красная ленточка с надписью DEBUG.
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routerConfig: _router,
      builder: EasyLoading.init(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }

  final _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        name: HomePage.routeName,
        path: HomePage.routeName,
        builder: (ctx, state) => const HomePage(),
        routes: [
          GoRoute(
            name: ScanPage.routeName,
            path: ScanPage.routeName,
            builder: (ctx, state) => const ScanPage(),
            routes: [
              GoRoute(
                name: FormPage.routeName,
                path: FormPage.routeName,
                builder: (context, state) => FormPage(contactModel: state.extra! as ContactModel,) // state относится к GoRouter.
              )
            ]
          ),
        ],
      ),
    ],
  );
}
