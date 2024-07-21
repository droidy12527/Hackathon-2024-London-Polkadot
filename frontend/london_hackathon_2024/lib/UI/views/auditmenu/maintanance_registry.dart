import 'package:flutter/material.dart';
import 'package:london_hackathon_2024/Core/Models/car_model.dart';
import 'package:london_hackathon_2024/Core/Repository/repository.dart';
import 'package:toastification/toastification.dart';

class CarMaintananceView extends StatefulWidget {
  const CarMaintananceView({super.key});

  @override
  State<CarMaintananceView> createState() => _CarMaintananceViewState();
}

class _CarMaintananceViewState extends State<CarMaintananceView> {
  int curstep = 0;
  int maxStep = 0;
  final TextEditingController _licencePlateController = TextEditingController();
  final TextEditingController _milageController = TextEditingController();
  final TextEditingController _serviceDescription = TextEditingController();

  StepState checkStepState(index) {
    if (index == curstep) {
      return StepState.editing;
    } else if (index > curstep) {
      return StepState.indexed;
    }
    return StepState.complete;
  }

  bool checkStateInput(index) {
    String message = "";
    switch (index) {
      case 0:
        if (_licencePlateController.text == "") {
          message = "Cannot leave fields blank";
        }
      case 1:
        if (_milageController.text == "") {
          message = "Cannot leave fields blank";
        }
      case 2:
        if (_serviceDescription.text == "") {
          message = "Cannot leave fields blank";
        }
    }
    if (message != "") {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.minimal,
        title: const Text("InputError"),
        description: Text(message),
        alignment: Alignment.bottomCenter,
        autoCloseDuration: const Duration(seconds: 4),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    List<Step> getSteps() => <Step>[
          Step(
              title: const Text("LicencePlate"),
              content: Center(
                child: TextFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(2),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      hintText: "LicencePlate",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: _licencePlateController,
                  maxLines: null,
                ),
              ),
              isActive: curstep >= 0,
              state: checkStepState(0)),
          Step(
              title: const Text("Milage"),
              content: Center(
                child: TextFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(2),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      hintText: "Miles",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: _milageController,
                  maxLines: null,
                ),
              ),
              isActive: curstep >= 1,
              state: checkStepState(1)),
          Step(
              title: const Text("Service Description"),
              content: Center(
                child: TextFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(2),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      hintText: "e.g. Oil Change",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: _serviceDescription,
                  keyboardType: TextInputType.streetAddress,
                  maxLines: null,
                ),
              ),
              isActive: curstep >= 2,
              state: checkStepState(2)),
        ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.black,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Stepper(
                  type: StepperType.vertical,
                  physics: const ClampingScrollPhysics(),
                  steps: getSteps(),
                  currentStep: curstep,
                  onStepTapped: (value) {
                    if (value <= maxStep) {
                      setState(() {
                        curstep = value;
                      });
                    }
                  },
                  onStepCancel: () {
                    if (curstep > 0) {
                      setState(() {
                        curstep -= 1;
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  onStepContinue: () async {
                    if (!checkStateInput(curstep)) {
                      return;
                    }

                    if (curstep < getSteps().length - 1) {
                      setState(() {
                        if (curstep == maxStep) {
                          maxStep += 1;
                        }
                        curstep += 1;
                      });
                    } else {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ServiceHistory serviceHistory = ServiceHistory(
                          mileage: _milageController.text.trim(),
                          timestamp: DateTime.now(),
                          description: _serviceDescription.text.trim());
                      String tnx = await Repository.addMaintanance(
                        serviceHistory,
                        _licencePlateController.text.trim(),
                      );
                      if (tnx != "error") {
                        toastification.show(
                          context: context,
                          type: ToastificationType.success,
                          style: ToastificationStyle.minimal,
                          title: Text("Transaction Completed"),
                          description: Text(tnx),
                          alignment: Alignment.bottomCenter,
                          autoCloseDuration: const Duration(seconds: 4),
                        );
                      } else {
                        toastification.show(
                          context: context,
                          type: ToastificationType.error,
                          style: ToastificationStyle.minimal,
                          title: Text("Transaction Error"),
                          description: Text("Unknown Error"),
                          alignment: Alignment.bottomCenter,
                          autoCloseDuration: const Duration(seconds: 4),
                        );
                      }
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
