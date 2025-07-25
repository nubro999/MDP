// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract HelloWorld {
    // 상태 변수
    string public greeting;

    constructor(string memory name) {
        greeting = string(abi.encodePacked("Hello, ", name));
    }
    // 함수: 인사말을 반환
    function getGreeting() public view returns (string memory) {
        return greeting;
    }
}

contract Counter {
    // unsigned / 256-bit (32bytes) / Fixed size 256bits
    uint256 public count;

    // 현재 count 값을 get하는 함수 
    function get() public view returns (uint256) {
        return count;
    }

    // count 1씩 증가하는 함수 
    function inc() public {
        count += 1;
    }

    // count 1씩 감소하는 함수
    function dec() public {
        count -= 1;
    }
} 