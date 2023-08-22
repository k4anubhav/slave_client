import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:slave_client/util/snackbar.dart';

import '../providers/auth_provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  final storage = const FlutterSecureStorage();

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _token = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Slave Token',
                  helperText: 'Enter your slave token',
                ),
                onChanged: (value) {
                  _token = value;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _login,
        tooltip: 'Login',
        child: const Icon(Icons.login),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _login() async {
    if (_token == "") {
      showFailSnackBar(context, 'Please enter a token');
      return;
    }
    var authProvider = Provider.of<Auth>(context, listen: false);
    if (!await authProvider.login(_token)) {
      showFailSnackBar(context, 'Login failed, Invalid Token');
    }
  }
}
