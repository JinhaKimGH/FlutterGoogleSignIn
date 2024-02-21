import 'package:corbado_auth/corbado_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:poc/provider.dart';
import 'package:poc/router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class PassKeysSignIn extends StatefulHookConsumerWidget {
  const PassKeysSignIn({super.key});

  @override
  ConsumerState<PassKeysSignIn> createState() => _PassKeysSignInState();
}

class _PassKeysSignInState extends ConsumerState<PassKeysSignIn> {
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final passKeyAuth = ref.watch(relyingPartyServerProvider);

      passKeyAuth
          .autocompletedLoginWithPasskey()
          .then((value) => context.go(Routes.landingPage))
          .onError(((error, stackTrace) {
        if (error is PasskeyAuthCancelledException) {
          debugPrint('user cancelled authentication.');
          return;
        }

        debugPrint('error: $error');
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    final error = useState<String?>(null);
    final passkeyAuth = ref.watch(relyingPartyServerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Passkey authentication')),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      'Tired of passwords?',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      'Sign in using your fingerprint or face.',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: TextField(
                      controller: _emailController,
                      autofillHints: [_getAutofillHint()],
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email address',
                      ),
                    ),
                  ),
                  if (error.value != null)
                    Text(
                      error.value!,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    )
                  else
                    Container(),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final email = _emailController.value.text;
                          await passkeyAuth.loginWithPasskey(email: email);
                          context.go(Routes.landingPage);
                        } catch (e) {
                          if (e is PasskeyAuthCancelledException) {
                            debugPrint(
                                'user cancelled authentication. This is not a problem. It can just be started again.');
                            return;
                          }

                          error.value = e.toString();
                          debugPrint('error: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Theme.of(context).primaryColor,
                              content: Text('$error'),
                              duration: const Duration(seconds: 10),
                            ),
                          );
                        }
                      },
                      child: const Text('Sign in'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        side: BorderSide(
                            width: 2, color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () => context.go(Routes.passkeySignUp),
                      child: const Text('Create a new account'),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => {context.go(Routes.signIn)},
                      child: const Text('Back')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getAutofillHint() {
    if (kIsWeb) {
      return 'webauthn';
    } else {
      return AutofillHints.username;
    }
  }
}
