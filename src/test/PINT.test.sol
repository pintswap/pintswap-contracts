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
        uint maxTx = pint.maxTransactionAmount();
        uint maxWallet = pint.maxWallet();
        vm.startPrank(treasury);
        pint.enableTrading();
        pint.transfer(address(100), maxWallet);
        vm.startPrank(address(100));
        vm.expectRevert(bytes("Max wallet exceeded"));
        pint.transfer(address(200), maxWallet + 2);
        vm.startPrank(treasury);
        pint.transfer(address(100), 1 ether);
        vm.startPrank(address(100));

        // vm.expectRevert(bytes("Max wallet exceeded"));
        pint.transfer(address(200), 1 ether);
    }

    function testPintFees() public {
        uint maxWallet = pint.maxWallet();
        vm.startPrank(treasury);
        pint.enableTrading();
        pint.setAutomatedMarketMakerPair(address(200), true);
        vm.startPrank(address(100));
        pint.transfer(address(200), 1 ether);
        console2.log(pint.balanceOf(address(200)));
    }

    function testPintTrading() public {}

    function testBlacklist() public {}
}
