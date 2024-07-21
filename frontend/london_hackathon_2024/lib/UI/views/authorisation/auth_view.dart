import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'login_form.dart';
import 'register_form.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool _displayFront = true;
  bool _transitionstate = false;

  void navigateToTermsAndConditions() async {
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const TermsAndConditions()),
    // );
  }

  void navigateToPrivacyPolicy() async {
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const PrivacyPolicy()),
    // );
  }

  Future<void> flipAuthForm() async {
    if (_transitionstate) {
      return;
    }
    _transitionstate = true;
    setState(() {
      _displayFront = !_displayFront;
    });
    await Future.delayed(const Duration(seconds: 1));
    _transitionstate = false;
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).colorScheme.primary;
    var secondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const SizedBox(
              height: 90,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 420,
                  width: 350,
                  child: form(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  //A switcher which controlls switch between sign in and sign up cards.
  Widget form() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 1000),
      layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
      switchInCurve: Curves.ease,
      transitionBuilder: _transition,
      switchOutCurve: Curves.ease.flipped,
      child: _displayFront
          ? LoginForm(
              flip: flipAuthForm,
            )
          : RegisterForm(
              flip: flipAuthForm,
            ),
    );
  }

  //Card Flipping Animation
  Widget _transition(Widget widget, Animation<double> animationState) {
    final rotateAnimationState = Tween(begin: pi, end: 0.0).animate(animationState);
    return AnimatedBuilder(
      animation: rotateAnimationState,
      child: widget,
      builder: (context, widget) {
        var isUnderState = (ValueKey(_displayFront) != widget!.key);

        var tilt = ((animationState.value - 0.5).abs() - 0.5) * 0.004;

        tilt *= isUnderState ? -1.0 : 1.0;

        final rotateY = isUnderState ? min(rotateAnimationState.value, pi / 2) : rotateAnimationState.value;

        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 0, tilt)
            ..rotateY(rotateY),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }
}
