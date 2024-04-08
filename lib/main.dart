import 'package:database/loading.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'dart:async';
import 'register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'user.dart';
import 'auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBvj0d7wNmR22_VEds8WN8j9bQvhMSyA_c",
        appId: "1:1019891820257:android:6f7aa1e42a5e32c1ae39a0",
        messagingSenderId: "1019891820257",
        projectId: "projet-login-3cef0"),
  );
  runApp(MaterialApp(
    home: home(),
    debugShowCheckedModeBanner: false,
  ));
}

class home extends StatefulWidget {
  const home({super.key});


  @override
  State<home> createState() => homescreen();
}

class homescreen extends State<home> {
  bool visible = true;
  bool code = true;

  @override
  Widget build(BuildContext context) {

    return StreamProvider<Usere?>.value(
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
                padding: const EdgeInsets.only(top: 130,bottom: 400,left: 60,right: 60),
                child: CircleAvatar(
                  backgroundImage: AssetImage('tsawer/Screenshot_2024-04-04_141952-removebg-preview.png'),
                  backgroundColor: Colors.transparent,
                  radius: 80,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 600,left: 106),
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>register()));

                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 55, vertical: 10),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColorLight),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Bord arrondi du bouton
                      ),
                    ),
                    elevation: MaterialStateProperty.all<double>(15.0), // Élévation du bouton
                  ),
                  child: Text('Sign In',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 700,left: 110),
              child: ElevatedButton(
                  onPressed: (){

                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => login())
                    );
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColorLight),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Bord arrondi du bouton
                      ),
                    ),
                    elevation: MaterialStateProperty.all<double>(15.0), // Élévation du bouton
                  ),
                  child: Text('Log In',
                    style: TextStyle(
                      fontSize: 30,
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
