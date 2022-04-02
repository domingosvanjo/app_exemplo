import 'package:app_exemplo/boasvindas_page.dart';
import 'package:flutter/material.dart';

import 'appWidget.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Autenticação',
      theme: ThemeData(
        primarySwatch: Colors.blue,),
        home: BoasVindasPage(),
      
    );
  }
}

