// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Common} from "./Common.test.sol";
import {console2} from "forge-std/console2.sol";

contract PintDeployerTest is Common {
    function setUp() public {
        initializeMainnetFork();
        setUpBase();
    }

    function testBasicRun() public {
        assertEq(pint.decimals(), 18);
        assertEq(pint.name(), "PINT");
        assertEq(pint.symbol(), "PINT");
        bytes32 hash;
        address ve = address(vePint);
        assembly {
            hash := extcodehash(ve)
        }
        console2.log(uint256(hash));
    }
}
