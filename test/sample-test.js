const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Staking", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Staking = await ethers.getContractFactory("Staking");
    const staking = await Staking.deploy("");
    await staking.deployed();
    // wait until the transaction is mined
  });
});
