// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Script, console2} from "forge-std/Script.sol";
import {PINTDeploy} from "../src/PINTDeployer.sol";

contract Deployments is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);
        new PINTDeploy(vm.addr(deployerPrivateKey));
        vm.stopBroadcast();
    }
}
