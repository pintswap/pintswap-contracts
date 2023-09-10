// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Common} from "./Common.test.sol";

contract Reverts is Common {
    function setUp() public {
        initializeMainnetFork();
        setUpBase();
    }

    function testRevertOnWrongBorrow() public {}
}
