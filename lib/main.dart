import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobitek/models/image_post.dart';
import 'package:mobitek/screens/home_screen.dart';
import 'package:mobitek/utils/firestore_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final FirestoreService _firestoreService = FirestoreService();
    return MultiProvider(
      providers: [
        StreamProvider<List<ImagePost>>(
          initialData: [],
          create: (BuildContext context) => _firestoreService.getImagePostList,
          catchError: (_, __) => [],
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AscendTek Demo',
        theme: ThemeData(
          primarySwatch: Colors.lime,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
