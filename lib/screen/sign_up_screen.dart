import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_app/contants/color.dart';
import 'package:workout_app/model/exercise_modal.dart';
import 'package:workout_app/model/user_modal.dart';
import 'package:workout_app/provider/user_provider.dart';
import 'package:workout_app/screen/exercise_list_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Sign Up'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                  children: [
                    TextSpan(
                      text: 'Get Your\n',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    TextSpan(
                      text: 'Fitness Journey\n',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    TextSpan(
                      text: 'Started\n',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 45,
                          color: mainColor),
                    ),
                  ],
                ),
              ),
              const Center(
                  child: Image(image: AssetImage("assets/images/sign-up.png"))),
              SizedBox(height: size.height * 0.02),
              _buildTextFormField(
                controller: _nameController,
                labelText: 'Name',
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your name'
                    : null,
              ),
              SizedBox(height: size.height * 0.02),
              _buildTextFormField(
                controller: _emailController,
                labelText: 'Email',
                validator: (value) =>
                    value == null || value.isEmpty || !value.contains('@')
                        ? 'Please enter a valid email address'
                        : null,
              ),
              SizedBox(height: size.height * 0.02),
              _buildTextFormField(
                controller: _numberController,
                labelText: 'Phone Number',
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your phone number'
                    : null,
              ),
              SizedBox(height: size.height * 0.02),
              _buildTextFormField(
                controller: _ageController,
                labelText: 'Age',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  final age = int.tryParse(value);
                  if (age == null || age <= 0 || age > 150) {
                    return 'Please enter a valid age';
                  }
                  return null;
                },
              ),
              SizedBox(height: size.height * 0.02),
              _buildTextFormField(
                controller: _heightController,
                labelText: 'Height (cm)',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  final height = double.tryParse(value);
                  if (height == null || height <= 0 || height > 300) {
                    return 'Please enter a valid height';
                  }
                  return null;
                },
              ),
              SizedBox(height: size.height * 0.02),
              _buildTextFormField(
                controller: _weightController,
                labelText: 'Weight (kg)',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  final weight = double.tryParse(value);
                  if (weight == null || weight <= 0 || weight > 500) {
                    return 'Please enter a valid weight';
                  }
                  return null;
                },
              ),
              SizedBox(height: size.height * 0.02),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: mainColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Sex",
                  labelStyle: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                value: 'Male',
                items: ['Male', 'Female', 'Other'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    // sex value set in _user.sex when dropdown value changes
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select your sex';
                  }
                  return null;
                },
              ),
              SizedBox(height: size.height * 0.03),
              SizedBox(
                width: size.width * 0.8,
                height: size.height * 0.04,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: mainColor),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final userProvider =
                          Provider.of<UserProvider>(context, listen: false);
                      final newUser = User(
                        name: _nameController.text,
                        email: _emailController.text,
                        number: _numberController.text,
                        age: int.tryParse(_ageController.text) ?? 0,
                        height: double.tryParse(_heightController.text) ?? 0.0,
                        weight: double.tryParse(_weightController.text) ?? 0.0,
                        sex: 'Male', // Get this value from dropdown
                      );
                      userProvider.addUser(newUser);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseListScreen(
                            user: newUser,
                            exercises: exercises,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: mainColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: labelText,
        labelStyle: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      validator: validator,
    );
  }
}
