import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/contants/color.dart';
import 'package:workout_app/model/exercise_modal.dart';
import 'package:workout_app/model/user_modal.dart';
import 'package:workout_app/provider/user_provider.dart';
import 'package:workout_app/screen/edit_screen.dart';
import 'package:workout_app/screen/exercise_detail_screen.dart';

class ExerciseListScreen extends StatelessWidget {
  final List<Exercise> exercises;
  final User user;

  const ExerciseListScreen({
    Key? key,
    required this.exercises,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exercise List',
          style: GoogleFonts.montserrat(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const UserInfoWidget(),
            SizedBox(height: size.height * 0.03),
            Text(
              'Exercise List:',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Expanded(
              child: ExerciseListView(exercises: exercises),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'User Info:',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            color: mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Age: ${userProvider.user?.age ?? 0}',
                style:
                    GoogleFonts.montserrat(color: Colors.black, fontSize: 17)),
            Text('Height: ${userProvider.user?.height ?? 0} cm',
                style:
                    GoogleFonts.montserrat(color: Colors.black, fontSize: 17)),
            Text('Weight: ${userProvider.user?.weight ?? 0} kg',
                style:
                    GoogleFonts.montserrat(color: Colors.black, fontSize: 17)),
          ],
        ),
        SizedBox(height: size.height * 0.02),
        Center(
          child: SizedBox(
            width: size.width * 0.8,
            height: size.height * 0.04,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: mainColor),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(),
                  ),
                );
              },
              child: Text(
                'Update Info',
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ExerciseListView extends StatelessWidget {
  final List<Exercise> exercises;

  const ExerciseListView({
    Key? key,
    required this.exercises,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return ListView.builder(
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        final exercise = exercises[index];
        final isCompleted = userProvider.isExerciseCompleted(exercise.name);

        return Card(
          elevation: 3,
          color: isCompleted ? Colors.green : card1,
          child: ListTile(
            title: Text(exercise.name,
                style: GoogleFonts.montserrat(
                    color: isCompleted ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseDetailScreen(
                    exercise: exercise,
                    user: userProvider.user!,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
