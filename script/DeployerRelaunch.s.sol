// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Script, console2} from "forge-std/Script.sol";
import {PINT} from "../src/PINT.sol"; 
import {PINTV2} from "../src/PINTV2.sol"; 
import {PINTDeployer} from "../src/PINTDeployer.sol"; 
import {TransparentUpgradeableProxy} from
    "openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {ProxyAdmin} from "openzeppelin-contracts/contracts/proxy/transparent/ProxyAdmin.sol";
import {OPPS} from "../src/OPPS.sol";
import {ComputeCreateAddress} from "../src/utils/ComputeCreateAddress.sol";
import {UniswapV2PairComputeLibrary} from "../src//libraries/UniswapV2PairComputeLibrary.sol";
import {IUniswapV2Factory} from "uniswap-v2-core/interfaces/IUniswapV2Factory.sol";
import {Test, console2} from "forge-std/Test.sol";

interface IOPPS {
    function vaultFor(address token) external returns (address); 
}

contract DeployRelaunch is Script, Test {
    IUniswapV2Factory constant factory = IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);
    address constant weth = address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    address constant treasury = address(0xEC3de41D5eAD4cebFfD656f7FC9d1a8d8Ff0f8c0);
    address constant opps = 0xd665F1153599e8F799b2514069dF4481d3bcb043; 
    address payable public pintV2; 
    address internal constant pintv1 = 0x58fB30A61C218A3607e9273D52995a49fF2697Ee;  
    address internal deployer = 0xC5F24aFE1A3C7C05a4078856D56286E382aFEf07; 
        
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
            
        PINTDeployer deployer = new PINTDeployer();         

        vm.stopBroadcast();
    }
}



