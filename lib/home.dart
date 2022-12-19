import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:portfolioweb/service/auth_service.dart';

enum Auth { signin, signup }

class HomeWidget extends StatefulWidget {
  const HomeWidget({
    super.key,
  });

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  Auth _auth = Auth.signup;
  final _signinFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      name: nameController.text,
      email: emailController.text,
      password: passController.text,
    );
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: emailController.text,
      password: passController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.orange,
            Colors.purple,
          ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: 400,
                  height: 500,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                horizontalTitleGap: 1,
                                title: const Text('Create Account'),
                                selectedColor: Colors.purple,
                                leading: Radio(
                                    value: Auth.signup,
                                    groupValue: _auth,
                                    onChanged: (Auth? value) {
                                      setState(() {
                                        _auth = value!;
                                      });
                                    }),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                horizontalTitleGap: 1,
                                title: const Text('Sign-in'),
                                selectedColor: Colors.purple,
                                leading: Radio(
                                    value: Auth.signin,
                                    groupValue: _auth,
                                    onChanged: (Auth? value) {
                                      setState(() {
                                        _auth = value!;
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                        if (_auth == Auth.signup)
                          Form(
                            key: _signupFormKey,
                            child: Column(
                              children: [
                                CustomTextWidget(
                                  hintText: 'User Name',
                                  icon: Icons.person,
                                  controller: nameController,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextWidget(
                                  hintText: 'Email',
                                  icon: Icons.mail,
                                  controller: emailController,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextWidget(
                                  hintText: 'Password',
                                  icon: Icons.lock,
                                  controller: passController,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomElevatedButton(
                                  text: 'Sign Up',
                                  onTap: () {
                                    if (_signupFormKey.currentState!
                                        .validate()) {
                                      signUpUser();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        if (_auth == Auth.signin)
                          Form(
                            key: _signinFormKey,
                            child: Column(
                              children: [
                                CustomTextWidget(
                                  hintText: 'Email',
                                  icon: Icons.mail,
                                  controller: emailController,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextWidget(
                                  hintText: 'Password',
                                  icon: Icons.lock,
                                  controller: passController,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomElevatedButton(
                                  text: 'Sign In',
                                  onTap: () {
                                    if (_signinFormKey.currentState!
                                        .validate()) {
                                      signInUser();
                                    }

                                    log('Clicked');
                                  },
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        gradient: const LinearGradient(colors: [
          Colors.orange,
          Colors.purple,
        ]),
      ),
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            splashFactory: NoSplash.splashFactory,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
          ),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          )),
    );
  }
}

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.controller,
  }) : super(key: key);
  final String hintText;
  final IconData icon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        prefixIcon: Icon(
          icon,
        ),
      ),
      validator: ((value) {
        if (value == null || value.isEmpty) {
          return 'Enter Your $hintText';
        }
        return null;
      }),
    );
  }
}
