// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Script, console2} from "forge-std/Script.sol";
import {PINTDeploy} from "../src/PINTDeployer.sol";

contract DeploymentsLocal is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(0x94e1f974E82fda48cC37F6144F5a921c9Bca659C);
        vm.deal(0x94e1f974E82fda48cC37F6144F5a921c9Bca659C, 20 ether);
        new PINTDeploy(vm.addr(deployerPrivateKey));
        vm.stopBroadcast();
    }
}
