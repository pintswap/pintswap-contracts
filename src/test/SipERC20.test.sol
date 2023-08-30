// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Common} from "./Common.test.sol";
import {console2} from "forge-std/console2.sol";

contract SipERC20Test is Common {
    function setUp() public {
        initializeMainnetFork();
        setUpBase();
        vm.startPrank(treasury);
        pint.transfer(address(200), 1 ether);
        pint.enableTrading();
        opps.mint(address(100), 0);
        opps.mint(address(200), 1);
        vm.startPrank(address(100));
        pint.approve(address(vePint), ~uint256(1));
        vm.startPrank(address(200));
        pint.approve(address(vePint), ~uint256(1));
        vm.startPrank(address(100));
    }

    function testDeposit() public {
        vePint.deposit(1 ether, address(100));
        vm.startPrank(address(200));

        vePint.deposit(1 ether, address(200));

        vm.startPrank(address(100));

        vePint.finna((1 ether) / 2);

        console2.log(vePint.convertToShares(vePint.totalAssets()));
        console2.log(pint.balanceOf(address(100)));
    }

    function testShares() public {}
}
