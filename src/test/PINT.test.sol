// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Common} from "./Common.test.sol";
import "forge-std/console2.sol";

contract PintTest is Common {
    function setUp() public {
        initializeMainnetFork();
        setUpBase();
    }

    function testPintLimits() public {
        vm.startPrank(treasury);
        pint.enableTrading();
        pint.transfer(address(100), pint.maxTransactionAmount());
        vm.startPrank(address(100));
        console2.log(pint.maxWallet() > pint.maxTransactionAmount());
        vm.expectRevert(bytes("Max wallet exceeded"));
        pint.transfer(address(200), pint.maxTransactionAmount() + 2);
        vm.startPrank(treasury);
        pint.transfer(address(100), 1 ether);
        vm.startPrank(address(100));

        // vm.expectRevert(bytes("Max wallet exceeded"));
        pint.transfer(address(200), 1 ether);
    }

    function testPintFees() public {}

    function testPintTrading() public {}

    function testBlacklist() public {}
}
