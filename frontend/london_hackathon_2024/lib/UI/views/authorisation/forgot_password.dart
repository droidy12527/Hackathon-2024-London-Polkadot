// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../../Core/Services/Authorisation.dart';
import '../../widgets/auth_textfield.dart';
import '../../widgets/authorisation_buttons.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();

  void resetPasswordSubm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    final responseCode = await AuthService.resetPassword(email.text);
    if (responseCode != "success") {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Enter your email and we will send you \n a password reset link",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AuthTextField(
                  controller: email,
                  hintText: "Email",
                  onSubm: resetPasswordSubm,
                  obscureText: false,
                  prefixIcon: Icons.mail,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: MainButton(
                  inProgress: false,
                  padding: 17,
                  onTap: resetPasswordSubm,
                  text: "Reset Password",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
