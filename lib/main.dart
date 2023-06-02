import 'package:flutter/material.dart';
import 'package:vaccination/Logic/logic.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // localizationsDelegates: const [
      //   AppLocalizations.delegate,
      //   // AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en'),
      //   Locale('fr'),
      // Locale('ar'),
      // ],
      // localeResolutionCallback: (locale, supportedLocales) {
      //   for (var supportedLocale in supportedLocales) {
      //     if (supportedLocale.languageCode == locale!.languageCode &&
      //         supportedLocale.countryCode == locale.countryCode) {
      //       return supportedLocale;
      //     }
      //   }
      //   return supportedLocales.first;
      // },

      // localeResolutionCallback: (locale, supportedLocales) {
      //   // Check if the current device locale is supported
      //   for (var supportedLocale in supportedLocales) {
      //     print(locale!.languageCode);
      //     if (supportedLocale.languageCode == locale.languageCode &&
      //         supportedLocale.countryCode == locale.countryCode) {
      //       return supportedLocale;
      //     }
      //     print('$supportedLocale ===========');
      //   }
      //   // If the locale of the device is not supported, use the first one
      //   // from the list (English, in this case).
      //   return supportedLocales.elementAt(1);
      // },
      home: Logic(),
    );
  }
}
