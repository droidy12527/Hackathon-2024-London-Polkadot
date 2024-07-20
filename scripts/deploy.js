async function main() {
    const Box = await ethers.getContractFactory("CarMileage");
    const carMileage = await Box.deploy();
    await carMileage.deployed();
    console.log("CarMileage deployed to:", carMileage.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
  