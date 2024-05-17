import 'package:flutter/material.dart';

class CipherPage extends StatefulWidget {
  final String mode;

  CipherPage({ key,  required this.mode}) : super(key: key);

  @override
  _CipherPageState createState() => _CipherPageState();
}

class _CipherPageState extends State<CipherPage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  String _output = '';

  String shiftCipher(String text, int shift) {
    String result = '';
    for (int i = 0; i < text.length; i++) {
      int charCode = text[i].codeUnitAt(0);
      if (charCode >= 65 && charCode <= 90) {
        result += String.fromCharCode((charCode - 65 + shift) % 26 + 65);
      } else if (charCode >= 97 && charCode <= 122) {
        result += String.fromCharCode((charCode - 97 + shift) % 26 + 97);
      } else {
        result += text[i];
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode == 'e' ? 'Encryption' : 'Decryption'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter text',
              ),
            ),
            TextField(
              controller: _keyController,
              decoration: InputDecoration(
                labelText: 'Enter key',
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              child: Text(widget.mode == 'e' ? 'Encrypt' : 'Decrypt'),
              onPressed: () {
                setState(() {
                  int key = int.parse(_keyController.text);
                  _output = shiftCipher(
                      _controller.text, widget.mode == 'e' ? key : -key);
                });
              },
            ),
            Text('Output: $_output'),
          ],
        ),
      ),
    );
  }
}