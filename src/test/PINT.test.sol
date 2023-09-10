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
        vm.startPrank(treasury);
        pint.enableTrading();
        pint.setAutomatedMarketMakerPair(address(200), true);
        vm.startPrank(address(100));
        pint.transfer(address(200), 1 ether);
        assertEq(
            pint.balanceOf(address(200)),
            (1 ether) - (((1 ether) * 5) / (100))
        );
        assertEq(pint.balanceOf(address(pint)), ((1 ether) * 5) / 100);
        vm.startPrank(treasury);
        pint.transfer(address(100), 1 ether - pint.balanceOf(address(100)));
        vm.startPrank(address(100));
        address[] memory path = new address[](2);
        path[0] = address(pint);
        path[1] = address(weth);
        console2.log("swapping");
        router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            1 ether,
            1,
            path,
            address(100),
            block.timestamp + 200
        );
        console2.log(pint.balanceOf(address(vePint)));
    }

    function testBlacklist() public {
        vm.startPrank(treasury);
        pint.blacklist(address(100));
        vm.startPrank(address(100));
        vm.expectRevert(bytes("Sender blacklisted"));
        pint.transfer(address(200), 1 ether);
    }
}
