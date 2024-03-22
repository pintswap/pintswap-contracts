// SPDX-License-Identifier: MIT
pragma solidity >=0.8.7 <0.9.0;

import {Test, console2} from "forge-std/Test.sol";
import {PINTV2} from "../PINTV2.sol"; 
import {PINTDeployer} from "../PINTDeployer.sol"; 
import {IERC20} from "forge-std/interfaces/IERC20.sol"; 


contract PintV2Test is Test {
  
  PINTDeployer pintDeployer; 
  address internal constant pintWhale = 0xEC3de41D5eAD4cebFfD656f7FC9d1a8d8Ff0f8c0; 
  address internal constant pint = 0x58fB30A61C218A3607e9273D52995a49fF2697Ee; 
  PINTV2 internal pintV2; 
  

  function setUp() public {
    pintDeployer = new PINTDeployer(); 
    pintV2 = PINTV2(pintDeployer.getPintAddress()); 
  }

  function testMigration() public {
    vm.startPrank(pintWhale);  
      
    IERC20(pint).approve(address(pintV2), type(uint256).max);  
    pintV2.migrate(); 
    
    uint256 balanceV1After = IERC20(pint).balanceOf(pintWhale); 
    assertEq(0, balanceV1After); 
    
    uint256 balanceV2After = IERC20(address(pintV2)).balanceOf(pintWhale);  
    console2.log(balanceV2After); 
    
  }

}

