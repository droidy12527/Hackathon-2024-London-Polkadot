# Hackathon-2024-London-Polkadot

CarNet leverages Polkadot's Moonbeam parachain as its core blockchain infrastructure. We chose Moonbeam for its Ethereum compatibility, allowing us to write and deploy Solidity smart contracts seamlessly. This compatibility enabled us to create efficient contracts for storing and retrieving vehicle data while benefiting from Polkadot's security and scalability.

We implemented a dual storage system in our smart contracts to optimize gas costs. Immutable data (like VIN and manufacturing details) is stored permanently, while mutable data (such as mileage and service records) can be updated efficiently. This approach is uniquely suited to Moonbeam's gas fee structure and Polkadot's block space efficiency.

The app's frontend is built with Flutter, ensuring cross-platform compatibility. We integrated OCR technology for license plate scanning, which interacts with our Moonbeam-based backend through Web3 APIs.

Polkadot's interoperability features open up future possibilities for cross-chain data sharing, potentially allowing CarNet to interact with other automotive-related parachains or external blockchains.

Moonbeam's connection to the broader Polkadot network ensures that CarNet can handle increased transaction volumes as it scales, while benefiting from Polkadot's shared security model. This robust infrastructure is crucial for maintaining the integrity and availability of vehicle history data.
