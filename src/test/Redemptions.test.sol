// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Common} from "./Common.test.sol";

contract RedemptionTest is Common {
    function setUp() public {
        initializeMainnetFork();
        setUpBase();

        //TODO: this later
        vm.prank(tris.owner());
        tris.adminMint(
            address(100),
            uint(keccak256(abi.encodePacked(address(tris))))
        );
    }

    function testSablierStream() public {
        //TODO this
    }
}
