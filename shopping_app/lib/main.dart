import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shopping_app/service/routes.dart';
import 'package:shopping_app/src/app/home/bindings/home_binding.dart';
import 'package:shopping_app/src/app/home/home_view.dart';

Future<void> initServices() async {}

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   if (Firebase.apps.isEmpty) {
//     await Firebase.initializeApp();
//   }
//   debugPrint('Handling a background message: ${message.messageId}');
//   // Add your background message handling logic here
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Get.put(NotificationController());
  // Handle background messages
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await EasyLocalization.ensureInitialized();
  await initServices();
  // await GetStorage.init();

  // Get.put(MyPref());

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: GetMaterialApp(
        title: 'Shopping',
        smartManagement: SmartManagement.onlyBuilder,
        debugShowCheckedModeBanner: false,
        // localizationsDelegates: context.localizationDelegates,
        //supportedLocales: context.supportedLocales,
        //locale: context.locale,
        initialRoute: homeView,
        getPages: routes,
        initialBinding: HomeBinding(),
      ),
    );
  }
}
