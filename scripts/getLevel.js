const hre = require("hardhat");
///home/sakal/ChainBattled/artifacts/contracts/ChainBattles.sol/ChainBottles.json

async function main() {
    // const contractAddress="0x41a614f841284932a93f133315f7fC14761431F9";
    // const contractABI = abi.abi;

    // const provider = new hre.ethers.providers.AlchemyProvider("mumbai", "g3IZYxQ4Hw3QsoXQgCMNjwn4ZuVO0ncC");
    // const signer = new hre.ethers.Wallet(process.env.PRIVATE_KEY, provider);

    const nftContractFactory = await hre.ethers.getContractFactory("ChainBottles");
    const contract = await nftContractFactory.attach(
        "0x4b21f4aBff8bf825ad300FCfe30a15443E99D83C" // The deployed contract address
    );
    // const contract = new hre.ethers.Contract(contractAddress, contractABI, signer);


    try {
        const level = await contract.getLevels("1");
        console.log("Token Level is ", level);
        console.log("train successfully");
    }
    catch (err) {
        console.log(err);
    }
    
}

main();