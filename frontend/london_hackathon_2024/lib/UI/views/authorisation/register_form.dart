// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../Core/Services/Authorisation.dart';
import '../../widgets/auth_textfield.dart';
import '../../widgets/authorisation_buttons.dart';

class RegisterForm extends StatefulWidget {
  final Function()? flip;
  const RegisterForm({super.key, required this.flip});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _passwordConfirmationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _signUpProgress = false;

  @override
  Widget build(BuildContext context) {
    void signUpWithEmail() async {
      //If user is already in state of logging in return
      if (_signUpProgress) {
        return;
      }
      //If the input is in valid return
      if (!_formKey.currentState!.validate()) {
        return;
      }

      //Retract the keyboard
      FocusManager.instance.primaryFocus?.unfocus();

      setState(() {
        _signUpProgress = true;
      });

      String res = await AuthService.signUserUpWithEmail(
          _emailController.text, _passwordController.text, _passwordConfirmationController.text);
      if (res == "success") {
        return;
      }

      setState(() {
        _signUpProgress = false;
      });
    }

    var secondaryColor = Theme.of(context).colorScheme.secondary;
    return Material(
      elevation: 20,
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Sign up",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: secondaryColor),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AuthTextField(
                          controller: _emailController,
                          hintText: "Email",
                          obscureText: false,
                          prefixIcon: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AuthTextField(
                          controller: _passwordController,
                          hintText: "Password",
                          obscureText: true,
                          prefixIcon: Icons.lock_outline,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AuthTextField(
                          controller: _passwordConfirmationController,
                          hintText: "Confirmaton",
                          obscureText: true,
                          prefixIcon: Icons.lock_outline,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  MainButton(
                    onTap: signUpWithEmail,
                    text: "SIGN UP",
                    padding: 17,
                    inProgress: _signUpProgress,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 27,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already Have Account?"),
                      TextButton(
                        onPressed: widget.flip,
                        child: const Text("Sign in"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
