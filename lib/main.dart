import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/components/life_cycle_event_handler.dart';
import 'package:social_media_app/landing/landing_page.dart';
import 'package:social_media_app/screens/mainscreen.dart';
import 'package:social_media_app/services/user_service.dart';
// import 'package:social_media_app/utils/config.dart';
import 'package:social_media_app/utils/constants.dart';
import 'package:social_media_app/utils/providers.dart';
import 'package:social_media_app/view_models/theme/theme_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const firebaseOptions = FirebaseOptions(
    appId: "1:1068304366604:android:349fcab862beffab3bc229",
    apiKey: "AIzaSyD5VG_Mk3qLDkcrsyWQRH3_hDq1XfigywQ",
    authDomain: "your_auth_domain",
    projectId: "social-media-4646b",
    storageBucket: "social-media-4646b.appspot.com",
    messagingSenderId: "1068304366604",
    databaseURL: "https://social-media-4646b-default-rtdb.firebaseio.com/",
  );

  await Firebase.initializeApp(options: firebaseOptions);

  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: true,
  );

  FirebaseFirestore.instance.enablePersistence();

  // await Config.initFirebase(
  //   options: FirebaseOptions(
  //     appId: "1:1068304366604:android:349fcab862beffab3bc229",
  //     apiKey: "AIzaSyD5VG_Mk3qLDkcrsyWQRH3_hDq1XfigywQ",
  //     authDomain: "your_auth_domain",
  //     projectId: "social-media-4646b",
  //     storageBucket: "social-media-4646b.appspot.com",
  //     messagingSenderId: "1068304366604",
  //     databaseURL: "https://social-media-4646b-default-rtdb.firebaseio.com/",
  //     // measurementId:,

  //     // other configuration options...
  //   ),
  // );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(
      LifecycleEventHandler(
        detachedCallBack: () => UserService().setUserStatus(false),
        resumeCallBack: () => UserService().setUserStatus(true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<ThemeProvider>(
        builder: (context, ThemeProvider notifier, Widget? child) {
          return MaterialApp(
            title: Constants.appName,
            debugShowCheckedModeBanner: false,
            theme: themeData(
              notifier.dark ? Constants.darkTheme : Constants.lightTheme,
            ),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: ((BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return TabScreen();
                } else
                  return Landing();
              }),
            ),
          );
        },
      ),
    );
  }

  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.nunitoTextTheme(
        theme.textTheme,
      ),
    );
  }
}
