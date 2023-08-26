// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Common} from "./Common.test.sol";

contract Reverts is Common {
    function setUp() public {
        initializeMainnetFork();
        setUpBase();
        //send pint to address(100)
        vm.expectRevert(bytes("Ownable: caller is not the owner"));
        pint.enableTrading();
        vm.startPrank(treasury);
        pint.transfer(address(100), 1 ether);
        vm.stopPrank();
        vm.startPrank(address(100));
        vm.expectRevert(bytes("Not authorized to transfer pre-migration."));
        pint.transfer(address(200), 1 ether);
        vm.stopPrank();
        vm.startPrank(treasury);
        pint.enableTrading();
        opps.mint(address(100), 0);
        vm.stopPrank();
        vm.startPrank(address(100));
        pint.approve(address(vePint), ~uint256(1));
        vm.stopPrank();
    }

    function testRevertOnWrongBorrow() public {
        vm.expectRevert(bytes("ERC721Enumerable: owner index out of bounds"));
        vePint.finna(1 ether);
        vm.expectRevert(bytes("ERC721Enumerable: owner index out of bounds"));
        vePint.push(1 ether, 0);

        vm.startPrank(address(100));
        vePint.deposit(1 ether, address(100));

        vePint.finna(1 ether);
        vm.expectRevert(bytes("ERC20: transfer amount exceeds balance"));
        vePint.finna(1 ether);
    }
}
