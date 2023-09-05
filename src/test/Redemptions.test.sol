// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Common} from "./Common.test.sol";

contract RedemptionTest is Common {
    function setUp() {
        initializeMainnetFork();
        setUpBase();
        vm.prank(treasury);

        //TODO: this later
        vm.prank(address(100));
    }
}
