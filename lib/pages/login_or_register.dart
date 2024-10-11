import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coding_minds_bootstrap/auth.dart';

// Login or register page

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;
  String? errorMessage = '';
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text, 
        password: _controllerPassword.text
        );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text, 
        password: _controllerPassword.text
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      cursorColor: Colors.green,
      
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green)
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green)
        ),
        labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Hmm, $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      style: const ButtonStyle(
        overlayColor: WidgetStatePropertyAll(Color.fromARGB(37, 74, 173, 77))
      ),
      onPressed: 
        isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Login' : 'Register', style: TextStyle(color: Colors.green))
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      style: const ButtonStyle(
        overlayColor: WidgetStatePropertyAll(Color.fromARGB(37, 74, 173, 77))
      ),
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register instead' : 'Login instead', style: TextStyle(color: Colors.green),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('To Do Lists'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField('Email', _controllerEmail),
            _entryField('Password', _controllerPassword),
            _errorMessage(),
            _submitButton(),
            _loginOrRegisterButton()
          ],
        )
      )
    );
  }
}