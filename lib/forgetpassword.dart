import 'package:database/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import 'register.dart';
import 'dart:async';
import 'register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'user.dart';
import 'auth.dart';
import 'main.dart';

void main() => runApp(MaterialApp(
  home: forget(),
  debugShowCheckedModeBanner: false,
));

class forget extends StatefulWidget {
  const forget({super.key});


  @override
  State<forget> createState() => forgetscreen();
}

class forgetscreen extends State<forget> {
  
  TextEditingController emailController = TextEditingController();
  String email = '';
  bool visible = true;
  bool code = true;
  bool loadin = false;

  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset(String emailController) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController);
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Text(
            'Password reset email sent successfully!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
      );
    }on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              'ecrit email sous ca forme',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return loadin? loading() : StreamProvider<Usere?>.value(
      initialData: null,
      value: AuthService().user,

      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff0000ff), Color(0xffffffff)],
                    stops: [0.2, 0.7]
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 190,left: 60),
                child: Text(
                  '     Recuperer\nvotre password',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50,left: 340),
              child: IconButton(
                onPressed: (){
                  setState(() { loadin = true; });
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => home()));
                },
                icon: Icon(
                  Icons.home,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 420,left: 50,right: 50),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black,width: 3),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  label: Text(
                    'Entrer votre email',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                style: TextStyle(fontSize: 20,color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 590,left: 70),
              child: ElevatedButton(
                  onPressed: (){
                    passwordReset(emailController.text.trim());
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColorLight),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Bord arrondi du bouton
                      ),
                    ),
                    elevation: MaterialStateProperty.all<double>(15.0), // Élévation du bouton
                  ),
                  child: Text('Reset password',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
