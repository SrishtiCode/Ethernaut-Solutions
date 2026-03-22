   
// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

contract Ownable {
    address public owner;

    constructor() public {
        owner = msg.sender;
    }
}
contract AlienCodex is Ownable {
    bool public contact;
    bytes32[] public codex;

    modifier contacted() {
        assert(contact);
        _;
    }

    function makeContact() public {
        contact = true;//no access control
    }

    function record(bytes32 _content) public contacted {
        codex.push(_content);//normal push
    }

    function retract() public contacted {//underflow
        codex.length--;
    }

    function revise(uint256 i, bytes32 _content) public contacted {//become arbitrary storage write
        codex[i] = _content;
    }
}
