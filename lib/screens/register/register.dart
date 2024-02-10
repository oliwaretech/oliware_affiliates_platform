import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../loading/loading.dart';
import '../../styles/styles.dart';
import '../home/home.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool isCompleted = false;
  int currentStep = 0;
  bool dialogLoading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final documentNumberController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final companyNameController = TextEditingController();
  final companyDocumentNumberController = TextEditingController();
  final companyAddressController = TextEditingController();
  String document_type = "D.N.I";

  String contact_origin = "Facebook";
  Stream<QuerySnapshot>? _contactOriginStream;

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final currentWidth = MediaQuery.of(context).size.width;

    return  dialogLoading == true ? Loading() : Scaffold(
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
                child: Text("OLIWARARE AFILIADOS", style: textWhiteOliwareTitle,),
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
            padding:  EdgeInsets.all(currentWidth > 860 ? 42 : 8),
            child: Card(
              shape: cardShape,
              elevation:22,
              shadowColor:  Color(0xFF4271B1),
              child: Padding(
                padding: EdgeInsets.all(currentWidth > 860 ? 22.0 : 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height-200,
                      child: Theme(
                        data: ThemeData(
                          canvasColor: Color(0xE7E7E7FF),
                          colorScheme: Theme.of(context).colorScheme.copyWith(
                            primary: Color(0xFF4271B1),
                            background: Color(0xFFAEADE3),
                            secondary: Colors.blueGrey,
                          ),
                        ),
                        child: Stepper(
                            type: currentWidth > 860 ? StepperType.horizontal : StepperType.vertical,
                            steps: getSteps(currentWidth),
                            currentStep: currentStep,
                            onStepContinue: () {
                              final isLastStep = currentStep == getSteps(currentWidth).length - 1;

                              if (isLastStep) {

                                dialogLoading = true;
                                registerData();

                              } else {
                                setState(() {
                                  if(currentStep == 0) {

                                    if(emailController.text.isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        shape: appBarShape,
                                        backgroundColor: Colors.black,
                                        content: Text("!Debes ingresar tu correo!", style: textWhiteSubTitle,),behavior: SnackBarBehavior.floating,
                                      ));
                                    }
                                    else if(passwordController.text.isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        shape: appBarShape,
                                        backgroundColor: Colors.black,
                                        content: Text("!Debes ingresar tu contraseña!", style: textWhiteSubTitle,),behavior: SnackBarBehavior.floating,
                                      ));
                                    }
                                    else if(confirmPasswordController.text.isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        shape: appBarShape,
                                        backgroundColor: Colors.black,
                                        content: Text("!Debes confirmar tu contraseña!", style: textWhiteSubTitle,),behavior: SnackBarBehavior.floating,
                                      ));
                                    }
                                    else if(passwordController.text.length < 6){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        shape: appBarShape,
                                        backgroundColor: Colors.black,
                                        content: Text("!Tu contraseña debe tener al menos 6 caracteres!", style: textWhiteSubTitle,),behavior: SnackBarBehavior.floating,
                                      ));
                                    }
                                    else if(passwordController.text != confirmPasswordController.text){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        shape: appBarShape,
                                        backgroundColor: Colors.black,
                                        content: Text("Las contraseñas no coinciden", style: textWhiteSubTitle,),behavior: SnackBarBehavior.floating,
                                      ));
                                    }
                                    else{
                                      currentStep += 1;
                                    }

                                  }
                                  if(currentStep == 1){
                                    if(nameController.text.isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        shape: appBarShape,
                                        backgroundColor: Colors.black,
                                        content: Text("!Debes ingresar tus nombres!", style: textWhiteSubTitle,),behavior: SnackBarBehavior.floating,
                                      ));
                                    }
                                    else if(surnameController.text.isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        shape: appBarShape,
                                        backgroundColor: Colors.black,
                                        content: Text("!Debes ingresar tus apellidos!", style: textWhiteSubTitle,),behavior: SnackBarBehavior.floating,
                                      ));
                                    }
                                    else if(documentNumberController.text.isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        shape: appBarShape,
                                        backgroundColor: Colors.black,
                                        content: Text("!Debes ingresar tu número de documento de identidad!", style: textWhiteSubTitle,),behavior: SnackBarBehavior.floating,
                                      ));
                                    }
                                    else if(phoneNumberController.text.isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        shape: appBarShape,
                                        backgroundColor: Colors.black,
                                        content: Text("!Debes ingresar el número de tu teléfono móvil!", style: textWhiteSubTitle,),behavior: SnackBarBehavior.floating,
                                      ));
                                    }
                                    else{
                                      currentStep += 1;
                                    }
                                  }

                                });
                              }
                            },
                            onStepCancel: currentStep == 0
                                ? null
                                : () => setState(() => currentStep -= 1),
                            controlsBuilder: (BuildContext context, ControlsDetails details){
                              final isLastStep = currentStep == getSteps(currentWidth).length -1;
                              return Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(22),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton.icon(
                                      icon: Icon(Icons.arrow_right),
                                      style: mainButtonStyle,
                                      onPressed: details.onStepContinue,
                                      label: Text(isLastStep ? "REGISTRARSE":"CONTINUAR"),
                                    ),
                                    const SizedBox(height: 22,),
                                    if(currentStep != 0)
                                      TextButton(
                                        onPressed: details.onStepCancel,
                                        child: Text("Regresar", style: textGraySubTitle,),),

                                  ],
                                ),
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Step> getSteps(currentWidth) => [
    Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: Text("Información de Inicio de sesión", style: textInput,),
        content: Container(
          child: Padding(
            padding: EdgeInsets.all(currentWidth > 860 ? 22.0 : 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text("INFOMRACIÓN DE INICIO DE SESIÓN", style: textBlackSubTitle, textAlign: TextAlign.center,)),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Correo Electrónico:", style: textGraySubTitle, textAlign: TextAlign.start,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: textInput,
                    controller: emailController,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: textFieldDecoration.copyWith(hintText: "Correo Electrónico..."),
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Contraseña:", style: textGraySubTitle, textAlign: TextAlign.start,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: textInput,
                    controller: passwordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: textFieldDecoration.copyWith(hintText: "Contraseña..."),
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Confirmar Contraseña:", style: textGraySubTitle, textAlign: TextAlign.start,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: textInput,
                    controller: confirmPasswordController,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: textFieldDecoration.copyWith(hintText: "Confirmar Contraseña..."),
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
          ),
        )),
    Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: Text("Identifiación", style: textInput,),
        content: Container(
          child: Padding(
            padding: EdgeInsets.all(currentWidth > 860 ? 22.0 : 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text("IIDENTIFICACIÓN", style: textBlackSubTitle, textAlign: TextAlign.center,)),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Nombres:", style: textGraySubTitle, textAlign: TextAlign.start,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: textInput,
                    controller: nameController,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: textFieldDecoration.copyWith(hintText: "Nombres..."),
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Apellidos:", style: textGraySubTitle, textAlign: TextAlign.start,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: textInput,
                    controller: surnameController,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: textFieldDecoration.copyWith(hintText: "Apellidos..."),
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Tipo de Documento de Identidad:", style: textGraySubTitle, textAlign: TextAlign.start,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    value: document_type,
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                    style: textInput,
                    decoration: textFieldDecoration.copyWith(prefixIcon: Icon(Icons.person_pin_rounded)),
                    isExpanded: true,
                    items: <String>['D.N.I', 'C/E']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        document_type = newValue!;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Número de Documento de Identidad:", style: textGraySubTitle, textAlign: TextAlign.start,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: textInput,
                    controller: documentNumberController,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: textFieldDecoration.copyWith(hintText: "Número de Documento..."),
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Teléfono Móvil de Contacto:", style: textGraySubTitle, textAlign: TextAlign.start,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: textInput,
                    controller: phoneNumberController,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: textFieldDecoration.copyWith(hintText: "Teléfono Móvil..."),
                    maxLength: 9,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        )),
    Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: Text("Información Adicional", style: textInput,),
        content: Container(
          child: Padding(
            padding: EdgeInsets.all(currentWidth > 860 ? 22.0 : 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text("INFOMRACIÓN ADICIONAL", style: textBlackSubTitle, textAlign: TextAlign.center,)),
                ),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("¿Cómo te enteraste del programa de afiliados?", style: textGraySubTitle, textAlign: TextAlign.start,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    value: contact_origin,
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                    style: textInput,
                    decoration: textFieldDecoration.copyWith(prefixIcon: Icon(Icons.person_pin_rounded)),
                    isExpanded: true,
                    items: <String>['Facebook', 'Instagram','LinkedIn','TikTok','Correo','Amigos o Familiares','Compañero de trabajo','Otro']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        contact_origin = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        )
    )
  ];

  Future registerData() async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final timestamp = DateTime.now().millisecondsSinceEpoch;

      setState(() {
        String? uid = credential.user?.uid.toString();

        final userData = <String, dynamic>{
          "name" : nameController.text,
          "profile_image" : "",
          "surname" : surnameController.text,
          "email" : emailController.text,
          "password" : passwordController.text,
          "phone" : phoneNumberController.text,
          "document_type" : document_type,
          "document_number" : documentNumberController.text,
          "fullname" : nameController.text+" "+surnameController.text,
          "registration_date" : DateTime.now(),
          "uid" : uid,
          "contact_origin" : contact_origin,
          "current_balance" : 0.00,
        };

        db.collection("Affiliate Users").doc(uid)
            .set(userData, SetOptions(merge: true)).then((value) {

          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
            dialogLoading = false;
          });

        });


      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          shape: appBarShape,
          backgroundColor: Colors.black,
          content: Text("!Esta contraseña no cumple con los parámetros de seguridad, crea una contraseña más segura!", style: textWhiteSubTitle,),behavior: SnackBarBehavior.floating,
        ));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          shape: appBarShape,
          backgroundColor: Colors.black,
          content: Text("Este correo ya fue registrado anteriormente en Oliware!", style: textWhiteSubTitle,),behavior: SnackBarBehavior.floating,
        ));
        setState(() {
          dialogLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
