import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/contants/color.dart';
import 'package:workout_app/model/user_modal.dart';
import 'package:workout_app/provider/user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _numberController;
  late TextEditingController _ageController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _nameController = TextEditingController(text: userProvider.user!.name);
    _emailController = TextEditingController(text: userProvider.user!.email);
    _numberController = TextEditingController(text: userProvider.user!.number);
    _ageController =
        TextEditingController(text: userProvider.user!.age.toString());
    _heightController =
        TextEditingController(text: userProvider.user!.height.toString());
    _weightController =
        TextEditingController(text: userProvider.user!.weight.toString());
  }

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
    final userProvider = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: GoogleFonts.montserrat(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
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
              SizedBox(height: size.height * 0.04),
              SizedBox(
                width: size.width * 0.8,
                height: size.height * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final updatedUser = User(
                        name: _nameController.text,
                        email: _emailController.text,
                        number: _numberController.text,
                        age: int.tryParse(_ageController.text) ?? 0,
                        height: double.tryParse(_heightController.text) ?? 0.0,
                        weight: double.tryParse(_weightController.text) ?? 0.0,
                        sex: userProvider.user!.sex,
                        completedExercises:
                            userProvider.user!.completedExercises,
                        enableBackgroundMusic:
                            userProvider.user!.enableBackgroundMusic,
                      );
                      userProvider.updateUser(updatedUser);

                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Save Changes',
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ),
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
