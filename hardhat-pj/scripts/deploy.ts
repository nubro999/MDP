async function main() { // Defines an asynchronous function named 'main'
  const Hello = await ethers.getContractFactory("Hello"); // Gets the contract factory for 'Hello'
  const hello = await Hello.deploy(); // Deploys the contract and returns a contract instance
  console.log("Hello deployed to:", hello.target); // Logs the deployed contract's address
}

main() // Calls the 'main' function
  .then(() => process.exit(0)) // If successful, exits the process with code 0 (success)
  .catch(error => { // If an error occurs,
    console.error(error); // logs the error,
    process.exit(1); // and exits the process with code 1 (failure)
  });
