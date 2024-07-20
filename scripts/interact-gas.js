const { ethers } = require("hardhat");

async function estimateAndLogGas(tx, operation) {
  const gasEstimate = await tx.estimateGas();
  console.log(`Estimated gas for ${operation}: ${gasEstimate.toString()}`);
  return gasEstimate;
}

async function main() {
  const [deployer] = await ethers.getSigners();
  const carMileage = await ethers.getContractAt("CarMileage", "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512");

  const vin = "VIN123456789";
  const carId = ethers.utils.id(vin);

  try {
    const exists = await carMileage.carExists(carId);
    
    if (!exists) {
      console.log("Registering a new car...");
      const tx = await carMileage.populateTransaction.registerCar(carId, vin, "Toyota", "Corolla", 2022, "Initial Owner");
      const gasEstimate = await estimateAndLogGas(tx, "registering a car");
      await carMileage.registerCar(carId, vin, "Toyota", "Corolla", 2022, "Initial Owner", { gasLimit: gasEstimate.mul(12).div(10) });
    }

    console.log("Updating mileage...");
    let tx = await carMileage.populateTransaction.updateMileage(carId, 1000, "Initial service");
    let gasEstimate = await estimateAndLogGas(tx, "updating mileage");
    await carMileage.updateMileage(carId, 1000, "Initial service", { gasLimit: gasEstimate.mul(12).div(10) });

    console.log("Transferring ownership...");
    tx = await carMileage.populateTransaction.transferOwnership(carId, "New Owner");
    gasEstimate = await estimateAndLogGas(tx, "transferring ownership");
    await carMileage.transferOwnership(carId, "New Owner", { gasLimit: gasEstimate.mul(12).div(10) });

    // Get car details (view function, no gas cost)
    const [constantData, currentOwner, mileage, serviceHistory, ownershipHistory] = await carMileage.getCarDetails(carId);
    
    console.log("Car Details:");
    console.log("VIN:", constantData.vin);
    console.log("Current Owner:", currentOwner);
    console.log("Current Mileage:", mileage.toString());
    console.log("Service History:", serviceHistory.length, "records");
    console.log("Ownership History:", ownershipHistory.length, "records");

  } catch (error) {
    console.error("An error occurred:", error);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("An error occurred:", error);
    process.exit(1);
  });