const hre = require("hardhat");
const abi = require("../artifacts/contracts/ChainBattles.sol/ChainBottles.json");
///home/sakal/ChainBattled/artifacts/contracts/ChainBattles.sol/ChainBottles.json

async function main() {
    // const contractAddress="0x41a614f841284932a93f133315f7fC14761431F9";
    // const contractABI = abi.abi;

    // const provider = new hre.ethers.providers.AlchemyProvider("mumbai", "g3IZYxQ4Hw3QsoXQgCMNjwn4ZuVO0ncC");
    // const signer = new hre.ethers.Wallet(process.env.PRIVATE_KEY, provider);

    const nftContractFactory = await hre.ethers.getContractFactory("ChainBottles");
    const contract = await nftContractFactory.attach(
        "0x41a614f841284932a93f133315f7fC14761431F9" // The deployed contract address
    );
    // const contract = new hre.ethers.Contract(contractAddress, contractABI, signer);


    try {
        await contract.train("1");

        console.log("train successfully");
    }
    catch (err) {
        console.log(err);
    }
    
}

main();