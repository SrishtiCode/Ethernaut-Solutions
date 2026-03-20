// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level0.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Level0Solution is Script {

    function run() external {

        // deploy contract locally
        Level0 level0 = new Level0("ethernaut0");

        // read password
        string memory password = level0.password();
        console.log("Password:", password);

        // authenticate
        level0.authenticate(password);
    }
}