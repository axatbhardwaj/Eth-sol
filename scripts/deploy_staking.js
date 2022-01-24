// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.

async function main() {
  const {ethers} = require('hardhat')
	const Staking = await ethers.getContractFactory('Staking')
	console.log('Deploying Staking...')
	const bank = await Staking.deploy("0xf6d02FB0AE2779683cdCc87Af7A5941cA1918172")
	await bank.deployed()
	console.log('Staking deployed to:', bank.address)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
