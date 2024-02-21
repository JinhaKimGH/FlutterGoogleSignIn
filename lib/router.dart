import 'package:go_router/go_router.dart';
import 'package:poc/src/apple_signin.dart';
import 'package:poc/src/google_signin.dart';
import 'package:poc/src/home_screen.dart';
import 'package:poc/src/passkeys_pages/passkey_sign_in.dart';
import 'package:poc/src/passkeys_pages/passkey_sign_up.dart';

class Routes {
  static const signIn = '/';
  static const google = '/google/sign-in';
  static const apple = '/apple/sign-in';
  static const passkeySignIn = '/passkey/sign-in';
  static const passkeySignUp = '/passkey/sign-up';
  static const landingPage = '/landing-page';
}

final GoRouter router = GoRouter(initialLocation: Routes.signIn, routes: [
  GoRoute(
    path: Routes.signIn,
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: Routes.google,
    builder: (context, state) => GoogleSignInComponent(),
  ),
  GoRoute(
    path: Routes.apple,
    builder: (context, state) => const AppleSignInComponent(),
  ),
  GoRoute(
    path: Routes.passkeySignIn,
    builder: (context, state) => const PassKeysSignIn(),
  ),
  GoRoute(
    path: Routes.passkeySignUp,
    builder: (context, state) => const PassKeysSignUp(),
  ),
]);
