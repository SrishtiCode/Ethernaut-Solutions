// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../src/Token.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";


contract TokenSolution is Script {

    Token public tokenInstance = Token(0xFB9CaC6A3C935E2C3BbBF4BaAe2A84BC32a341E1);

    function run() external {

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        tokenInstance.transfer(address(0),21);
        console.log("My balance", tokenInstance.balanceOf(vm.envAddress("MY_ADDRESS")));
        vm.stopBroadcast();
    }
}
