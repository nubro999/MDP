const { expect } = require("chai"); // Import the 'expect' assertion style from Chai for testing
const { ethers } = require("hardhat"); // Import ethers from Hardhat

describe("Hello", function () { // Define a test suite named "Hello"
  it("Should return the correct greeting", async function () { // Define a test case
    const Hello = await ethers.getContractFactory("Hello"); // Get the contract factory for the 'Hello' contract
    const hello = await Hello.deploy(); // Deploy a new instance of the 'Hello' contract
    expect(await hello.greet()).to.equal("Hello, world!"); // Assert that the greet() function returns the expected string
  });
});
