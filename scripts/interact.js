const { ethers } = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();
    const carMileage = await ethers.getContractAt("CarMileage", "0xC9E2bBa3240Ee228FE2e4a55a5A496B488A5B688");

    // Car details
    const numberplate = "test123";
    const vin = ethers.BigNumber.from("123456789"); // VIN as uint256

    // Use strings for make and model
    const make = "Toyota";
    const model = "Corolla";

    console.log("Testing CarMileage contract...");

    try {
        // Register a car if it doesn't exist
        const carId = ethers.utils.id(numberplate);
        // console.log(carId);
        // const carId = "ecd71870d1963316a97e3ac3408c9835ad8cf0f3c1bc703527c30265534f75ae";
        const exists = await carMileage.carExists(carId);

        if (!exists) {
            console.log("Car is not registered. Registering now...");
            await carMileage.registerCar(
                carId,
                vin,
                make,       // Make as string
                model,      // Model as string
                2022,
                "Initial Owner"
            );
            console.log("Car registered successfully.");
        } else {
            console.log("Car is already registered.");
        }

        // Update mileage with a description
        console.log("Updating mileage...");
        await carMileage.updateMileage(
            carId,
            1000,
            "Oil change and tire rotation" // Service description
        );
        console.log("Mileage updated successfully.");

        // Transfer ownership
        console.log("Transferring ownership...");
        await carMileage.transferOwnership(
            carId,
            "New Owner"
        );
        console.log("Ownership transferred successfully.");

        // Report an accident
        console.log("Reporting an accident...");
        const partsChanged = ["Front bumper", "Headlight", "Hood"];
        await carMileage.reportAccident(
            carId,
            "Rear-end collision",
            partsChanged
        );
        console.log("Accident reported successfully.");

        // Get car details
        console.log("Fetching car details...");
        const [constantData, mileage, serviceHistory, ownershipHistory, accidentHistory] = await carMileage.getCarDetails(carId);

        console.log("Car Details:");
        console.log("VIN:", constantData.vin.toString());
        console.log("Make:", constantData.make);
        console.log("Model:", constantData.model);
        console.log("Year:", constantData.year.toString());
        console.log("Current Mileage:", mileage.toString());

        const blockNumber = await ethers.provider.getBlockNumber();
        console.log("Current Block Number:", blockNumber);

        console.log("Service History:");
        serviceHistory.forEach((record, index) => {
            console.log(`  Record ${index + 1}:`);
            console.log(`    Mileage: ${record.mileage.toString()}`);
            console.log(`    Timestamp: ${new Date(record.timestamp * 1000).toLocaleString()}`);
            console.log(`    Description: ${record.description}`); // Added description field
        });

        console.log("Ownership History:");
        ownershipHistory.forEach((record, index) => {
            console.log(`  Owner ${index + 1}:`);
            console.log(`    Name: ${record.ownerName}`);
            console.log(`    Timestamp: ${new Date(record.timestamp * 1000).toLocaleString()}`);
        });

        console.log("Accident History:");
        accidentHistory.forEach((record, index) => {
            console.log(`  Accident ${index + 1}:`);
            console.log(`    Timestamp: ${new Date(record.timestamp * 1000).toLocaleString()}`);
            console.log(`    Description: ${record.description}`);
            console.log(`    Parts Changed: ${record.partsChanged.join(", ")}`);
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
