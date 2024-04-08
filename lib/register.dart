import 'package:database/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'user.dart';
import 'auth.dart';

void main() => runApp(MaterialApp(
  home: register(),
  debugShowCheckedModeBanner: false,
));

class register extends StatefulWidget {

  @override
  State<register> createState() => registerscreen();
}

class registerscreen extends State<register> {

  final formKey = GlobalKey<FormState>();


  String email = '';
  String password = '';
  String UserName = '';
  String error = '';

  final AuthService _auth = AuthService();

  bool visible = true;
  bool code = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xffffffff),Color(0xff0000ff)],
                  stops: [0.1, 3]),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 100,left: 22),
              child: Text(
                'Hello\nSign Up !',
                style: TextStyle(
                  fontSize: 50,
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
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 300),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18,right: 18),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || !RegExp(r'^[a-z A-z]+$').hasMatch(value!)) {
                              return 'Veuillez saisir votre nom';
                            }
                            return null;
                          },
                          onChanged: (val){
                            setState(() {
                              UserName = val;
                            });
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.person,
                              color: Colors.black,),
                            label: Text('User Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value!)) {
                              return 'Veuillez saisir votre email';
                            }
                            return null;
                          },
                          onChanged: (val){
                            setState(() {
                              email = val;
                            });
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.mail,
                              color: Colors.black,),
                            label: Text('Gmail',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        TextFormField(
                          validator: (value) {
                            if (value!.length <6) {
                              return 'Veuillez saisir password';
                            }
                            return null;
                          },
                          onChanged: (val){
                            setState(() {
                              password = val;
                            });
                          },
                          obscureText: visible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: visible ? Icon(Icons.visibility_off,color: Colors.black) :
                                Icon(Icons.visibility,color: Colors.black),

                                onPressed: (){
                                  setState(() {
                                    visible = ! visible;
                                  });
                                }),
                            label: Text('Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 50,),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async{
                              if (formKey.currentState!.validate()) {
                                dynamic result = await _auth.registerWhith(email, password);
                                if(result == null){
                                  setState(() {
                                    error = 'votre enregistrement est echouer';
                                  });
                                }else{
                                  final TextStyle snackBarTextStyle = TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  );
                                  final snackBar = SnackBar(
                                      content: Text('Register Amet',style: snackBarTextStyle,
                                        textAlign: TextAlign.center,));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                                }
                              }
                              },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(horizontal: 65, vertical: 12),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColorLight),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0), // Bord arrondi du bouton
                                ),
                              ),
                              elevation: MaterialStateProperty.all<double>(15.0), // Élévation du bouton
                            ),
                            child : Text('Register',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.black
                              ),),
                          ),
                        ),
                        SizedBox(height: 40,),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            children: [
                              Text("Do you have account?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.black,
                                ),),
                              InkWell(
                                onTap: (){

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context)=>login())
                                  );
                                },
                                child : Text('Log In !',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
