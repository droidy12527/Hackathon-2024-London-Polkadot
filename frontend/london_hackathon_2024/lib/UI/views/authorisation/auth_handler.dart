import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:london_hackathon_2024/UI/views/auditmenu/audit_view.dart';
import 'package:provider/provider.dart';

import 'auth_view.dart';

class AuthHandler extends StatefulWidget {
  const AuthHandler({super.key});

  @override
  State<AuthHandler> createState() => _AuthHandlerState();
}

class _AuthHandlerState extends State<AuthHandler> {
  /*
    Listens to AuthStream and handles the AuthState.
    If AuthState has data Continue To accountCreationHandler.
  */
  late Stream<User?> authStateChanges;

  @override
  void initState() {
    super.initState();
    authStateChanges = FirebaseAuth.instance.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authStateChanges,
      initialData: context.watch<User?>(),
      builder: (context, snapshot) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 750),
          layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
          transitionBuilder: (child, animation) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
          child: snapshot.hasData ? const AuditView() : const AuthView(),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("disposed");
    super.dispose();
  }
}
