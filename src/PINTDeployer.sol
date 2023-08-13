// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {TransparentUpgradeableProxy} from "openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {ProxyAdmin} from "openzeppelin-contracts/contracts/proxy/transparent/ProxyAdmin.sol";
import {IUniswapV2Factory} from "uniswap-v2-core/interfaces/IUniswapV2Factory.sol";
import {UniswapV2PairComputeLibrary} from "./libraries/UniswapV2PairComputeLibrary.sol";
import {PINT} from "./PINT.sol";
import {sPINT} from "./sPINT.sol";

contract PINTDeploy {
    IUniswapV2Factory constant factory =
        IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);
    address constant weth = address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    address constant treasury =
        address(0xEC3de41D5eAD4cebFfD656f7FC9d1a8d8Ff0f8c0);

    function getCreateAddress(
        uint256 nonce
    ) internal view returns (address result) {
        assembly {
            let ptr := mload(0x40)
            mstore(ptr, address())
            mstore(add(0x20, ptr), nonce)
            result := and(
                0xffffffffffffffffffffffffffffffffffffffff,
                keccak256(ptr, 0x40)
            )
            mstore(ptr, 0x0)
            mstore(add(0x20, ptr), 0x0)
        }
    }

    constructor() {
        ProxyAdmin proxy = new ProxyAdmin();
        address pintAddress = getCreateAddress(4);
        address pair = UniswapV2PairComputeLibrary.pairFor(
            address(factory),
            pintAddress,
            weth
        );
        address veLogic = address(new sPINT());
        address ve = address(
            new TransparentUpgradeableProxy(
                veLogic,
                address(proxy),
                abi.encodeWithSelector(sPINT.initialize.selector, pair)
            )
        );
        address pintLogic = address(new PINT(pair, ve));
        address pint = address(
            new TransparentUpgradeableProxy(
                pintLogic,
                address(proxy),
                abi.encodeWithSelector(PINT.initialize.selector)
            )
        );
        require(pint == pintAddress, "!pint-address");
        address actualPairAddress = address(factory.createPair(pint, weth));
        require(pair == actualPairAddress, "!pair-address");
        proxy.transferOwnership(treasury);
        assembly { return(0x0, 0x0) }
    }
}
