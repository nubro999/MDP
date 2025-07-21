pragma solidity ^0.8.0;
// SPDX-License-Identifier: MIT

contract Hello {
    string public greeting;
    
    // Function to return the greeting
    function greet() public pure returns (string memory) {
        return "Hello, world!";
    }
}