import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paragon/home/firstPage.dart';
import 'package:paragon/home/services/homeController.dart';
import 'package:paragon/login/loginPage.dart';
import 'package:paragon/login/services/loginController.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


String? token;
String? permission;
late SharedPreferences prefs;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  prefs = await SharedPreferences.getInstance();
  token = await prefs.getString('token');
  permission = await prefs.getString('permission');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => HomeController()),
        // ChangeNotifierProvider(create: (context) => JobController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: token == null
            ? LoginPage()
            : FirstPage()
      ),
    );
  }
}

