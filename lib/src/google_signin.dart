import 'dart:async';
import 'dart:convert' show json;
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:poc/router.dart';
import 'sign_in_button.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: scopes,
);

class GoogleSignInComponent extends StatefulWidget {
  GoogleSignInComponent({super.key});

  @override
  State createState() => _GoogleSignInComponentState();
}

class _GoogleSignInComponentState extends State<GoogleSignInComponent> {
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false;
  String _contactText = '';

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      bool isAuthorized = account != null;

      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }

      setState(() {
        _currentUser = account;
        _isAuthorized = isAuthorized;
      });

      if (isAuthorized) {
        unawaited(_handleGetContact(account!));
      }
    });

    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });

    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );

    if (response.statusCode != 200) {
      setState(() {
        _contactText =
            'People API gave a ${response.statusCode} reponse. Check logs for details.';
      });

      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }

    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;

    setState(() {
      if (data.isNotEmpty) {
        _contactText = '${data.length} contacts';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleAuthorizeScopes() async {
    final bool isAuthorized = await _googleSignIn.requestScopes(scopes);

    setState(() {
      _isAuthorized = isAuthorized;
    });

    if (isAuthorized) {
      unawaited(_handleGetContact(_currentUser!));
    }
  }

  Future<void> _signOut() {
    return _googleSignIn.disconnect();
  }

  Widget _buildBody(BuildContext context) {
    final GoogleSignInAccount? user = _currentUser;

    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          if (_isAuthorized) ...<Widget>[
            Text(_contactText),
            ElevatedButton(
              child: const Text('REFRESH'),
              onPressed: () => _handleGetContact(user),
            ),
          ],
          if (!_isAuthorized) ...<Widget>[
            const Text('Additional permissions needed to read your contacts.'),
            ElevatedButton(
              onPressed: _handleAuthorizeScopes,
              child: const Text('REQUEST PERMISSIONS'),
            ),
          ],
          ElevatedButton(
            onPressed: _signOut,
            child: const Text("SIGN OUT"),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          buildSignInButton(onPressed: _handleSignIn),
          ElevatedButton(
              onPressed: () => {context.go(Routes.signIn)},
              child: const Text('Back')),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(context),
        ));
  }
}
