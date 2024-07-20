// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CarMileage {
    address public contractOwner;

    struct CarConstantData {
        uint256 vin; // VIN as uint256
        string make; // Make as string
        string model; // Model as string
        uint16 year; // Year remains as uint16
    }

    struct CarMutableData {
        uint256 mileage;
        ServiceRecord[] serviceHistory;
        OwnershipRecord[] ownershipHistory;
    }

    struct ServiceRecord {
        uint256 mileage;
        uint256 timestamp; // Use uint256 for consistency
        string description; // Added description field
    }

    struct OwnershipRecord {
        string ownerName;
        uint256 timestamp; // Use uint256 for consistency
    }

    mapping(bytes32 => CarConstantData) public carConstantData;
    mapping(bytes32 => CarMutableData) public carMutableData;

    event CarRegistered(bytes32 indexed carId, uint256 vin, string make, string model, uint16 year, string initialOwner);
    event MileageUpdated(bytes32 indexed carId, uint256 mileage);
    event OwnershipTransferred(bytes32 indexed carId, string newOwner);

    constructor() {
        contractOwner = msg.sender;
    }

    modifier onlyContractOwner() {
        require(msg.sender == contractOwner, "Not the contract owner");
        _;
    }

    function registerCar(
        bytes32 carId,
        uint256 vin,
        string memory make,
        string memory model,
        uint16 year,
        string memory initialOwner
    ) public onlyContractOwner {
        require(carConstantData[carId].vin == 0, "Car already registered");

        carConstantData[carId] = CarConstantData({
            vin: vin,
            make: make,
            model: model,
            year: year
        });

        carMutableData[carId].mileage = 0;
        carMutableData[carId].ownershipHistory.push(OwnershipRecord({
            ownerName: initialOwner,
            timestamp: block.timestamp
        }));

        emit CarRegistered(carId, vin, make, model, year, initialOwner);
    }

    function updateMileage(bytes32 carId, uint256 mileage, string memory serviceDescription) public {
        require(carConstantData[carId].vin != 0, "Car not registered");

        carMutableData[carId].mileage = mileage;
        carMutableData[carId].serviceHistory.push(ServiceRecord({
            mileage: mileage,
            timestamp: block.timestamp,
            description: serviceDescription // Added description to service record
        }));

        emit MileageUpdated(carId, mileage);
    }

    function transferOwnership(bytes32 carId, string memory newOwner) public {
        require(carConstantData[carId].vin != 0, "Car not registered");

        carMutableData[carId].ownershipHistory.push(OwnershipRecord({
            ownerName: newOwner,
            timestamp: block.timestamp
        }));

        emit OwnershipTransferred(carId, newOwner);
    }

    function getCarDetails(bytes32 carId) public view returns (
        CarConstantData memory constantData,
        uint256 mileage,
        ServiceRecord[] memory serviceHistory,
        OwnershipRecord[] memory ownershipHistory
    ) {
        require(carConstantData[carId].vin != 0, "Car not registered");

        constantData = carConstantData[carId];
        CarMutableData storage mutableData = carMutableData[carId];
        return (constantData, mutableData.mileage, mutableData.serviceHistory, mutableData.ownershipHistory);
    }

    function carExists(bytes32 carId) public view returns (bool) {
        return carConstantData[carId].vin != 0;
    }
}
