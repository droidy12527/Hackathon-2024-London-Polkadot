import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../Core/Models/car_model.dart';

String stringify(DateTime dateTime) {
  return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
}

class CarView extends StatelessWidget {
  final Car car;
  const CarView({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    var lastService = car.serviceHistory.last.timestamp;
    var lastOwner = car.ownerShipHistory.last;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 45),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Vehicle Summary",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          "VIN",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          car.carConstantData.vin,
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Text(
                          "Make",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          car.carConstantData.make,
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Text(
                          "Model",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          car.carConstantData.model,
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Text(
                          "Year",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          car.carConstantData.year,
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Text(
                          "Milage",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          "${car.mileage} miles",
                        ),
                      ],
                    ),
                    const Divider(),
                    if (car.serviceHistory.isNotEmpty) ...[
                      Row(
                        children: [
                          const Text(
                            "Last Maintanance",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(
                            stringify(lastService),
                          ),
                        ],
                      ),
                      const Divider()
                    ],
                    Row(
                      children: [
                        const Text(
                          "Owner",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          lastOwner.ownerName,
                        ),
                      ],
                    ),
                    if (car.serviceHistory.isNotEmpty) ...[
                      SizedBox(
                        height: 30,
                      ),
                      ExpandablePanel(
                        header: Text(
                          "Maintance History",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                        collapsed: Container(),
                        expanded: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: car.serviceHistory.length,
                          itemBuilder: (context, index) {
                            var serviceDate = car.serviceHistory[car.serviceHistory.length - index - 1].timestamp;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Material(
                                borderRadius: BorderRadius.circular(20),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Date",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          Text(
                                            stringify(serviceDate),
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                      Row(
                                        children: [
                                          const Text(
                                            "Description",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          Text(
                                            car.serviceHistory[car.serviceHistory.length - index - 1].description,
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                      Row(
                                        children: [
                                          const Text(
                                            "Mileage",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "${car.serviceHistory[car.serviceHistory.length - index - 1].mileage} miles",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    ExpandablePanel(
                      header: Text(
                        "Ownership History",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                      collapsed: Container(),
                      expanded: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: car.ownerShipHistory.length,
                        itemBuilder: (context, index) {
                          String endDate = "";
                          if (index == 0) {
                            endDate = "Present";
                          } else {
                            endDate = stringify(car.ownerShipHistory[car.ownerShipHistory.length - index].timestamp);
                          }
                          var serviceDate = car.ownerShipHistory[car.ownerShipHistory.length - index - 1].timestamp;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Date",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "${stringify(serviceDate)} - ${endDate}",
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      children: [
                                        const Text(
                                          "Owner Name",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          car.ownerShipHistory[car.ownerShipHistory.length - index - 1].ownerName,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    if (car.accidentHistory.isNotEmpty) ...[
                      ExpandablePanel(
                        header: Text(
                          "Accident Report History",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                        collapsed: Container(),
                        expanded: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: car.accidentHistory.length,
                          itemBuilder: (context, index) {
                            String endDate = "";

                            var serviceDate = car.accidentHistory[car.accidentHistory.length - index - 1].timestamp;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Material(
                                borderRadius: BorderRadius.circular(20),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Date",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "${stringify(serviceDate)}",
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                      Row(
                                        children: [
                                          const Text(
                                            "Description",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          Text(
                                            car.accidentHistory[car.accidentHistory.length - index - 1].description,
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                      Row(
                                        children: [
                                          const Text(
                                            "Parts Changed",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          Expanded(
                                            child: Text(
                                              car.accidentHistory[car.accidentHistory.length - index - 1].partsChanged
                                                  .join(","),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
