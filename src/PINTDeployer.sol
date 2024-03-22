// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {TransparentUpgradeableProxy} from
    "openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {ProxyAdmin} from "openzeppelin-contracts/contracts/proxy/transparent/ProxyAdmin.sol";
import {IUniswapV2Factory} from "uniswap-v2-core/interfaces/IUniswapV2Factory.sol";
import {UniswapV2PairComputeLibrary} from "./libraries/UniswapV2PairComputeLibrary.sol";
import {ComputeCreateAddress} from "./utils/ComputeCreateAddress.sol";
import {WOCKRedemption} from "./WOCKRedemption.sol";
import {TRISRedemption} from "./TRISRedemption.sol";
import {PINT} from "./PINT.sol";
import {OPPS} from "./OPPS.sol";
import {PINTV2} from "./PINTV2.sol"; 
import {Test, console2} from "forge-std/Test.sol";

contract PINTDeployer is Test {
    IUniswapV2Factory constant factory = IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);
    address constant weth = address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    address constant treasury = address(0xEC3de41D5eAD4cebFfD656f7FC9d1a8d8Ff0f8c0);
    address constant opps = 0xd665F1153599e8F799b2514069dF4481d3bcb043; 
    address payable public pintV2; 
    
    constructor() {
        //address opps = ComputeCreateAddress.getCreateAddress(msg.sender, 0);
        ProxyAdmin proxy = new ProxyAdmin();
        address pintAddress = ComputeCreateAddress.getCreateAddress(address(this), 3);
        address pair = UniswapV2PairComputeLibrary.pairFor(address(factory), pintAddress, weth);
        console2.log(pintAddress); 
        console2.log(pair); 
        address pintLogic = address(new PINTV2(pair, OPPS(opps).vaultFor(pintAddress)));
        //address pintLogic = address(new PINTV2(pair, address(0)));
        address pint = address(
            new TransparentUpgradeableProxy(
                pintLogic,
                address(proxy),
                abi.encodeWithSelector(PINTV2.initialize.selector)
            )
        );
        OPPS(opps).deployVault(pintAddress);
        console2.log(pint); 
        require(pint == pintAddress, "!pint-address");
        pintV2 = payable(pint); 
        address actualPairAddress = address(factory.createPair(pint, weth));
        require(pair == actualPairAddress, "!pair-address");
        console2.log(actualPairAddress, pair); 
        proxy.transferOwnership(treasury);

        //assembly {
        //    return(0x0, 0x0)
        //}
    }

    function getPintAddress() public view returns (address payable) {
      return pintV2;  
    }
}
