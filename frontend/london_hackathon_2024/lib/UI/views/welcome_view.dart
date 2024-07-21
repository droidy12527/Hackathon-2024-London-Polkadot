import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

import '../widgets/main_button.dart';

class WelcomeView extends StatelessWidget {
  final Function() next;
  final Function() back;
  const WelcomeView({super.key, required this.next, required this.back});

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).colorScheme.primary;
    var secondaryColor = Theme.of(context).colorScheme.secondary;
    var animatedTextStyle = TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Built on Polka Dot',
                          textStyle: animatedTextStyle,
                          speed: const Duration(milliseconds: 75),
                        ),
                        TypewriterAnimatedText(
                          'Car-Tracking Solution',
                          textStyle: animatedTextStyle,
                          speed: const Duration(milliseconds: 75),
                        ),
                        TypewriterAnimatedText(
                          'CarNet',
                          textStyle: animatedTextStyle,
                          speed: const Duration(milliseconds: 75),
                        ),
                      ],
                      totalRepeatCount: 2,
                      isRepeatingAnimation: true,
                      stopPauseOnTap: true,
                      onFinished: () {},
                    ),
                    Container(
                      constraints: BoxConstraints(maxHeight: 180, maxWidth: 275),
                    ),
                    Lottie.asset('assets/anim.json'),
                    StartButton(
                      padding: 17,
                      text: "Car Lookup",
                      onTap: () => back(),
                    ),
                    const SizedBox(height: 15),
                    StartButton(
                      padding: 17,
                      iconData: Icons.arrow_back_ios_outlined,
                      text: "Car Audit",
                      onTap: () => next(),
                      color: Colors.white,
                      textColor: Colors.black,
                      rtl: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
