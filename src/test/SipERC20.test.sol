// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Common} from "./Common.test.sol";

contract SipERC20Test is Common {
    function setUp() public {
        initializeMainnetFork();
        setUpBase();
    }

    function testDeposit() public {}

    function testShares() public {}
}
