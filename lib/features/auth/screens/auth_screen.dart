import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth {
  SignIn,
  SignUp,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.SignUp;
  AuthService authService = AuthService();
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.SignUpUser(
      context: context,
      email: _emailController.text,
      name: _nameController.text,
      password: _passwordController.text,
    );
  }

  void signInUser() {
    authService.SignInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListTile(
                  tileColor: _auth == Auth.SignUp
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    'Create account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  /// value:-> What is the value represented by the radio button
                  /// groupValue: -> If groupValue = value, then the button is selected
                  /// We are inializing the default value of our auth at the starting of the build method using _auth variable
                  leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Auth.SignUp,
                      groupValue: _auth,
                      onChanged: (Auth? auth) {
                        setState(() {
                          _auth = auth!;
                        });
                      }),
                ),
                if (_auth == Auth.SignUp)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                        key: _signUpFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _nameController,
                              HintText: 'Name',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: _emailController,
                              HintText: 'Email',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: _passwordController,
                              HintText: 'Password',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                              text: 'Sign Up',
                              onTap: () {
                                if (_signUpFormKey.currentState!.validate()) {
                                  signUpUser();
                                }
                              },
                            ),
                          ],
                        )),
                  ),
                ListTile(
                  tileColor: _auth == Auth.SignIn
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    'Sign-In.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Auth.SignIn,
                      groupValue: _auth,
                      onChanged: (Auth? auth) {
                        setState(() {
                          _auth = auth!;
                        });
                      }),
                ),
                if (_auth == Auth.SignIn)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                        key: _signInFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _emailController,
                              HintText: 'Email',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: _passwordController,
                              HintText: 'Password',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                                text: 'Sign In',
                                onTap: () {
                                  if (_signInFormKey.currentState!.validate()) {
                                    signInUser();
                                  }
                                }),
                          ],
                        )),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
