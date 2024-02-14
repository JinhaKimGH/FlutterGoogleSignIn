# Apache Bank: Google Sign In

A proof of concept Google Sign In application with Flutter. Uses the Google People API and google_sign_in package.

## Run Locally

Clone the project

```bash
  git clone git@github.com:JinhaKimGH/FlutterGoogleSignIn.git
```

Create a new flutter directory:

```bash
  flutter create -t app <app-directory>
```

Delete the tests under test/widget_test.dart.

Move the dart code (under lib), assets, and pubspec.yaml to the new project.

Go to the project directory

```bash
  cd FlutterGoogleSignIn
  cp -r lib/* ../<app-directory>/lib
  cp pubspec.yaml ../<app-directory>
```

After installing Flutter and the different iOS and android simulators. Start the device with VSCode in the bottom right of the IDE. After the device has started, run this command in the terminal:

```bash
  flutter run
```
