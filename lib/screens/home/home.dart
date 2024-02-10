import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../styles/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _auth = FirebaseAuth.instance;

  String name = "", user_id = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final User? _user = _auth.currentUser;
    final uid = _user?.uid;
    user_id = uid.toString();

    getUserData(uid);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child:  Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Image.asset("assets/oliware.png", height: 70,),
                    ),),
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(name, style: textBlackTitle, textAlign: TextAlign.left,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: mainButtonStyle,
                                onPressed: (){
                                  Clipboard.setData(ClipboardData(text: "https://app.oliware.tech/affiliate/"+user_id));

                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    shape: greenSnackBarShape,
                                    backgroundColor: Colors.green,

                                    content: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Image.asset("assets/checkmark.gif", height: 40,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text("Enlace de referido copiado", style: textWhiteSubTitle, textAlign: TextAlign.center,),
                                        ),
                                      ],
                                    ),behavior: SnackBarBehavior.floating,
                                  ));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Compartir mi enlace de Referido", style: textWhiteSubTitle.copyWith(color: Colors.white), textAlign: TextAlign.center,),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FaIcon(FontAwesomeIcons.shareNodes, color: Colors.white,),
                                      ),
                                    )
                                  ],
                                )),
                          )
                        ],
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future getUserData(String? uid) async{

    final docRef = FirebaseFirestore.instance.collection('Affiliate Users').doc(uid.toString());
    docRef.get().then((value) {
      setState(() {
        name = value['name'];
      });
    });
  }
}
