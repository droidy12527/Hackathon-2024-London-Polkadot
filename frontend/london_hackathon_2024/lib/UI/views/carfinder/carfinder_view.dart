import 'package:flutter/material.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';
import 'package:london_hackathon_2024/Core/Repository/repository.dart';
import 'package:london_hackathon_2024/UI/views/carfinder/carview.dart';

import '../../../Core/Models/car_model.dart';
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
      Car car = await Repository.fetchCarHistory(_licensePlateController.text.trim());
      car.licensePlate = _licensePlateController.text.trim();
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CarView(
            car: car,
          ),
        ),
      );
    } catch (e) {
      return;
    }
  }

  void searchLicense(String License) async {
    try {
      Car car = await Repository.fetchCarHistory(License.trim());
      car.licensePlate = License.trim();
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CarView(
            car: car,
          ),
        ),
      );
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: AuthTextField(
                controller: _licensePlateController,
                hintText: "License Plate",
                onSubm: (value) {
                  searchSubm();
                },
                obscureText: false,
                prefixIcon: Icons.search,
              ),
            ),
            ScalableOCR(
                paintboxCustom: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 4.0
                  ..color = const Color.fromARGB(153, 102, 160, 241),
                boxLeftOff: 4,
                boxBottomOff: 2.7,
                boxRightOff: 4,
                boxTopOff: 2.7,
                boxHeight: MediaQuery.of(context).size.height / 5,
                getScannedText: (value) {
                  if ((value as String).trim() != "") {
                    searchLicense(value);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
