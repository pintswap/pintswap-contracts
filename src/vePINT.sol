// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {ERC4626Upgradeable} from "openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/ERC4626Upgradeable.sol";
import {ERC20Upgradeable} from "openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {IERC20Upgradeable} from "openzeppelin-contracts-upgradeable/contracts/token/ERC20/IERC20Upgradeable.sol";

contract vePINT is ERC4626Upgradeable {
    function initialize(IERC20Upgradeable underlying) public {
        __ERC20_init_unchained("vePINT", "vePINT");
        __ERC4626_init(underlying);
    }
}
