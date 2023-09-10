// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import {SafeERC20} from "openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {Math} from "openzeppelin-contracts/contracts/utils/math/Math.sol";
import {IERC20 as IERC20Sablier} from "v2-core/src/types/Tokens.sol";
import {IERC721} from "openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
import {ISablierV2LockupLinear} from "v2-core/src/interfaces/ISablierV2LockupLinear.sol";
import {Broker, LockupLinear} from "v2-core/src/types/DataTypes.sol";
import {ud60x18} from "v2-core/src/types/Math.sol";

contract WOCKRedemption {
    using SafeERC20 for IERC20;
    address constant nft = 0xcB72ed407Cdb97a7161a2b567b5f50B55585Ee6b;
    address constant treasury = 0xEC3de41D5eAD4cebFfD656f7FC9d1a8d8Ff0f8c0;
    address immutable asset;
    uint256 constant REDEMPTION = 1e24;
    ISablierV2LockupLinear constant lockupLinear =
        ISablierV2LockupLinear(0xB10daee1FCF62243aE27776D7a92D39dC8740f95);
    uint256 public startTime;

    constructor(address _asset) {
        asset = _asset;
        startTime = block.timestamp;
        IERC20(asset).safeApprove(address(lockupLinear), type(uint256).max);
    }

    function redeem(
        uint256[] memory tokenIds
    ) public returns (uint256 streamId) {
        for (uint256 i = 0; i < tokenIds.length; i++) {
            IERC721(nft).safeTransferFrom(
                msg.sender,
                address(0xdead),
                tokenIds[i]
            );
        }
        uint256 total = tokenIds.length * REDEMPTION;
        uint256 vested = Math.min(
            total,
            total / 4 + (3 * (block.timestamp - startTime) * total) / (52 weeks)
        );
        IERC20(asset).safeTransferFrom(treasury, msg.sender, vested);
        if (total - vested > 0) {
            IERC20(asset).safeTransferFrom(
                treasury,
                address(this),
                total - vested
            );
            LockupLinear.CreateWithDurations memory params;
            params.sender = treasury;
            params.recipient = msg.sender;
            params.totalAmount = uint128(total - vested);
            params.asset = IERC20Sablier(asset);
            params.cancelable = true;
            params.durations = LockupLinear.Durations({
                cliff: uint40(0 weeks),
                total: uint40(
                    (52 weeks - Math.min(52 weeks, block.timestamp - startTime))
                )
            });
            params.broker = Broker(address(treasury), ud60x18(0));
            if (block.timestamp - startTime >= (51 weeks + 6 days + 23 hours))
                streamId = uint256(0x0);
            else streamId = lockupLinear.createWithDurations(params);
        }
    }
}
