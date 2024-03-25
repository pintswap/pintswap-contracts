// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Script, console2} from "forge-std/Script.sol";
import {PINT} from "../src/PINT.sol"; 
import {PINTV2} from "../src/PINTV2.sol"; 

contract DeploySepolia is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        PINT pint = new PINT(address(0), address(0)); 
        PINTV2 pintV2 = new PINTV2(address(pint));  

        vm.stopBroadcast();
    }
}



