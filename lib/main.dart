import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:style_cron_job/style_cron_job.dart';
import 'package:subapp/model/list_model.dart';
import 'package:subapp/providers/home_page_provider.dart';
import 'package:subapp/view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ListModelAdapter());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomePageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Provider.of<HomePageProvider>(context, listen: false).getStartingData();
    each.month.onDay(1).atHour(1).listen((time) async {
      await Provider.of<HomePageProvider>(context, listen: false).monthCheck();
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
