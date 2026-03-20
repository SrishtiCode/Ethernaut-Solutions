// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "forge-std/Script.sol";
import "forge-std/console.sol";

interface MagicNum {
    function setSolver(address _solver) external;
}

contract MagicNumSolution is Script {

    function run() external {

        uint256 pk = vm.envUint("PRIVATE_KEY");

        MagicNum target =
            MagicNum(0xcBf15A62BE28eD11cbE9012A157EcF6029f2A952);

        vm.startBroadcast(pk);

        bytes memory bytecode =
            hex"600a600c600039600a6000f3602a60005260206000f3";

        address solver;

        assembly {
            solver := create(0, add(bytecode, 0x20), mload(bytecode))
        }

        target.setSolver(solver);

        console.log("Solver:", solver);

        vm.stopBroadcast();
    }
}