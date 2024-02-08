import 'package:flutter/material.dart';

const backgroundStyle = BoxDecoration(
    gradient: LinearGradient(colors: [
      Color(0xFF4271B1),
      Color(0xFFAEADE3),
    ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),


);

const cardBackgroundStyle = BoxDecoration(
  gradient: LinearGradient(colors: [
    Color(0xFF4271B1),
    Color(0xFFAEADE3),
  ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  borderRadius: BorderRadius.all(Radius.circular(22)),

);

const profileBackgroundStyle = BoxDecoration(
  gradient: LinearGradient(colors: [
    Color(0xFFAEADE3),
    Color(0xFF4271B1),
  ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  borderRadius: BorderRadius.only(topRight: Radius.circular(22)),

);

const textWhiteSubTitle = TextStyle(
    fontSize: 18,
    //fontFamily: 'Cute Font',
    fontWeight: FontWeight.normal,
    letterSpacing: 1,
    color: Color(0xFFF3F3F3)

);

const textWhiteTitle = TextStyle(
    fontSize: 22,
    //fontFamily: 'Cute Font',
    fontWeight: FontWeight.bold,
    letterSpacing: 3,
    color: Color(0xFFF3F3F3)

);

const textBlackTitle = TextStyle(
    fontSize: 20,
    //fontFamily: 'Cute Font',
    fontWeight: FontWeight.bold,
    letterSpacing: 3,
    color: Colors.black

);

const textBlackSubTitle = TextStyle(
    fontSize: 16,
    //fontFamily: 'Cute Font',
    fontWeight: FontWeight.normal,
    letterSpacing: 1,
    color: Colors.black
);

const textGraySubTitle = TextStyle(
    fontSize: 16,
    //fontFamily: 'Cute Font',
    fontWeight: FontWeight.normal,
    letterSpacing: 1,
    color: Colors.blueGrey
);

const textInput = TextStyle(
    //fontSize: 22,
    //fontFamily: 'Cute Font',
    fontWeight: FontWeight.bold,
    letterSpacing: 3,
    color: Color(0xFF1D4C94)

);

const textWhiteOliwareTitle = TextStyle(
    fontSize: 22,
    fontFamily: 'Cute Font',
    fontWeight: FontWeight.bold,
    letterSpacing: 3,
    color: Color(0xFFF3F3F3)

);

const appBarShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(bottomRight: Radius.circular(22)),

);

const itemMenuShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(bottomRight: Radius.circular(22), topRight: Radius.circular(22) ),

);

const cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(22))

);

const leftBarShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(topRight: Radius.circular(22))

);

const backgroundGrayStyle = BoxDecoration(
    gradient: LinearGradient(colors: [
      Color(0xFFF3F3F3),
      Color(0xFFF3F3F3),
      Color(0xFFF3F3F3),
    ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    )
);

const textFieldDecoration = InputDecoration(

    fillColor: Color(0xFFF3F3F3),
    filled: true,
    labelStyle: TextStyle(
      color: Color(0xFFF3F3F3),
      fontWeight: FontWeight.w500,

    ),
    //hintText: "______",
    hintStyle: TextStyle(
        color: Color(0xFFAEADE3)
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0x1D4C94), width: 0.0),
        borderRadius: BorderRadius.all(Radius.circular(22))
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0x1D4C94),width: 0.0),
        borderRadius: BorderRadius.all(Radius.circular(22))
    )

);

var mainButtonStyle = ElevatedButton.styleFrom(
    minimumSize: const Size.fromHeight(65),
    primary: Color(0xFF1D4C94),
    shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(22.0)
    )
);

var cornerButtonStyle = ElevatedButton.styleFrom(
    minimumSize: const Size.fromHeight(65),
    primary: Color(0xFF1D4C94),
    shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(22), bottomRight: Radius.circular(22), topRight: Radius.circular(22))
    )
);

var bottomButtonStyle = ElevatedButton.styleFrom(
    minimumSize: const Size.fromHeight(95),
    primary: Color(0xFF1D4C94),
    shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22))
    )
);

var topButtonStyle = ElevatedButton.styleFrom(
    minimumSize: const Size.fromHeight(65),
    primary: Color(0xFF1D4C94),
    shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22))
    )
);


const cardMainShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22))

);

const greenSnackBarShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(22)),

);

const backgroundDialogStyle = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(22)),
  gradient: LinearGradient(colors: [
    Color(0xFF4271B1),
    Color(0xFFAEADE3),
  ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),

);

var fieldButtonStyle = ElevatedButton.styleFrom(
    minimumSize: const Size.fromHeight(65),
    primary: Color(0xFFF3F3F3),
    shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(22.0)
    )
);

const topRoundShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(topLeft: Radius.circular(22), bottomRight: Radius.circular(22)),

);

var leftBottomButtonStyle = ElevatedButton.styleFrom(
    minimumSize: const Size.fromHeight(65),
    primary: Color(0xFF1D4C94),
    shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(22), )
    )
);

var rightBottomButtonStyle = ElevatedButton.styleFrom(
    minimumSize: const Size.fromHeight(65),
    primary: Color(0xFF1D4C94),
    shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.only(bottomRight: Radius.circular(22), )
    )
);