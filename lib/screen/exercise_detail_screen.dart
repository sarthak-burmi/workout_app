import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_app/contants/color.dart';
import 'package:workout_app/model/exercise_modal.dart';
import 'package:workout_app/model/user_modal.dart';
import 'package:workout_app/screen/timer_screen.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final User user;
  final Exercise exercise;

  const ExerciseDetailScreen({
    Key? key,
    required this.user,
    required this.exercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          exercise.name,
          style: GoogleFonts.montserrat(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Steps:',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: exercise.steps
                  .map(
                    (step) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(step,
                          style: GoogleFonts.montserrat(
                              color: Colors.black, fontSize: 16)),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: size.height * 0.05),
            Text(
              'Figure:',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Image.asset(
              exercise.imageUrl,
              fit: BoxFit.contain,
              height: 300,
              width: double.infinity,
            ),
            SizedBox(height: size.height * 0.05),
            SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.05,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExerciseCountdownScreen(
                        exercise: exercise,
                      ),
                    ),
                  );
                },
                child: Text('Start Exercise',
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
