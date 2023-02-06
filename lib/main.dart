import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_map/screen/homepage.dart';

void main()
{
  runApp(

    MyApp(),
  );
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.black,
          elevation:0,
          centerTitle: true
        ),
        textTheme: TextTheme(
          bodyText2: GoogleFonts.lato(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
        )
      ),
      home: Map(),
    );
  }
}
