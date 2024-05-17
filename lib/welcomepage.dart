import 'package:flutter/material.dart';

import 'cipher.dart';

class WelcomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Shift Cipher'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
              icon: Icon(Icons.lock_open),
              label: Text('Encryption'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CipherPage( mode: 'e')),
                );
              },
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.lock),
              label: Text('Decryption'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CipherPage(mode: 'd')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
