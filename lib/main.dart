import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:validation_ektp/routes/app_pages.dart';
import 'package:validation_ektp/utils/logger.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      theme: ThemeData.dark(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      logWriterCallback: LoggerApp.localLogWriter,
       localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        // const Locale('ru', 'RU'),
        const Locale('id', 'ID')
      ],
    );
  }
}