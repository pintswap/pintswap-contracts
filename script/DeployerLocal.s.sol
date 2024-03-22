// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Script, console2} from "forge-std/Script.sol";
import {PINTDeployer} from "../src/PINTDeployer.sol";

contract DeploymentsLocal is Script {
    address constant owner = 0x94e1f974E82fda48cC37F6144F5a921c9Bca659C;

    event Deploy(address addr);

    function run() public {
        vm.deal(owner, 20 ether);
        emit Deploy(address(new PINTDeployer()));
    }
}
