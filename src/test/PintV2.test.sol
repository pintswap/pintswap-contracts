// SPDX-License-Identifier: MIT
pragma solidity >=0.8.7 <0.9.0;

import {Test, console2} from "forge-std/Test.sol";
import {PINTV2} from "../PINTV2.sol"; 
import {PINTDeployer} from "../PINTDeployer.sol"; 
import {IERC20} from "forge-std/interfaces/IERC20.sol"; 
import {IUniswapV2Router02} from "uniswap-v2-periphery/interfaces/IUniswapV2Router02.sol";
import {IUniswapV2Factory} from "uniswap-v2-core/interfaces/IUniswapV2Factory.sol";


contract PintV2Test is Test {
  
  PINTDeployer pintDeployer; 
  PINTV2 internal pintV2; 

  address internal constant pintWhale = 0xEC3de41D5eAD4cebFfD656f7FC9d1a8d8Ff0f8c0; 
  address internal constant pint = 0x58fB30A61C218A3607e9273D52995a49fF2697Ee; 
  address internal constant treasury = 0xEC3de41D5eAD4cebFfD656f7FC9d1a8d8Ff0f8c0; 
  address internal constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2; 
  address owner; 
  
    IUniswapV2Router02 constant router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
    IUniswapV2Factory constant factory = IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);


  function setUp() public {
    pintDeployer = new PINTDeployer(); 
    pintV2 = PINTV2(pintDeployer.getPintAddress()); 
    owner = pintV2.owner(); 
    address pair = factory.getPair(address(pintV2), WETH); 
    
    vm.startPrank(owner); 
    pintV2.setAutomatedMarketMakerPair(pair, true); 
    pintV2.enableTrading(); 
    vm.stopPrank(); 

    addLiquidity(); 
  }

  function addLiquidity() public {
    deal(address(pintV2), address(this), 1_000e18); 
    deal(WETH, address(this), 1e18); 

    pintV2.approve(address(router), type(uint256).max); 
    IERC20(WETH).approve(address(router), type(uint256).max);  

    assertEq(pintV2.balanceOf(address(this)), 1_000e18); 
    assertGt(pintV2.allowance(address(this), address(router)), 0); 

    router.addLiquidity(
      address(pintV2),
      WETH, 
      pintV2.balanceOf(address(this)),
      IERC20(WETH).balanceOf(address(this)),
      0,
      0,
      address(this),
      block.timestamp
    ); 
  }

  function testMigrationEasyVerify() public {
    deal(pint, address(this), 100e18);  
    IERC20(pint).approve(address(pintV2), type(uint256).max);  
    pintV2.migrate(); 
    
    uint256 balanceV2After = IERC20(address(pintV2)).balanceOf(address(this));  
    console2.log(balanceV2After); 
    
  }

  function testMigrationTreasury() public {
    vm.startPrank(pintWhale);  
      
    IERC20(pint).approve(address(pintV2), type(uint256).max);  
    pintV2.migrate(); 
    
    uint256 balanceV1After = IERC20(pint).balanceOf(pintWhale); 
    assertEq(0, balanceV1After); 
    
    uint256 balanceV2After = IERC20(address(pintV2)).balanceOf(pintWhale);  
    console2.log(balanceV2After); 
  }

  function testMigrationFuzz(uint96 amount) public {
    vm.assume(amount > 0); 
    deal(pint, address(this), amount);  
    IERC20(pint).approve(address(pintV2), type(uint256).max);  
    pintV2.migrate(); 

    uint256 balanceV1After = IERC20(pint).balanceOf(address(this)); 
    assertEq(0, balanceV1After); 
    
    uint256 balanceV2After = IERC20(address(pintV2)).balanceOf(address(this));  

    assertEq(amount / 10, balanceV2After); 
  }


  function testOnePercentFee(uint96 amount) public {
    vm.assume(amount > 1e18); 
    vm.assume(amount < pintV2.maxTransactionAmount()); 
    deal(address(pintV2), address(420), amount);       
    uint256 contractBalance = pintV2.balanceOf(address(pintV2)); 
    console2.log("BALANCE BEFORE", contractBalance); 

    vm.startPrank(address(420)); 
    pintV2.approve(address(router), type(uint256).max); 
    
    address[] memory path = new address[](2); 
    path[0] = address(pintV2); 
    path[1] = WETH; 
    
    router.swapExactTokensForETHSupportingFeeOnTransferTokens(
      amount, 0, path, address(this), block.timestamp
    );

    uint256 contractBalanceAfter = pintV2.balanceOf(address(pintV2)); 
    console2.log("BALANCE AFTER", contractBalanceAfter); 

    assertEq(contractBalanceAfter, contractBalance + (amount * 100) / 10_000);  

    vm.stopPrank(); 
  }

  receive() external payable {}
}

