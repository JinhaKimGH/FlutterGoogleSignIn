import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poc/provider.dart';
import 'package:poc/router.dart';

class PassKeysSignUp extends HookConsumerWidget {
  const PassKeysSignUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final error = useState<String?>(null);
    final passKeyAuth = ref.watch(relyingPartyServerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Passkey Authentication')),
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      'Sign up with biometrics!',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'email address',
                      ),
                    ),
                  ),
                  if (error.value != null)
                    Text(
                      error.value!,
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    )
                  else
                    Container(),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        final email = emailController.value.text;
                        try {
                          await passKeyAuth.signUpWithPasskey(email: email);
                          context.go(Routes.landingPage);
                        } catch (e) {
                          error.value = e.toString();
                        }
                      },
                      child: const Text('sign up'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => context.go(Routes.passkeySignIn),
                      child: const Text('I already have an account'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
