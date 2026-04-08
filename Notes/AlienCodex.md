`forge script script/AlienCodexSolution.s.sol:AlienCodexSolution \
  --rpc-url http://127.0.0.1:8545 \
  --broadcast \
  -vvvv`
[⠊] Compiling...
No files changed, compilation skipped
Traces:
  [38530] AlienCodexSolution::run()   -> Total gas used by script -> 38530
    ├─ [0] VM::envUint("PRIVATE_KEY") [staticcall]
    │   └─ ← [Return] <env var value>
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] 0x06714e8c7641d35Bb3613af5E9e214C138707Bf5
    ├─ [0] VM::envUint("PRIVATE_KEY") [staticcall]
    │   └─ ← [Return] <env var value>
    ├─ [0] VM::startBroadcast(<pk>)
    │   └─ ← [Return]
    ├─ [5216] 0x891FAb90Df53f532dBE1F38Fd28E5bd3f274E745::makeContact()
    │   └─ ← [Stop]
    ├─ [22625] 0x891FAb90Df53f532dBE1F38Fd28E5bd3f274E745::retract()
    │   └─ ← [Stop]
    ├─ [672] 0x891FAb90Df53f532dBE1F38Fd28E5bd3f274E745::revise(35707666377435648211887908874984608119992236509074197713628505308453184860938 [3.57e76], 0x00000000000000000000000006714e8c7641d35bb3613af5e9e214c138707bf5)
    │   └─ ← [Stop]
    ├─ [0] VM::stopBroadcast()
    │   └─ ← [Return]
    └─ ← [Stop]


Script ran successfully.

## Setting up 1 EVM.
==========================
Simulated On-chain Traces:

  [5216] 0x891FAb90Df53f532dBE1F38Fd28E5bd3f274E745::makeContact()
    └─ ← [Stop]

  [24625] 0x891FAb90Df53f532dBE1F38Fd28E5bd3f274E745::retract()
    └─ ← [Stop]

  [7472] 0x891FAb90Df53f532dBE1F38Fd28E5bd3f274E745::revise(35707666377435648211887908874984608119992236509074197713628505308453184860938 [3.57e76], 0x00000000000000000000000006714e8c7641d35bb3613af5e9e214c138707bf5)
    └─ ← [Stop]


==========================

Chain 11155111

Estimated gas price: 7.923830192 gwei

Estimated total gas used for script: 143731

Estimated amount required: 0.001138900037326352 ETH

==========================

##### sepolia
✅  [Success] Hash: 0xf2c10587ade321c1aedee29e8b833596d5234a8db5e4bfae2e8a821212e395b2
Block: 10617536
Paid: 0.000154999967908975 ETH (45689 gas * 3.392500775 gwei)


##### sepolia
✅  [Success] Hash: 0xfab578f388b5bc2b1a5607506394bfaa505942780f9a98aef9c772c2d0f38a6a
Block: 10617536
Paid: 0.0000997530927881 ETH (29404 gas * 3.392500775 gwei)


##### sepolia
✅  [Success] Hash: 0x76f4676e44ababd7054e32235c8d85746629dcf6085a9e960d86c0f2a094ffce
Block: 10617535
Paid: 0.00010187482881168 ETH (26280 gas * 3.876515556 gwei)

✅ Sequence #1 on sepolia | Total Paid: 0.000356627889508755 ETH (101373 gas * avg 3.553839035 gwei)
                                                                                                

==========================

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.


`forge inspect src/AlienCodex.sol:AlienCodex methodIdentifiers`
╭-------------------------+------------╮
| Method                  | Identifier |
+======================================+
| codex(uint256)          | 94bd7569   |
|-------------------------+------------|
| contact()               | 33a8c45a   |
|-------------------------+------------|
| makeContact()           | 328b52cb   |
|-------------------------+------------|
| owner()                 | 8da5cb5b   |
|-------------------------+------------|
| record(bytes32)         | b5c645bd   |
|-------------------------+------------|
| retract()               | 47f57b32   |
|-------------------------+------------|
| revise(uint256,bytes32) | 0339f300   |
╰-------------------------+------------╯

`forge inspect src/AlienCodex.sol:AlienCodex storage`
╭---------+-----------+------+--------+-------+-------------------------------╮
| Name    | Type      | Slot | Offset | Bytes | Contract                      |
+=============================================================================+
| owner   | address   | 0    | 0      | 20    | src/AlienCodex.sol:AlienCodex |
|---------+-----------+------+--------+-------+-------------------------------|
| contact | bool      | 0    | 20     | 1     | src/AlienCodex.sol:AlienCodex |
|---------+-----------+------+--------+-------+-------------------------------|
| codex   | bytes32[] | 1    | 0      | 32    | src/AlienCodex.sol:AlienCodex |
╰---------+-----------+------+--------+-------+-------------------------------╯

`forge inspect src/AlienCodex.sol:AlienCodex abi`
╭----------+---------------------------------------+------------╮
| Type     | Signature                             | Selector   |
+===============================================================+
| function | codex(uint256) view returns (bytes32) | 0x94bd7569 |
|----------+---------------------------------------+------------|
| function | contact() view returns (bool)         | 0x33a8c45a |
|----------+---------------------------------------+------------|
| function | makeContact() nonpayable              | 0x328b52cb |
|----------+---------------------------------------+------------|
| function | owner() view returns (address)        | 0x8da5cb5b |
|----------+---------------------------------------+------------|
| function | record(bytes32) nonpayable            | 0xb5c645bd |
|----------+---------------------------------------+------------|
| function | retract() nonpayable                  | 0x47f57b32 |
|----------+---------------------------------------+------------|
| function | revise(uint256,bytes32) nonpayable    | 0x0339f300 |
╰----------+---------------------------------------+------------╯

`forge inspect src/AlienCodex.sol:AlienCodex deployedBytecode`
0x608060405234801561001057600080fd5b506004361061007d5760003560e01c806347f57b321161005b57806347f57b32146100e65780638da5cb5b146100f057806394bd75691461013a578063b5c645bd1461017c5761007d565b80630339f30014610082578063328b52cb146100ba57806333a8c45a146100c4575b600080fd5b6100b86004803603604081101561009857600080fd5b8101908080359060200190929190803590602001909291905050506101aa565b005b6100c26101e0565b005b6100cc6101fd565b604051808215151515815260200191505060405180910390f35b6100ee610210565b005b6100f861023e565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b6101666004803603602081101561015057600080fd5b8101908080359060200190929190505050610263565b6040518082815260200191505060405180910390f35b6101a86004803603602081101561019257600080fd5b8101908080359060200190929190505050610284565b005b600060149054906101000a900460ff166101c057fe5b80600183815481106101ce57fe5b90600052602060002001819055505050565b6001600060146101000a81548160ff021916908315150217905550565b600060149054906101000a900460ff1681565b600060149054906101000a900460ff1661022657fe5b600180548091906001900361023b91906102c9565b50565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b6001818154811061027057fe5b906000526020600020016000915090505481565b600060149054906101000a900460ff1661029a57fe5b600181908060018154018082558091505090600182039060005260206000200160009091929091909150555050565b8154818355818111156102f0578183600052602060002091820191016102ef91906102f5565b5b505050565b61031791905b808211156103135760008160009055506001016102fb565b5090565b9056fea265627a7a72315820741840daf62637096dd877e368ca70d7749b6fc45fe94a4337d07cb66d5dab3e64736f6c63430005110032
