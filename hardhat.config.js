require('@nomiclabs/hardhat-waffle')
require('solidity-coverage')
require('@openzeppelin/hardhat-upgrades')
require('@nomiclabs/hardhat-etherscan')

// Go to https://www.alchemyapi.io, sign up, create
// a new App in its dashboard, and replace "KEY" with its key
const ALCHEMY_API_KEY = '4XS91K28QRsUnHTSOpIN2VGXoyqLd_OO'

// Replace this private key with your Ropsten account private key
// To export your private key from Metamask, open Metamask and
// go to Account Details > Export Private Key
// Be aware of NEVER putting real Ether into testing accounts
const RINKEBY_PRIVATE_KEY =
	'72e9c0899556c6acaee2a00b26391599924c162beaf8ecacf19a3b8ca09f1c41'

module.exports = {
	solidity: '0.8.4',
	networks: {
		// rinkeby: {
		// 	url: `https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_API_KEY}`,
		// 	accounts: [`${RINKEBY_PRIVATE_KEY}`],
		// 	//	accounts: { mnemonic: mnemonic },
		// },
		polygon_mumbai: {
			url: `https://polygon-mumbai.g.alchemy.com/v2/6xRVVdMIpHl5vZYLnqDWrZsoLfjgSMmh`,
			accounts: [`${RINKEBY_PRIVATE_KEY}`],
		},
	},
	etherscan: {
		// Your API key for Etherscan
		// Obtain one at https://etherscan.io/
		//apiKey: 'MWS8T42Y8GF7B5MX86FS99GPNC55WYZFKA',
		apiKey: 'GMX83ND61X7G15B43EK2G3GTSIKPQFHG8Q', //polygon
	},
	// polyscan: {
	// 	apiKey: 'GMX83ND61X7G15B43EK2G3GTSIKPQFHG8Q',
	// },
	paths: {
		sources: './contracts',
		tests: './test',
		cache: './cache',
		artifacts: './artifacts',
	},
	mocha: {
		timeout: 20000,
	},
}

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task('accounts', 'Prints the list of accounts', async (taskArgs, hre) => {
	const accounts = await hre.ethers.getSigners()

	for (const account of accounts) {
		console.log(account.address)
	}
})

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
