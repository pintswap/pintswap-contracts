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

contract TRISRedemption {
    using SafeERC20 for IERC20;
    address constant nft = 0x0055485fCa054D165fc0C7D836459722436544c1;
    address constant treasury = 0xEC3de41D5eAD4cebFfD656f7FC9d1a8d8Ff0f8c0;
    address immutable asset;
    uint256 constant REDEMPTION = 1e23;
    uint256 public startTime;

    constructor(address _asset) {
        asset = _asset;
        startTime = block.timestamp;
    }

    function redeem(uint256[] memory tokenIds) public returns (uint256 output) {
        for (uint256 i = 0; i < tokenIds.length; i++) {
            IERC721(nft).safeTransferFrom(
                msg.sender,
                address(0xdead),
                tokenIds[i]
            );
        }
        output = tokenIds.length * REDEMPTION;
        IERC20(asset).safeTransferFrom(treasury, msg.sender, output);
    }
}
