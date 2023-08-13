// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { ERC20Upgradeable } from "openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol";
import { ERC20PermitUpgradeable } from "openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/ERC20PermitUpgradeable.sol";
import { Initializable } from "openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol";
import { IUniswapV2Pair } from "uniswap-v2-p

contract PINT is ERC20Upgradeable, ERC20PermitUpgradeable, Initializable {
  address constant factory = address(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);
  address constant dao = address(0xEC3de41D5eAD4cebFfD656f7FC9d1a8d8Ff0f8c0);
  uint256 constant INITIAL_SUPPLY = 100000000e18;
  address immutable public opps;
  address immutable public pair;
  constructor(address _pair, address _opps) {
    pair = _pair;
    opps = _opps;
  }
  function initialize() public initializer {
    __ERC20_init_unchained("PINT", "PINT");
    __ERC20Permit_init_unchained("PINT");
    _mint(dao, INITIAL_SUPPLY);
  }
}
