import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poc/router.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFFFFFFF),
        surfaceTintColor: const Color(0xFFFFFFFF),
        shadowColor: Colors.black,
        elevation: 5.0,
        title: const Text(
          'Home Page',
          style: TextStyle(color: Color(0xFF005DAA)),
        ),
        leading: SvgPicture.network(
            'https://www1.royalbank.com/uos/3m/images/toptools_beyondbanking.svg',
            semanticsLabel: 'Beyond Banking Logo',
            fit: BoxFit.scaleDown,
            placeholderBuilder: (BuildContext context) => Container(
                  child: const CircularProgressIndicator(),
                )),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text("Choose Sign In Method"),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      context.go(Routes.google);
                    },
                    child: const Text("Google")),
                ElevatedButton(
                    onPressed: () {
                      context.go(Routes.passkeySignIn);
                    },
                    child: const Text("Passkey")),
                ElevatedButton(
                    onPressed: () {
                      context.go(Routes.google);
                    },
                    child: const Text("RBC")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
