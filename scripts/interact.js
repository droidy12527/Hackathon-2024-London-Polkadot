async function main() {
    const [deployer, serviceCenter] = await ethers.getSigners();
    const carMileage = await ethers.getContractAt("CarMileage", "0x5FbDB2315678afecb367f032d93F642f64180aa3");
    console.log(deployer)
    console.log(serviceCenter)
    const carId = ethers.utils.id("VIN123456789");
    await carMileage.registerCar(carId);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });