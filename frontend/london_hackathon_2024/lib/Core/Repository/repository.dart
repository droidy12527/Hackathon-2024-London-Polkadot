import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:london_hackathon_2024/Core/Models/car_model.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:london_hackathon_2024/Constants/constants.dart';

class Repository {
  static late Web3Client client;
  static late Credentials credentials;
  static late DeployedContract contract;

  static Future<String> init() async {
    // Initialize Web3Client with the HTTPS endpoint
    client = Web3Client('https://rpc.api.moonbase.moonbeam.network', Client());

    // Load private key
    credentials = EthPrivateKey.fromHex(privateKey);

    // Load contract address
    final contractAddress = EthereumAddress.fromHex(transactionAddress);

    // Load ABI from file
    final abiJson = await rootBundle.loadString('assets/car_mileage_abi.json');
    final abi = jsonDecode(abiJson);

    // Create contract instance
    contract = DeployedContract(
      ContractAbi.fromJson(jsonEncode(abi), 'CarMileage'),
      contractAddress,
    );

    return "Initialization completed";
  }

  static void dispose() {
    client.dispose();
  }

  static Uint8List licensePlateToIdBytes(String licensePlate) {
    final bytes = utf8.encode(licensePlate);
    final digest = sha256.convert(bytes);
    return Uint8List.fromList(digest.bytes);
  }

  static Future<String> registerCar(String licensePlate, CarConstantData constantData, String initialOwner) async {
    // Input validation

    try {
      // Get the contract function
      final registerCarFunction = contract.function('registerCar');

      // Prepare the transaction
      final transaction = Transaction.callContract(
        contract: contract,
        function: registerCarFunction,
        parameters: [
          licensePlateToIdBytes(licensePlate),
          BigInt.from(int.parse(constantData.year)),
          constantData.make,
          constantData.model,
          BigInt.from(int.parse(constantData.year)),
          initialOwner
        ],
      );

      // Send the transaction
      final txHash = await client.sendTransaction(
        credentials,
        transaction,
        chainId: 1287, // Moonbase Alpha TestNet chain ID
      );
      return txHash;
    } catch (ex) {
      return "error";
    }
  }

  static Future<Car> fetchCarHistory(String licensePlate) async {
    final fetchCarFunction = contract.function('getCarDetails');
    final res = await client.call(
      contract: contract,
      function: fetchCarFunction,
      params: [licensePlateToIdBytes(licensePlate)],
    );
    print(res);
    final int latestBlockNumber = await client.getBlockNumber();
    print('Latest Block Number: $latestBlockNumber');
    Car car = Car.fromJson(res);
    return car;
  }

  static Future<String> addMaintanance(ServiceHistory serviceHistory, String licensePlate) async {
    try {
      final updateMilage = contract.function('updateMileage');

      // Prepare the transaction
      final transaction = Transaction.callContract(
        contract: contract,
        function: updateMilage,
        parameters: [
          licensePlateToIdBytes(licensePlate),
          BigInt.from(int.parse(serviceHistory.mileage)),
          serviceHistory.description
        ],
      );
      print("good");
      // Send the transaction
      final txHash = await client.sendTransaction(
        credentials,
        transaction,
        chainId: 1287, // Moonbase Alpha TestNet chain ID
      );
      return txHash;
    } catch (ex) {
      print(ex);
      return "error";
    }
  }

  static Future<String> addAccidentReport(AccidentHistory accidentHistory, String licensePlate) async {
    try {
      final reportAccident = contract.function('reportAccident');

      // Prepare the transaction
      final transaction = Transaction.callContract(
        contract: contract,
        function: reportAccident,
        parameters: [
          licensePlateToIdBytes(licensePlate),
          accidentHistory.description,
          accidentHistory.partsChanged,
        ],
      );
      print("good");
      // Send the transaction
      final txHash = await client.sendTransaction(
        credentials,
        transaction,
        chainId: 1287, // Moonbase Alpha TestNet chain ID
      );
      return txHash;
    } catch (ex) {
      print(ex);
      return "error";
    }
  }

  static Future<String> transferOwnerShip(String newOwner, String licensePlate) async {
    try {
      final transferOwnership = contract.function('transferOwnership');

      // Prepare the transaction
      final transaction = Transaction.callContract(
        contract: contract,
        function: transferOwnership,
        parameters: [
          licensePlateToIdBytes(licensePlate),
          newOwner,
        ],
      );
      print("good");
      // Send the transaction
      final txHash = await client.sendTransaction(
        credentials,
        transaction,
        chainId: 1287, // Moonbase Alpha TestNet chain ID
      );
      return txHash;
    } catch (ex) {
      print(ex);
      return "error";
    }
  }
}
