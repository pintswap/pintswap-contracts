// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Common} from "./Common.test.sol";

contract PintTest is Common {
    function setUp() public {
        initializeMainnetFork();
        setUpBase();
    }

    function testPintLimits() public {}

    function testPintFees() public {}

    function testPintTrading() public {}

    function testBlacklist() public {}
}
