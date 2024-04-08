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
  home: accueil(),
  debugShowCheckedModeBanner: false,
));

class accueil extends StatefulWidget {
  const accueil({super.key});


  @override
  State<accueil> createState() => accueilscreen();
}

class accueilscreen extends State<accueil> {
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
                padding: const EdgeInsets.only(top: 190,left: 70),
                child: Text(
                  'Hello\nIn Accueil Page!',
                  style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50,left: 340),
              child: IconButton(
                onPressed: (){

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
              padding: const EdgeInsets.only(top: 620,left: 90),
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>login()));

                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 70, vertical: 14),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColorLight),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Bord arrondi du bouton
                      ),
                    ),
                    elevation: MaterialStateProperty.all<double>(15.0), // Élévation du bouton
                  ),
                  child: Text('Return',
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
