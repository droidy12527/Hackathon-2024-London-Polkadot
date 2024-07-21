import 'package:flutter/material.dart';
import 'package:london_hackathon_2024/Core/Models/car_model.dart';
import 'package:london_hackathon_2024/Core/Repository/repository.dart';
import 'package:toastification/toastification.dart';

class CarRegistryView extends StatefulWidget {
  const CarRegistryView({super.key});

  @override
  State<CarRegistryView> createState() => _CarRegistryViewState();
}

class _CarRegistryViewState extends State<CarRegistryView> {
  int curstep = 0;
  int maxStep = 0;
  final TextEditingController _licencePlateController = TextEditingController();
  final TextEditingController _VINController = TextEditingController();
  final TextEditingController _makeController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _ownerController = TextEditingController();

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
        if (_VINController.text == "") {
          message = "Cannot leave fields blank";
        }
      case 2:
        if (_makeController.text == "") {
          message = "Cannot leave fields blank";
        }
      case 3:
        if (_modelController.text == "") {
          message = "Cannot leave fields blank";
        }
      case 4:
        if (_yearController.text == "") {
          message = "Cannot leave fields blank";
        }
      case 5:
        if (_yearController.text == "") {
          message = "Cannot leave fields blank";
        }
    }
    if (message != "") {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.minimal,
        title: Text("InputError"),
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
              title: const Text("VIN Number"),
              content: Center(
                child: TextFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(2),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      hintText: "VIN",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: _VINController,
                  maxLines: null,
                ),
              ),
              isActive: curstep >= 1,
              state: checkStepState(1)),
          Step(
              title: const Text("Car make"),
              content: Center(
                child: TextFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(2),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      hintText: "e.g. Toyota",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: _makeController,
                  keyboardType: TextInputType.streetAddress,
                  maxLines: null,
                ),
              ),
              isActive: curstep >= 2,
              state: checkStepState(2)),
          Step(
              title: const Text("Car Model"),
              content: Center(
                child: TextFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(2),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      hintText: "e.g. Corolla",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: _modelController,
                  maxLines: null,
                ),
              ),
              isActive: curstep >= 3,
              state: checkStepState(3)),
          Step(
              title: const Text("Manufacture Year"),
              content: Center(
                child: TextFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(2),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      hintText: "e.g. 2022",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: _yearController,
                  maxLines: null,
                ),
              ),
              isActive: curstep >= 4,
              state: checkStepState(4)),
          Step(
              title: const Text("Owner Name"),
              content: Center(
                child: TextFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(2),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      hintText: "Owner Name",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: _ownerController,
                  maxLines: null,
                ),
              ),
              isActive: curstep >= 5,
              state: checkStepState(5)),
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
                      CarConstantData carInitialData = CarConstantData(
                          vin: _VINController.text.trim(),
                          make: _makeController.text.trim(),
                          model: _modelController.text.trim(),
                          year: _yearController.text.trim());

                      String tnx = await Repository.registerCar(
                          _licencePlateController.text.trim(), carInitialData, _ownerController.text.trim());
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
