import 'package:appixoadmin/src/data/repository/auth.dart';
import 'package:appixoadmin/src/screen/home/home.dart';
import 'package:appixoadmin/src/utils/Constants/colors.dart';
import 'package:appixoadmin/src/utils/validator/text_field_validator.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Create a global key that will uniquely identify the Form widget and allow validation.
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double containerWidth = constraints.maxWidth > 600
                              ? 500
                              : constraints.maxWidth * 0.9;
                          double? containerHeight =
                          constraints.maxWidth > 607 ? 307 : null;

                          return Container(
                            width: containerWidth,
                            height: containerHeight,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 24.0),
                              child: Form(
                                key: _formKey, // Assign the form key here
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/images/logo.png",
                                      height: 60,
                                      width: 150,
                                      alignment: Alignment.topCenter,
                                    ),
                                    // Email Field
                                    TextFormField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'Email',
                                        prefixIcon: Icon(Icons.email),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                      ),
                                      keyboardType:
                                      TextInputType.emailAddress,
                                      validator:EmailValidator.validate // Add validator
                                    ),
                                    SizedBox(height: 20),

                                    // Password Field
                                    TextFormField(
                                      controller: passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'Password',
                                        prefixIcon: Icon(Icons.lock),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                      ),
                                      validator: PasswordValidator.validate // Add validator
                                    ),
                                    SizedBox(height: 10),

                                    // Login Button
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {

                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            AuthClass.loginEmailAndPassword(emailController.text.trim(),passwordController.text.trim()).then((value){

                                              setState(() {
                                                isLoading = false;
                                              });

                                             if(value){
                                               Navigator.pushReplacement(
                                                 context,
                                                 MaterialPageRoute(
                                                     builder: (context) =>
                                                     const Home()),
                                               );
                                             }
                                            });

                                          }
                                        },
                                        child: isLoading ? CircularProgressIndicator( color:Colors.white,) : Text(
                                          'Login',
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primary,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
