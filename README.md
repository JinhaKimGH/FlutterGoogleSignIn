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

Paste this code to the end of the dict in ios/Runner/Info.plist:

```bash
    <key>GIDClientID</key>
	<string>5734846377-hrrdcs8a9urqs015ca81gheduh6d2lnv.apps.googleusercontent.com</string>
	<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>com.googleusercontent.apps.5734846377-hrrdcs8a9urqs015ca81gheduh6d2lnv</string>
			</array>
		</dict>
	</array>
```

Paste this code to the end of the dict in macos/Runner/Info.plist:

```bash
    <key>keychain-access-groups</key>
	<array>
		<string>$(AppIdentifierPrefix)com.google.GIDSignIn</string>
	</array>
```

After installing Flutter and the different iOS and android simulators. Start the device with VSCode in the bottom right of the IDE. After the device has started, run this command in the terminal:

```bash
  flutter run
```
