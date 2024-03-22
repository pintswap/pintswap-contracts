// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Common} from "./Common.test.sol";
import {Math} from "openzeppelin-contracts/contracts/utils/math/Math.sol";
import "forge-std/console2.sol";
import {ISablierV2LockupLinear} from "v2-core/src/interfaces/ISablierV2LockupLinear.sol";

contract RedemptionTest is Common {
    uint256[] tokenIds;

    ISablierV2LockupLinear constant lockupLinear = ISablierV2LockupLinear(0xB10daee1FCF62243aE27776D7a92D39dC8740f95);
    uint256 constant REDEMPTION = 1e24;

    function setUp() public {
        initializeMainnetFork();
        setUpBase();

        vm.prank(treasury);
        pint.enableTrading();

        for (uint256 i = 0; i < 10; i++) {
            tokenIds.push(
                uint256(keccak256(abi.encodePacked(address(tris), (i * 1000), address(uint160((1000 + (i * 1000)))))))
            );
            vm.prank(tris.owner());
            tris.adminMint(address(uint160((1000 + (i * 1000)))), tokenIds[i]);
            vm.prank(wock.owner());
            wock.mint(address(uint160((1000 + (i * 1000)))), tokenIds[i]);
        }
    }

    function testTRISRedemption() public {
        vm.startPrank(address(1000));
        uint256[] memory _tokenIds = new uint[](1);
        _tokenIds[0] = tokenIds[0];
        tris.setApprovalForAll(address(trisRedemption), true);
        trisRedemption.redeem(_tokenIds);
    }

    function testSablierStream() public {
        vm.startPrank(address(1000));
        uint256[] memory _tokenIds = new uint[](1);
        _tokenIds[0] = tokenIds[0];
        wock.setApprovalForAll(address(wockRedemption), true);
        wockRedemption.redeem(_tokenIds);
        vm.startPrank(address(2000));
        _tokenIds[0] = tokenIds[1];
        wock.setApprovalForAll(address(wockRedemption), true);
        uint256 streamid = wockRedemption.redeem(_tokenIds);
        uint256 time = block.timestamp;

        require(streamid != 0, "wrong streamId");
        uint256 vested = Math.min(
            REDEMPTION, REDEMPTION / 4 + (3 * (block.timestamp - wockRedemption.startTime()) * REDEMPTION) / (52 weeks)
        );

        uint256 total = REDEMPTION;
        assertEq(pint.balanceOf(address(1000)), vested);
        vm.warp(block.timestamp + 10 weeks);

        uint256 expectedAmount =
            ((REDEMPTION - vested) * (block.timestamp - time)) / (52 weeks - (time - wockRedemption.startTime()));
        console2.log(expectedAmount);

        lockupLinear.withdrawMax(streamid, address(2000));
        uint256 currentAmount = pint.balanceOf(address(2000)) - vested;
        console2.log(currentAmount);
        uint256 diff = uint256(int256(expectedAmount - currentAmount));
        console2.log(diff);
    }
}
