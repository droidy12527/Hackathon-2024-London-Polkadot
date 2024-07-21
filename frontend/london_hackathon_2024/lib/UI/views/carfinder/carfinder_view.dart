import 'package:flutter/material.dart';
import 'package:london_hackathon_2024/Core/Repository/repository.dart';

import '../../widgets/auth_textfield.dart';
import '../../widgets/authorisation_buttons.dart';

class CarFinderView extends StatefulWidget {
  const CarFinderView({super.key});

  @override
  State<CarFinderView> createState() => _CarFinderViewState();
}

class _CarFinderViewState extends State<CarFinderView> {
  TextEditingController _licensePlateController = new TextEditingController();
  void searchSubm() async {
    try {
      print(await Repository.fetchCarHistory(_licensePlateController.text.trim()));
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Search for a plate",
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
                controller: _licensePlateController,
                hintText: "License Plate",
                onSubm: searchSubm,
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
                onTap: searchSubm,
                text: "Search",
              ),
            )
          ],
        ),
      ),
    );
  }
}
