// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import { SafeERC20 } from "openzeppelin-solidity/contracts/token/ERC20/utils/SafeERC20.sol";
import { IERC20 } from "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
import { IERC721 } from "openzeppelin-solidity/contracts/token/ERC721/IERC721.sol";

contract PINTRedemption {
  using SafeERC20 for IERC20;
  address constant wock = 0xcB72ed407Cdb97a7161a2b567b5f50B55585Ee6b;
  address constant tris = 0x0055485fCa054D165fc0C7D836459722436544c1;
  address constant treasury = 0xEC3de41D5eAD4cebFfD656f7FC9d1a8d8Ff0f8c0;
  address immutable pint;
  uint256 constant WOCK_REDEMPTION = 1e24;
  uint256 constant TRIS_REDEMPTION = 1e23;
  constructor(address _pint) {
    pint = _pint;
  }
  function redeemWOCK(uint256[] memory tokenIds) public returns (uint256 output) {
    for (uint256 i = 0; i < tokenIds.length; i++) {
      IERC721(wock).safeTransferFrom(msg.sender, address(0x0), tokenIds[i]);
    }
    IERC20(pint).safeTransferFrom(treasury, msg.sender, tokenIds.length*WOCK_REDEMPTION);
  }
  function redeemTRIS(uint256[] memory tokenIds) public returns (uint256 output) {
    for (uint256 i = 0; i < tokenIds.length; i++) {
      IERC721(wock).safeTransferFrom(msg.sender, address(0x0), tokenIds[i]);
    }
    IERC20(pint).safeTransferFrom(treasury, msg.sender, tokenIds.length*TRIS_REDEMPTION);
  }
}
  
