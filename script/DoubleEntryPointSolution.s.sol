// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IForta {
    function setDetectionBot(address detectionBotAddress) external;
    function raiseAlert(address user) external;
}

interface IDoubleEntryPoint {
    function cryptoVault() external view returns (address);
    function forta() external view returns (address);
}

contract DetectionBot {

    address public vault;
    IForta public forta;

    constructor(address _vault, address _forta) {
        vault = _vault;
        forta = IForta(_forta);
    }

    function handleTransaction(address user, bytes calldata msgData) external {
        (, , address origSender) = abi.decode(msgData[4:], (address, uint256, address));

        if (origSender == vault) {
            forta.raiseAlert(user);
        }
    }
}

contract DoubleEntryPointSolution is Script {

    function run() external {
        address target = 0xYOUR_INSTANCE;

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        IDoubleEntryPoint det = IDoubleEntryPoint(target);

        address vault = det.cryptoVault();
        address fortaAddr = det.forta();

        // 1. Deploy detection bot
        DetectionBot bot = new DetectionBot(vault, fortaAddr);

        // 2. Register bot
        IForta(fortaAddr).setDetectionBot(address(bot));

        vm.stopBroadcast();
    }
}