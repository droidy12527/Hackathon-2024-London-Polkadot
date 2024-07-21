require("@nomiclabs/hardhat-waffle");

module.exports = {
  solidity: "0.8.0",
  networks: {
    hardhat: {
      chainId: 1337,
    },
    moonbase: {
      url: "https://rpc.api.moonbase.moonbeam.network",
      chainId: 1287, // Moonbase Alpha
      accounts: ["d3f0b70a39e960b0e2fe11eab57d75d0b04b240d508e0673946c4d83ca84b407"]
    },
  },
};
