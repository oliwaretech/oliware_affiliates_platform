import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../auth_service/google_sign_in.dart';
import '../../loading/loading.dart';
import '../../styles/styles.dart';

import 'dart:async';
import 'dart:convert' show json;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;


const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);
// #enddocregion Initialize

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
// #docregion CanAccessScopes
      // In mobile, being authenticated means being authorized...
      bool isAuthorized = account != null;
      // However, on web...
      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }
// #enddocregion CanAccessScopes

      setState(() {
        _currentUser = account;
        _isAuthorized = isAuthorized;
      });

      // Now that we know that the user can access the required scopes, the app
      // can call the REST API.
      if (isAuthorized) {
        //unawaited(_handleGetContact(account!));
      }
    });

    // In the web, _googleSignIn.signInSilently() triggers the One Tap UX.
    //
    // It is recommended by Google Identity Services to render both the One Tap UX
    // and the Google Sign In button together to "reduce friction and improve
    // sign-in rates" ([docs](https://developers.google.com/identity/gsi/web/guides/display-button#html)).
    _googleSignIn.signInSilently();
  }


  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;


    return isLoading == true ? const Loading() : MaterialApp(
      title: "Oliware Afiliados",
      home: Scaffold(
        appBar: AppBar(
          shape: appBarShape,
          backgroundColor: Color(0xFF4271B1),
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/oliware_transparent_icon.png", fit: BoxFit.contain, height: 40,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Oliware Afiliados", style: textWhiteOliwareTitle,),
                )
              ],
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: backgroundGrayStyle,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(currentWidth > 1000 ? 22.0 : 12 ),
              child: Row(
                children: [
                  Visibility(
                    visible: currentWidth > 1000 ? true : false,
                    child: Expanded(
                        flex:  1 ,
                        child: Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: Image.asset(
                            "assets/marketing.png", fit: BoxFit.contain, height: 360,),
                        )
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all( currentWidth > 1000 ? 22.0 : 12),
                      child: Card(
                        shape: cardShape,
                        child: Container(
                          decoration: cardBackgroundStyle,
                          child: Padding(
                            padding: EdgeInsets.all( currentWidth > 1000 ? 22.0 : 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(22.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Center(child: Text("INGRESAR", style: textWhiteTitle,textAlign: TextAlign.center)),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Correo electrónico:", style: textWhiteSubTitle, textAlign: TextAlign.start,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextField(
                                                style: textInput,
                                                controller: emailController,
                                                decoration: textFieldDecoration.copyWith(hintText: "Correo electrónico..."),
                                                keyboardType: TextInputType.emailAddress,
                                                textAlign: TextAlign.start,
                                                onChanged: (text){

                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Contraseña:", style: textWhiteSubTitle, textAlign: TextAlign.start,),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextField(
                                                style: textInput,
                                                obscureText: true,
                                                enableSuggestions: false,
                                                autocorrect: false,
                                                controller: passwordController,
                                                decoration: textFieldDecoration.copyWith(hintText: "Contraseña...",),
                                                keyboardType: TextInputType.text,
                                                textAlign: TextAlign.start,
                                                onChanged: (text){

                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(22.0),
                                              child: ElevatedButton(
                                                  style: mainButtonStyle,
                                                  onPressed: (){
                                                    if(emailController.text.isEmpty){
                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                        shape: appBarShape,
                                                        backgroundColor: Colors.black,
                                                        content: Text("!Debes ingresar tu correo electrónico!", style: textWhiteSubTitle,),behavior: SnackBarBehavior.floating,
                                                      ));
                                                    }
                                                    else if(passwordController.text.isEmpty){
                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                        shape: appBarShape,
                                                        backgroundColor: Colors.black,
                                                        content: Text("!Debes ingresar tu contraseña!", style: textWhiteSubTitle,),behavior: SnackBarBehavior.floating,
                                                      ));
                                                    }
                                                    else{
                                                      setState(() {
                                                        isLoading = true;
                                                        authUser(emailController.text, passwordController.text);
                                                      });

                                                    }
                                                  },
                                                  child: Text("INGRESAR", style: textWhiteTitle,)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void authUser(emailAddress, password) async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      setState(() {

        final _auth = FirebaseAuth.instance;
        final User? _user = _auth.currentUser;
        final uid = _user?.uid;

        final docRef = FirebaseFirestore.instance.collection('Users').doc(uid.toString());
        docRef.get().then(
              (event){
            setState(() {



              //NEXT SCREEN
              isLoading = false;
            });
          },
        );



      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          shape: appBarShape,
          backgroundColor: Colors.black,
          content: Text("Este correo no se encuentra registrado en Oliware", style: textWhiteSubTitle,),behavior: SnackBarBehavior.floating,
        ));
      } else if (e.code == 'wrong-password') {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          shape: appBarShape,
          backgroundColor: Colors.black,
          content: Text("Ingresaste una contraseña incorrecta", style: textWhiteSubTitle,),behavior: SnackBarBehavior.floating,
        ));
      }
    }
  }
}
