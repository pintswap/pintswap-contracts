// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Common} from "./Common.test.sol";
import "forge-std/console2.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

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
        pint.transfer(
            address(100),
            1 ether - pint.balanceOf(address(100)) + 10000000 ether
        );
        vm.startPrank(address(100));
        address[] memory path = new address[](2);
        path[0] = address(pint);
        path[1] = address(weth);
        uint balanceBefore = pint.balanceOf(address(pint));
        router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            1000000 ether,
            1,
            path,
            address(100),
            block.timestamp + 200
        );
        require(
            pint.balanceOf(address(pint)) - balanceBefore > 0,
            "fees not deducted"
        );
        pint.transfer(
            address(pint),
            pint.swapTokensAtAmount() - pint.balanceOf(address(pint))
        );
        uint treasuryBalanceBefore = treasury.balance;
        pint.transfer(address(300), 1 ether);
        require(treasury.balance - treasuryBalanceBefore >= 0, "!swap");
    }

    function testBlacklist() public {
        vm.startPrank(treasury);
        pint.blacklist(address(100));
        vm.startPrank(address(100));
        vm.expectRevert(bytes("Sender blacklisted"));
        pint.transfer(address(200), 1 ether);
    }
}
