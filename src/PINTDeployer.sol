// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {IUniswapV2Factory} from "uniswap-v2-core/interfaces/IUniswapV2Factory.sol";

contract PINTDeploy {
    IUniswapV2Factory constant factory =
        IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);
    address constant weth = address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    address public immutable pair;

    constructor() {
        pair = factory.createPair(address(this), weth);
    }
}
