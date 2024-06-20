import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/adapter/userAdapter.dart';
import 'package:workout_app/model/exercise_modal.dart';
import 'package:workout_app/model/user_modal.dart';
import 'package:workout_app/provider/user_provider.dart';
import 'package:workout_app/screen/exercise_list_screen.dart';
import 'package:workout_app/screen/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(UserAdapter());

  // Open Hive box for users
  await Hive.openBox<User>('users');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise App',
      theme: ThemeData(
        primaryColor: Color(0xFFF26E56),
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      ),
      home: FutureBuilder(
        future: Hive.openBox<User>('users'),
        builder: (context, AsyncSnapshot<Box<User>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final userBox = snapshot.data!;
          final userExists = userBox.isNotEmpty;

          return userExists
              ? ExerciseListScreen(
                  exercises: exercises,
                  user: userBox.getAt(0)!,
                )
              : SignUpPage();
        },
      ),
    );
  }
}
