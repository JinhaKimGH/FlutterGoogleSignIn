import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poc/src/sign_in_button.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInComponent extends StatefulWidget {
  const AppleSignInComponent({super.key});

  @override
  _AppleSignInState createState() => _AppleSignInState();
}

class _AppleSignInState extends State<AppleSignInComponent> {
  Future<void> _handleSignIn() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
      ],
    );
    print(credential);
  }

  Widget _buildBody() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not signed in.'),
          buildSignInButton(onPressed: _handleSignIn)
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Apple Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}
