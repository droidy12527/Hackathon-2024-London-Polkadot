// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CarMileage {

    struct Car {
        address owner;
        uint256 mileage;
    }

    mapping(bytes32 => Car) private cars;
    mapping(address => bool) private serviceCenters;
    address private admin;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier onlyServiceCenter() {
        require(serviceCenters[msg.sender], "Only service centers can perform this action");
        _;
    }

    event CarRegistered(bytes32 carId, address owner);
    event OwnershipTransferred(bytes32 carId, address newOwner);
    event MileageUpdated(bytes32 carId, uint256 newMileage, string serviceDetails);
    event ServiceCenterAdded(address serviceCenter);

    constructor() {
        admin = msg.sender;
    }

    function registerCar(bytes32 carId) public {
        require(cars[carId].owner == address(0), "Car already registered");

        cars[carId] = Car({
            owner: msg.sender,
            mileage: 0
        });

        emit CarRegistered(carId, msg.sender);
    }

}
