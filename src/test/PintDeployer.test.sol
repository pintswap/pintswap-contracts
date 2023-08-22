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
        assertEq(bytes(vePint.symbol()), bytes("sipPINT"));
        assertEq(vePint.symbol(), "sipPINT");
    }
}
