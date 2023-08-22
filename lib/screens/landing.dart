import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:provider/provider.dart';
import 'package:slave_client/providers/auth_provider.dart';
import 'package:slave_client/screens/Homepage.dart';
import 'package:slave_client/screens/login.dart';

class Landing extends StatefulWidget {
  final storage = const FlutterSecureStorage();

  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        log('back pressed');
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Consumer<Auth>(
        builder: (context, auth, child) {
          if (auth.token == null) {
            return FutureBuilder(
                future: auth.tryAutoLogin(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const Login();
                });
          } else {
            return const HomePage();
          }
        },
      ),
    );
  }
}
