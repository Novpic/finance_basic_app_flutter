import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'App/home_page/widgets/singin_page.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SinginPage(),
        theme: ThemeData(
          primarySwatch: Colors.green,
          
        ),
      ),
    );
  }
}

