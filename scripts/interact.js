const { ethers } = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();
    const carMileage = await ethers.getContractAt("CarMileage", "0x73126e130F8b8e428C04E9F8f26c4b4E7a130758");

    // Convert the VIN and make/model to the new formats
    const numberplate = "MMST12sdXY";
    const vin = ethers.BigNumber.from("123456789"); // VIN as uint256

    // Enum values for make and model (assumed values; adjust as per your enum definitions)
    const Make = {
        Toyota: 1,
        Honda: 2,
        Ford: 3,
        BMW: 4
    };
    const Model = {
        Corolla: 1,
        Civic: 2,
        Mustang: 3,
        X5: 4
    };

    console.log("Testing CarMileage contract...");

    try {
        // Register a car if it doesn't exist
        const carId = ethers.utils.id(numberplate);
        const exists = await carMileage.carExists(carId);

        if (!exists) {
            console.log("Car is not registered. Registering now...");
            await carMileage.registerCar(
                carId,
                vin,
                Make.Toyota,   // Enum value for make
                Model.Corolla, // Enum value for model
                2022,
                "Initial Owner"
            );
            console.log("Car registered successfully.");
        } else {
            console.log("Car is already registered.");
        }

        // Update mileage
        console.log("Updating mileage...");
        await carMileage.updateMileage(
            carId,
            1000
        );
        console.log("Mileage updated successfully.");

        // Transfer ownership
        console.log("Transferring ownership...");
        await carMileage.transferOwnership(
            carId,
            "New Owner"
        );
        console.log("Ownership transferred successfully.");

        // Get car details
        console.log("Fetching car details...");
        const [constantData, mileage, serviceHistory, ownershipHistory] = await carMileage.getCarDetails(carId);

        console.log("Car Details:");
        console.log("VIN:", constantData.vin.toString());
        console.log("Make:", Object.keys(Make).find(key => Make[key] === constantData.make));
        console.log("Model:", Object.keys(Model).find(key => Model[key] === constantData.model));
        console.log("Year:", constantData.year.toString());
        console.log("Current Mileage:", mileage.toString());

        console.log("Service History:");
        serviceHistory.forEach((record, index) => {
            console.log(`  Record ${index + 1}:`);
            console.log(`    Mileage: ${record.mileage.toString()}`);
            console.log(`    Timestamp: ${new Date(record.timestamp * 1000).toLocaleString()}`);
        });

        console.log("Ownership History:");
        ownershipHistory.forEach((record, index) => {
            console.log(`  Owner ${index + 1}:`);
            console.log(`    Name: ${record.ownerName}`);
            console.log(`    Timestamp: ${new Date(record.timestamp * 1000).toLocaleString()}`);
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
