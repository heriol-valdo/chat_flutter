import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



import 'package:provider/provider.dart';


import 'chat/Page_connexion_authentification_screens/chat/chat_screen.dart';
import 'chat/models/chat_params.dart';
import 'chat/models/user.dart';
import 'chat/redirection/authentication.dart';
import 'chat/redirection/splashscreen_wrapper.dart';



Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// If you're going to use other Firebase services in the background, such as Firestore,
// make sure you call `initializeApp` before using other Firebase services.
// await Firebase.initializeApp();
  print('Background message ${message.messageId}');
}


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBwEHVYmHwz7jXCUg_54RVuNZFHyaVIK0w",
        authDomain: "chat-9fc74.firebaseapp.com",
        databaseURL: "https://chat-9fc74-default-rtdb.europe-west1.firebasedatabase.app",
        projectId: "chat-9fc74",
        storageBucket: "chat-9fc74.appspot.com",
        messagingSenderId: "190919531619",
        appId: "1:190919531619:web:aa73cc35b3be64b0232c56",
        measurementId: "G-1PL2CCXFS9"


    )
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(kDebugMode ? false : true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  }
  runApp(MyApp());


}
class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return StreamProvider<AppUser?>.value(
      value: AuthenticationService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'premiere_page',
        onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case 'premiere_page' :
        return MaterialPageRoute(builder: (context) =>SplashScreenWrapper());
      case '/profile':
      //  return MaterialPageRoute(builder: (context) =>ProfileUser(paramsUser: arguments as ParamsUser,);
      case '/chat':
        var arguments = settings.arguments;
        if (arguments != null) {
          return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ChatScreen(chatParams : arguments as ChatParams),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                animation = CurvedAnimation(curve: Curves.ease, parent: animation);
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              }
          );
        } else {
          return pageNotFound();
        }
      default:
        return pageNotFound();
    }
  }

  static MaterialPageRoute pageNotFound() {
    return MaterialPageRoute(
        builder: (context) =>
            Scaffold(
                appBar: AppBar(title: Text("Error"), centerTitle: true),
                body: Center(
                  child: Text("Page not found"),
                )
            )
    );
  }
}