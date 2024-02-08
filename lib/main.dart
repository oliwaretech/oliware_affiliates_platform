import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oliware_affiliates_platform/screens/login/login.dart';

import 'loading/loading.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAPiXCPxh29iLH14WSeRBtw81BDHe8UwRM",
        authDomain: "oliware-8718d.firebaseapp.com",
        projectId: "oliware-8718d",
        storageBucket: "oliware-8718d.appspot.com",
        messagingSenderId: "409317625798",
        appId: "1:409317625798:web:814998931972810416ecc7",
        measurementId: "G-41FWE02FHG"
    ),
  );
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oliware Affiliates',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot){
            if(snapshot.hasError){
              print("Error");
            }
            if(snapshot.connectionState == ConnectionState.done){
              return Login();
            }
            return Loading();
          }
      ),
    );
  }
}

