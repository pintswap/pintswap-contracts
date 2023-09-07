// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Common} from "./Common.test.sol";
import {Math} from "openzeppelin-contracts/contracts/utils/math/Math.sol";

contract RedemptionTest is Common {
    uint[] tokenIds;

    uint256 constant REDEMPTION = 1e24;

    function setUp() public {
        initializeMainnetFork();
        setUpBase();

        for (uint i = 0; i < 10; i++) {
            tokenIds.push(
                uint(
                    keccak256(
                        abi.encodePacked(
                            address(tris),
                            (i * 100),
                            address(uint160((100 + (i * 100))))
                        )
                    )
                )
            );
            vm.prank(tris.owner());
            tris.adminMint(address(uint160((100 + (i * 100)))), tokenIds[i]);
            vm.prank(wock.owner());
            wock.mint(address(uint160((100 + (i * 100)))), tokenIds[i]);
        }
    }

    function testTRISRedemption() public {
        vm.startPrank(address(100));
        uint[] memory _tokenIds = new uint[](1);
        _tokenIds[0] = tokenIds[0];
        tris.setApprovalForAll(address(trisRedemption), true);
        trisRedemption.redeem(_tokenIds);
    }

    function testSablierStream() public {
        vm.startPrank(address(100));
        uint[] memory _tokenIds = new uint[](1);
        _tokenIds[0] = tokenIds[0];
        wock.setApprovalForAll(address(wockRedemption), true);
        wockRedemption.redeem(_tokenIds);
        vm.startPrank(address(200));
        _tokenIds[0] = tokenIds[1];
        wock.setApprovalForAll(address(wockRedemption), true);
        uint streamid = wockRedemption.redeem(_tokenIds);

        assertEq(streamid, 0);
        uint256 vested = Math.max(
            REDEMPTION,
            REDEMPTION /
                4 +
                (3 *
                    (block.timestamp - wockRedemption.startTime()) *
                    REDEMPTION) /
                (52 weeks)
        );
        vm.warp(block.timestamp + 10 weeks);
    }
}
