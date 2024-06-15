import 'package:app/utils/shared_service.dart';
import 'package:app/utils/user_preference.dart';
import 'package:app/views/auth/screens/login.dart';
import 'package:app/views/detail/details_page.dart';
import 'package:app/views/home/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constants/globalvariable.dart';
import 'router.dart';

Widget _defaultHome = const HomePage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferance.init();
  bool _result = await SharedService.isLoggedIn();

  if (_result) {
    _defaultHome = const HomePage();
  }

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initstate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KinMell',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: const Color.fromARGB(255, 12, 40, 63),
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: _defaultHome,
    );
  }
}
