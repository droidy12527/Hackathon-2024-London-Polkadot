class Car {
  CarConstantData carConstantData;
  String mileage;
  String? licensePlate;
  List<ServiceHistory> serviceHistory;
  List<OwnerShipHistory> ownerShipHistory;
  List<AccidentHistory> accidentHistory;

  Car(
      {required this.carConstantData,
      required this.mileage,
      required this.serviceHistory,
      required this.ownerShipHistory,
      required this.accidentHistory,
      this.licensePlate});

  factory Car.fromJson(data) {
    return Car(
      carConstantData: CarConstantData.fromJson(data[0]),
      mileage: data[1].toString(),
      serviceHistory: ServiceHistory.fromJsonList(data[2]),
      ownerShipHistory: OwnerShipHistory.fromJsonList(data[3]),
      accidentHistory: AccidentHistory.fromJsonList(data[4]),
    );
  }
}

class AccidentHistory {
  DateTime timestamp;
  String description;
  List<String> partsChanged;

  AccidentHistory({
    required this.timestamp,
    required this.description,
    required this.partsChanged,
  });

  factory AccidentHistory.fromJson(json) {
    return AccidentHistory(
      timestamp: DateTime.fromMillisecondsSinceEpoch(json[0].toInt() * 1000),
      description: json[1].toString(),
      partsChanged: List<String>.from(json[2]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'description': description,
      'partsChanged': partsChanged,
    };
  }

  static List<AccidentHistory> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => AccidentHistory.fromJson(json)).toList();
  }
}

class OwnerShipHistory {
  String ownerName;
  DateTime timestamp;

  OwnerShipHistory({
    required this.ownerName,
    required this.timestamp,
  });

  factory OwnerShipHistory.fromJson(json) {
    return OwnerShipHistory(
      ownerName: json[0].toString(),
      timestamp: DateTime.fromMillisecondsSinceEpoch(json[1].toInt() * 1000),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ownerName': ownerName,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  static List<OwnerShipHistory> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => OwnerShipHistory.fromJson(json)).toList();
  }
}

class ServiceHistory {
  String mileage;
  DateTime timestamp;
  String description;

  ServiceHistory({
    required this.mileage,
    required this.timestamp,
    required this.description,
  });

  factory ServiceHistory.fromJson(json) {
    return ServiceHistory(
      mileage: json[0].toString(),
      timestamp: DateTime.fromMillisecondsSinceEpoch(json[1].toInt() * 1000),
      description: json[2].toString(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'mileage': mileage,
      'timestamp': timestamp.toIso8601String(),
      'description': description,
    };
  }

  static List<ServiceHistory> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ServiceHistory.fromJson(json)).toList();
  }
}

class CarConstantData {
  String vin;
  String make;
  String model;
  String year;

  CarConstantData({
    required this.vin,
    required this.make,
    required this.model,
    required this.year,
  });

  factory CarConstantData.fromJson(data) {
    return CarConstantData(
      vin: data[0].toString(),
      make: data[1].toString(),
      model: data[2].toString(),
      year: data[3].toString(),
    );
  }
}
