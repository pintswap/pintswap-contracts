// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;
import {Test} from "forge-std/Test.sol";
import {PINT} from "../PINT.sol";
import {sipERC20} from "../sipERC20.sol";
import {PINTDeploy} from "../PINTDeployer.sol";
import {PINTRedemption} from "../PINTRedemption.sol";
import {ComputeCreateAddress} from "../utils/ComputeCreateAddress.sol";
import {OPPS} from "../OPPS.sol";
import {IERC20Metadata} from "openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import {UniswapV2PairComputeLibrary} from "../libraries/UniswapV2PairComputeLibrary.sol";
import {IWETH} from "uniswap-v2-periphery/interfaces/IWETH.sol";
import {IUniswapV2Factory} from "uniswap-v2-core/interfaces/IUniswapV2Factory.sol";
import {IUniswapV2Router02} from "uniswap-v2-periphery/interfaces/IUniswapV2Router02.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {IUniswapV2Pair} from "uniswap-v2-core/interfaces/IUniswapV2Pair.sol";
import {IERC721} from "openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";

contract Common is Test {
    uint256 mainnet;

    PINT pint;
    sipERC20 vePint;
    PINTDeploy pintDeploy;
    OPPS opps;
    address pair;
    PINTRedemption redemption;
    IERC721 wock = 0xcB72ed407Cdb97a7161a2b567b5f50B55585Ee6b;
    IERC721 tris = 0x0055485fCa054D165fc0C7D836459722436544c1;

    IUniswapV2Router02 constant router =
        IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

    IUniswapV2Factory constant factory =
        IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);
    IWETH constant weth = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);

    address constant treasury =
        address(0xEC3de41D5eAD4cebFfD656f7FC9d1a8d8Ff0f8c0);

    function setUpBase() public {
        vm.startPrank(0x94e1f974E82fda48cC37F6144F5a921c9Bca659C);
        pintDeploy = new PINTDeploy(treasury);
        assertEq(
            address(pintDeploy),
            0xd665F1153599e8F799b2514069dF4481d3bcb043
        );
        pint = PINT(payable(0x35409176FD2ffEB23786c2a6EF5b05184c6EDBa7));
        opps = OPPS(0x66316fC4371A59238D9a54c9Acb382a4B977BF8E);
        vePint = sipERC20(PINT(pint).ve());
        redemption = PINTRedemption(
            ComputeCreateAddress.getCreateAddress(address(pintDeploy), 5)
        );
        //send pint to address(100)
        vm.startPrank(treasury);
        pint.transfer(address(100), 1 ether);
        vm.deal(treasury, 1000 ether);
        pint.approve(address(router), ~uint(1));
        IERC20(address(weth)).approve(address(router), ~uint(1));
        router.addLiquidityETH{value: 100 ether}(
            address(pint),
            10000000 ether,
            99 ether + (999 ether / 1000),
            9999999 ether + (999 ether / 1000),
            treasury,
            block.timestamp + 2000
        );
        pair = UniswapV2PairComputeLibrary.pairFor(
            address(factory),
            address(pint),
            address(weth)
        );
        IUniswapV2Pair(pair).sync();
        vm.stopPrank();
        vm.startPrank(address(100));
        pint.approve(address(router), ~uint(1));
        IERC20(address(weth)).approve(address(router), ~uint(1));
        vm.startPrank(address(200));
        pint.approve(address(router), ~uint(1));
        IERC20(address(weth)).approve(address(router), ~uint(1));
        vm.stopPrank();
    }

    function initializeMainnetFork() public {
        mainnet = vm.createSelectFork(vm.rpcUrl("mainnet"));
    }
}
