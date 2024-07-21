import 'package:flutter/material.dart';
import 'package:london_hackathon_2024/Core/Models/car_model.dart';
import 'package:london_hackathon_2024/Core/Repository/repository.dart';
import 'package:toastification/toastification.dart';

class TransferOwnerShipView extends StatefulWidget {
  const TransferOwnerShipView({super.key});

  @override
  State<TransferOwnerShipView> createState() => _TransferOwnerShipViewState();
}

class _TransferOwnerShipViewState extends State<TransferOwnerShipView> {
  int curstep = 0;
  int maxStep = 0;
  final TextEditingController _licencePlateController = TextEditingController();
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
        if (_ownerController.text == "") {
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
              title: const Text("New Owner Name"),
              content: Center(
                child: TextFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(2),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      hintText: "New Owner Name",
                      hintStyle: TextStyle(color: Colors.grey)),
                  controller: _ownerController,
                  maxLines: null,
                ),
              ),
              isActive: curstep >= 1,
              state: checkStepState(1)),
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
                      String tnx = await Repository.transferOwnerShip(
                        _ownerController.text.trim(),
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
