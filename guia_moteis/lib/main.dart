import 'package:flutter/material.dart';
import 'package:guia_moteis/view/moteis/moteis_page.dart';
import 'package:guia_moteis/view_model/carrossel_viewmodel.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
        MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CarouselViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motéis App',
      theme: ThemeData.dark(),
      home: MoteisScreen(),
    );
  }
}
