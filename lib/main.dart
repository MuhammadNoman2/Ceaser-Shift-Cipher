import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Shift Cipher'),
        backgroundColor: Colors.blue,  // Set the color of the AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.red],  // Set a gradient background
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,  // Enlarge the button
                height: 60,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.lock_open, size: 30),  // Enlarge the icon
                  label: Text('Encryption', style: TextStyle(fontSize: 20)),  // Enlarge the text
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CipherPage(mode: 'e')),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),  // Add some spacing between the buttons
              Container(
                width: 200,  // Enlarge the button
                height: 60,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.lock, size: 30),  // Enlarge the icon
                  label: Text('Decryption', style: TextStyle(fontSize: 20)),  // Enlarge the text
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CipherPage(mode: 'd')),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CipherPage extends StatefulWidget {
  final String mode;

  CipherPage({Key? key, required this.mode}) : super(key: key);

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
          backgroundColor: Colors.blue[20],
          // Set the color of the AppBar
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter text',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _keyController,
                  decoration: InputDecoration(
                    labelText: 'Enter key',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white70,
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text(widget.mode == 'e' ? 'Encrypt' : 'Decrypt'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    disabledForegroundColor: Colors.white.withOpacity(0.38), disabledBackgroundColor: Colors.white.withOpacity(0.12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      int key = int.parse(_keyController.text);
                      _output = shiftCipher(_controller.text, widget.mode == 'e' ? key : -key);
                    });
                  },
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(color: Colors.blueGrey, width: 3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Output: $_output',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }


