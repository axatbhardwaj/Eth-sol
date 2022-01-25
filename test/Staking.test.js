const chai = require('chai');
const { expect } = chai;
const { ethers } = require("hardhat");
const { solidity } = require("ethereum-waffle");
chai.use(solidity);
let Staking;
const amnt0 = (10 *10 ** 18).toLocaleString('Fullwide',{useGrouping:false,});
const amnt1 = (100 * 10 ** 18).toLocaleString('Fullwide', { useGrouping: false,});
const amnt2 = (1000 * 10 ** 18).toLocaleString('Fullwide', { useGrouping: false,});
describe('Staking Contract', () => {
  beforeEach(async () => {
    const token = await ethers.getContractFactory("MockToken");
    const MockToken = await token.deploy('TST', 'T1');
    const tokenaddress = MockToken.address;
    [owner, addr, addr1, addr2, addr3, addr4, addr5] = await ethers.getSigners();
    Staking = await ethers.getContractFactory("Staking");
    const staking = await Staking.deploy(tokenaddress);
    await staking.deployed();
    await MockToken.transfer(Staking.address, amnt0);
  }
  )
  describe('Staking', () => {
    it('should stake', async () => {
      await MockToken.transfer(addr, amnt2);
      let bal0 = await MockToken.balanceOf(addr);
      expect(bal0.toString()).to.equal(amnt2.toString()); console.log("Balance transfer was successful");
      await Staking.stake(amnt1, { from: addr });
      const Unstakeamnt = await Staking.viewUnstakeAmount(addr);
      expect(Unstakeamnt.toString()).to.equal(amnt1.toString()); console.log("Unstake amount is correct");
    });
  })
})


