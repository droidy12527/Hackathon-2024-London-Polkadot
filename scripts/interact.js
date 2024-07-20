const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  const carMileage = await ethers.getContractAt("CarMileage", "0x5FbDB2315678afecb367f032d93F642f64180aa3");

  const vin = "VIN123456789";

  console.log("Testing CarMileage contract...");

  try {
    // Register a car if it doesn't exist
    const carId = ethers.utils.id(vin);
    const exists = await carMileage.carExists(carId);
    
    if (!exists) {
      console.log("Car is not registered. Registering now...");
      await carMileage.registerCar(carId, vin, "Toyota", "Corolla", 2022, "Initial Owner");
      console.log("Car registered successfully.");
    } else {
      console.log("Car is already registered.");
    }

    // Find the car by VIN
    console.log("Finding car by VIN...");
    const foundCarId = await carMileage.findCarIdByVin(vin);
    console.log("Found car ID:", foundCarId);

    // Update mileage
    console.log("Updating mileage...");
    await carMileage.updateMileage(foundCarId, 1000, "Initial service");
    console.log("Mileage updated successfully.");

    // Transfer ownership
    console.log("Transferring ownership...");
    await carMileage.transferOwnership(foundCarId, "New Owner");
    console.log("Ownership transferred successfully.");

    // Get car details
    console.log("Fetching car details...");
    const [constantData, currentOwner, mileage, serviceHistory, ownershipHistory] = await carMileage.getCarDetails(foundCarId);
    
    console.log("Car Details:");
    console.log("VIN:", constantData.vin);
    console.log("Make:", constantData.make);
    console.log("Model:", constantData.model);
    console.log("Year:", constantData.year.toString());
    console.log("Current Owner:", currentOwner);
    console.log("Current Mileage:", mileage.toString());
    
    console.log("Service History:");
    serviceHistory.forEach((record, index) => {
      console.log(`  Record ${index + 1}:`);
      console.log(`    Mileage: ${record.mileage.toString()}`);
      console.log(`    Service Details: ${record.serviceDetails}`);
      console.log(`    Timestamp: ${new Date(record.timestamp.toNumber() * 1000).toLocaleString()}`);
    });

    console.log("Ownership History:");
    ownershipHistory.forEach((record, index) => {
      console.log(`  Owner ${index + 1}:`);
      console.log(`    Name: ${record.ownerName}`);
      console.log(`    Timestamp: ${new Date(record.timestamp.toNumber() * 1000).toLocaleString()}`);
    });

    console.log("Test interactions completed successfully.");
  } catch (error) {
    console.error("An error occurred:");
    console.error("Error message:", error.message);
    console.error("Error code:", error.code);
    console.error("Error data:", error.data);
    console.error("Full error:", error);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("An error occurred:", error);
    process.exit(1);
  });