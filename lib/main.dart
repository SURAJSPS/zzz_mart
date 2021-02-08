import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zzzmart/auth/model/user_model.dart';
import 'package:zzzmart/navigation_page.dart';
import 'package:zzzmart/res/colors.dart';
import 'package:zzzmart/theme/app_state.dart';
import 'package:zzzmart/theme/app_theme.dart';

UserModel userModel;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: MyColors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      // navigation bar color/ status bar color
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: MyColors.white));

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // if (CurrentUser.fetchCurrentUser() != null) {
  //   userModel = await CurrentUser.readCurrentUser("user");
  //   print("__________$userModel");
  // } else {
  //   userModel = null;
  // }

  runApp(ChangeNotifierProvider<AppState>(
    create: (context) => AppState(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ZZZ Mart',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.lightTheme,
          themeMode: ThemeMode.light,
          color: Colors.blue,
          // home: RazorpayTest(),
          home: NavigationPage(),
        );
      },
    );
  }
}
