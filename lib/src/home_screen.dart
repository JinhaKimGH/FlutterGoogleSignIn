import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF005DAA),
        surfaceTintColor: const Color(0xFF000000),
        elevation: 10.0,
        titleTextStyle: const TextStyle(color: Color(0xFFFFFFFF)),
        title: Row(
          children: [
            SvgPicture.network(
                'https://www1.royalbank.com/uos/3m/images/toptools_beyondbanking.svg',
                semanticsLabel: 'A shark?!',
                placeholderBuilder: (BuildContext context) => Container(
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator(),
                    )),
            const Padding(
              padding: EdgeInsets.all(40),
            ),
            const Text('Proof of Concept App'),
          ],
        ),
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
                      Navigator.pushNamed(context, '/sign-in/google');
                    },
                    child: const Text("Google")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign-in/google');
                    },
                    child: const Text("Apple")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign-in/google');
                    },
                    child: const Text("Passkey")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign-in/google');
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
