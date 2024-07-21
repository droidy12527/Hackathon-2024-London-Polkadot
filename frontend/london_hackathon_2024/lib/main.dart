import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:london_hackathon_2024/Core/Repository/repository.dart';
import 'package:london_hackathon_2024/UI/router.dart';
import 'package:london_hackathon_2024/UI/views/welcome_view.dart';
import 'package:provider/provider.dart';

import 'Core/Models/car_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? user = await FirebaseAuth.instance.authStateChanges().first;
  await Repository.init();
  //1 ,test123
  runApp(MyApp(
    authState: user,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, this.authState});
  User? authState;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Provider<User?>(
      create: (context) {
        return authState;
      },
      child: MaterialApp(
        title: 'CarNet',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          splashFactory: NoSplash.splashFactory,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueAccent,
          ),
          useMaterial3: true,
        ),
        home: MyRouter(),
      ),
    );
  }
}
