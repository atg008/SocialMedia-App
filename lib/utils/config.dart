import 'package:firebase_core/firebase_core.dart';

class Config {
  static initFirebase({required FirebaseOptions options}) async {
    await Firebase.initializeApp();
  }
}
