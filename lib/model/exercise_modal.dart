import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Exercise extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<String> steps;

  @HiveField(2)
  bool isCompleted; // Property to track completion

  @HiveField(3)
  final String imageUrl;

  Exercise({
    required this.name,
    required this.steps,
    this.isCompleted = false, // Default value is false
    required this.imageUrl, // Required image URL
  });
}

final List<Exercise> exercises = [
  Exercise(
    name: 'Push-ups',
    steps: [
      'Start in a plank position with your hands placed shoulder-width apart.',
      'Lower your body until your chest nearly touches the floor.',
      'Push your body back up to the starting position.',
      'Repeat for the desired number of repetitions.',
    ],
    imageUrl: 'assets/images/push-up.png',
  ),
  Exercise(
    name: 'Plank',
    steps: [
      'Start in a push-up position with your hands directly under your shoulders.',
      'Hold your body in a straight line from head to heels, without letting your hips sag or rise.',
      'Keep your abdominals engaged and hold for the desired duration.',
    ],
    imageUrl: 'assets/images/plank.png',
  ),
  Exercise(
    name: 'Leg Raises',
    steps: [
      'Lie on your back with your legs straight.',
      'Lift your legs upward until they form a 90-degree angle with your torso.',
      'Lower your legs back down slowly.',
      'Repeat for the desired number of repetitions.',
    ],
    imageUrl: 'assets/images/legraises.png', // Path to the image asset
  ),
  Exercise(
    name: 'Mountain Climbers',
    steps: [
      'Start in a plank position with your hands placed shoulder-width apart.',
      'Drive your knees in towards your chest, one at a time, as if you are running in place.',
      'Keep your core engaged and your back flat throughout the exercise.',
      'Repeat for the desired number of repetitions.',
    ],
    imageUrl: 'assets/images/moutainClimber.png',
  ),
  Exercise(
    name: 'Jumping Jacks',
    steps: [
      'Stand with your feet together and your hands at your sides.',
      'Jump up while spreading your legs and raising your arms above your head.',
      'Land softly with your feet shoulder-width apart and your arms at your sides.',
      'Repeat for the desired number of repetitions.',
    ],
    imageUrl: 'assets/images/jumpingJack.png',
  ),
  Exercise(
    name: 'Burpees',
    steps: [
      'Start in a standing position.',
      'Drop into a squat position with your hands on the ground.',
      'Kick your feet back into a plank position, perform a push-up.',
      'Return your feet to the squat position, and then jump up into the air.',
      'Repeat for the desired number of repetitions.',
    ],
    imageUrl: 'assets/images/burpess.png',
  ),
  Exercise(
    name: 'High Knees',
    steps: [
      'Stand in place with your knees slightly bent.',
      'Quickly lift your knees up to waist level, as high as possible, alternating legs.',
      'Pump your arms up and down to assist with the movement.',
      'Repeat for the desired number of repetitions.',
    ],
    imageUrl: 'assets/images/highKnees.png',
  ),
  Exercise(
    name: 'Bicycle Crunches',
    steps: [
      'Lie on your back with your knees bent and hands behind your head.',
      'Raise your shoulders off the ground and bring your right elbow to your left knee while straightening your right leg.',
      'Switch sides, bringing your left elbow to your right knee while straightening your left leg.',
      'Continue alternating sides in a pedaling motion.',
      'Repeat for the desired number of repetitions.',
    ],
    imageUrl: 'assets/images/BicycleCrunches.png',
  ),
  Exercise(
    name: 'Squats',
    steps: [
      'Stand with your feet shoulder-width apart.',
      'Lower your body by bending your knees and pushing your hips back.',
      'Return to the starting position by pushing through your heels.',
      'Repeat for the desired number of repetitions.',
    ],
    imageUrl: 'assets/images/squads.png',
  ),
  Exercise(
    name: 'Crunches',
    steps: [
      'Lie on your back with your knees bent and feet flat on the floor.',
      'Cross your arms in front of your chest.',
      'Raise your shoulders towards the ceiling using your abdominal muscles.',
      'Lower back down to the starting position.',
      'Repeat for the desired number of repetitions.',
    ],
    imageUrl: 'assets/images/crunches.png',
  ),
];
