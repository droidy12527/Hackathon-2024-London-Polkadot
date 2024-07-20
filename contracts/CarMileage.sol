// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CarMileage {
    address public contractOwner;

    struct CarConstantData {
        string vin;
        string make;
        string model;
        uint16 year;
    }

    struct CarMutableData {
        string currentOwnerName;
        uint256 mileage;
        ServiceRecord[] serviceHistory;
        OwnershipRecord[] ownershipHistory;
    }

    struct ServiceRecord {
        uint256 mileage;
        string serviceDetails;
        uint256 timestamp;
    }

    struct OwnershipRecord {
        string ownerName;
        uint256 timestamp;
    }

    mapping(bytes32 => CarConstantData) public carConstantData;
    mapping(bytes32 => CarMutableData) public carMutableData;
    bytes32[] public registeredCars;

    event CarRegistered(bytes32 indexed carId, string vin, string initialOwner);
    event MileageUpdated(bytes32 indexed carId, uint256 mileage);
    event OwnershipTransferred(bytes32 indexed carId, string previousOwner, string newOwner);

    constructor() {
        contractOwner = msg.sender;
    }

    modifier onlyContractOwner() {
        require(msg.sender == contractOwner, "Not the contract owner");
        _;
    }

    function registerCar(
        bytes32 carId,
        string memory vin,
        string memory make,
        string memory model,
        uint16 year,
        string memory initialOwner
    ) public onlyContractOwner {
        require(bytes(carConstantData[carId].vin).length == 0, "Car already registered");
        
        carConstantData[carId] = CarConstantData({
            vin: vin,
            make: make,
            model: model,
            year: year
        });

        carMutableData[carId].currentOwnerName = initialOwner;
        carMutableData[carId].mileage = 0;
        carMutableData[carId].ownershipHistory.push(OwnershipRecord({
            ownerName: initialOwner,
            timestamp: block.timestamp
        }));

        registeredCars.push(carId);

        emit CarRegistered(carId, vin, initialOwner);
    }

    function updateMileage(bytes32 carId, uint256 mileage, string memory serviceDetails) public {
        require(bytes(carConstantData[carId].vin).length > 0, "Car not registered");
        carMutableData[carId].mileage = mileage;
        carMutableData[carId].serviceHistory.push(ServiceRecord({
            mileage: mileage,
            serviceDetails: serviceDetails,
            timestamp: block.timestamp
        }));
        emit MileageUpdated(carId, mileage);
    }

    function transferOwnership(bytes32 carId, string memory newOwner) public {
        require(bytes(carConstantData[carId].vin).length > 0, "Car not registered");
        string memory previousOwner = carMutableData[carId].currentOwnerName;
        carMutableData[carId].currentOwnerName = newOwner;
        carMutableData[carId].ownershipHistory.push(OwnershipRecord({
            ownerName: newOwner,
            timestamp: block.timestamp
        }));
        emit OwnershipTransferred(carId, previousOwner, newOwner);
    }

    function getCarDetails(bytes32 carId) public view returns (
        CarConstantData memory constantData,
        string memory currentOwner,
        uint256 mileage,
        ServiceRecord[] memory serviceHistory,
        OwnershipRecord[] memory ownershipHistory
    ) {
        require(bytes(carConstantData[carId].vin).length > 0, "Car not registered");
        constantData = carConstantData[carId];
        CarMutableData storage mutableData = carMutableData[carId];
        return (constantData, mutableData.currentOwnerName, mutableData.mileage, mutableData.serviceHistory, mutableData.ownershipHistory);
    }

    function findCarIdByVin(string memory vin) public view returns (bytes32) {
        for (uint i = 0; i < registeredCars.length; i++) {
            if (keccak256(bytes(carConstantData[registeredCars[i]].vin)) == keccak256(bytes(vin))) {
                return registeredCars[i];
            }
        }
        revert("Car with given VIN not found");
    }

    function carExists(bytes32 carId) public view returns (bool) {
        return bytes(carConstantData[carId].vin).length > 0;
    }
}