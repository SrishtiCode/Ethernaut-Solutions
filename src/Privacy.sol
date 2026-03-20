// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Privacy {
    bool public locked = true;
    uint256 public ID = block.timestamp;
    uint8 private flattening = 10;
    uint8 private denomination = 255;
    uint16 private awkwardness = uint16(block.timestamp);
    bytes32[3] private data;

    constructor(bytes32[3] memory _data) {
        data = _data;
    }

    function unlock(bytes16 _key) public {
        require(_key == bytes16(data[2]));
        locked = false;
    }

    /*
    A bunch of super advanced solidity algorithms...

      ,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`
      .,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,
      *.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^         ,---/V\
      `*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.    ~|__(o.o)
      ^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'  UU  UU
    */
}

/*cast send 0x677760921814650Db396B529f5f6C60dD7b157F6 \
"unlock(bytes16)" 0x41ba4ee62a50ebbfb117a474b063fc48 \
--rpc-url $RPC_URL \
--private-key $PRIVATE_KEY


blockHash            0xb6202bcc677364a11ba7e24004dcb35090bf76a8dce36b1f960969bb345117cf
blockNumber          10458720
contractAddress      
cumulativeGasUsed    7369318
effectiveGasPrice    1000010
from                 0x06714e8c7641d35Bb3613af5E9e214C138707Bf5
gasUsed              24025
logs                 []
logsBloom            0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
root                 
status               1 (success)
transactionHash      0x93572e785cb44d137bf5e52b1f957145e7265080bc7af96e28e16bc8aab6d168
transactionIndex     67
type                 2
blobGasPrice         
blobGasUsed          
to                   0x677760921814650Db396B529f5f6C60dD7b157F6 */