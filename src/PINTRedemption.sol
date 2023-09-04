// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import { SafeERC20 } from "openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";
import { IERC20 } from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import { IERC20 as IERC20Sablier } from "v2-core/src/types/Tokens.sol";
import { IERC721 } from "openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
import { ISablierV2LockupLinear } from "v2-core/src/interfaces/ISablierV2LockupLinear.sol";
import { Broker, LockupLinear } from "v2-core/src/types/DataTypes.sol";
import { ud60x18 } from "v2-core/src/types/Math.sol";


contract PINTRedemption {
  using SafeERC20 for IERC20;
  address constant wock = 0xcB72ed407Cdb97a7161a2b567b5f50B55585Ee6b;
  address constant tris = 0x0055485fCa054D165fc0C7D836459722436544c1;
  address constant treasury = 0xEC3de41D5eAD4cebFfD656f7FC9d1a8d8Ff0f8c0;
  address immutable pint;
  uint256 constant WOCK_REDEMPTION = 1e24;
  uint256 constant TRIS_REDEMPTION = 1e23;
  ISablierV2LockupLinear constant lockupLinear = ISablierV2LockupLinear(0xB10daee1FCF62243aE27776D7a92D39dC8740f95);
  constructor(address _pint) {
    pint = _pint;
  }
  function redeemWOCK(uint256[] memory tokenIds) public returns (uint256 streamId) {
    for (uint256 i = 0; i < tokenIds.length; i++) {
      IERC721(wock).safeTransferFrom(msg.sender, address(0x0), tokenIds[i]);
    }
    uint256 total = tokenIds.length*WOCK_REDEMPTION;
    IERC20(pint).safeTransferFrom(treasury, msg.sender, total/4);
    LockupLinear.CreateWithDurations memory params;
    params.sender = treasury;
    params.recipient = msg.sender;
    params.totalAmount = uint128(total*3/4);
    params.asset = IERC20Sablier(pint);
    params.cancelable = true;
    params.durations = LockupLinear.Durations({
      cliff: 0 weeks,
      total: 52 weeks
    });
    params.broker = Broker(address(0x0), ud60x18(0));
    streamId = lockupLinear.createWithDurations(params);
  }
  function redeemTRIS(uint256[] memory tokenIds) public returns (uint256 output) {
    for (uint256 i = 0; i < tokenIds.length; i++) {
      IERC721(wock).safeTransferFrom(msg.sender, address(0x0), tokenIds[i]);
    }
    output = tokenIds.length*TRIS_REDEMPTION;
    IERC20(pint).safeTransferFrom(treasury, msg.sender, output);
  }
}
  
