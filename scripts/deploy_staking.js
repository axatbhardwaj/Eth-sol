// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.

async function main() {
  const {ethers} = require('hardhat')
	const Staking = await ethers.getContractFactory('Staking')
	console.log('Deploying Staking...')
	const bank = await Staking.deploy("0xdc4b03A13b747b8DCffECE8791a096bE570f0598")
	await bank.deployed()
	console.log('Staking deployed to:', bank.address)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
