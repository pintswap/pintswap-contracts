// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;
import {Test} from "forge-std/Test.sol";
import {PINT} from "../PINT.sol";
import {sipERC20} from "../sipERC20.sol";
import {PINTDeploy} from "../PINTDeployer.sol";
import {ComputeCreateAddress} from "../utils/ComputeCreateAddress.sol";
import {OPPS} from "../OPPS.sol";
import {IERC20Metadata} from "openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import {UniswapV2PairComputeLibrary} from "../libraries/UniswapV2PairComputeLibrary.sol";
import {IWETH} from "uniswap-v2-periphery/interfaces/IWETH.sol";
import {IUniswapV2Factory} from "uniswap-v2-core/interfaces/IUniswapV2Factory.sol";
import {IUniswapV2Router02} from "uniswap-v2-periphery/interfaces/IUniswapV2Router02.sol";

contract Common is Test {
    uint256 mainnet;

    PINT pint;
    sipERC20 vePint;
    PINTDeploy pintDeploy;
    OPPS opps;
    address pair;

    IUniswapV2Router02 constant router =
        IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

    IUniswapV2Factory constant factory =
        IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);
    IWETH constant weth = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);

    address constant treasury =
        address(0xEC3de41D5eAD4cebFfD656f7FC9d1a8d8Ff0f8c0);

    function setUpBase() public {
        pintDeploy = new PINTDeploy(treasury);
        pint = PINT(
            payable(
                ComputeCreateAddress.getCreateAddress(address(pintDeploy), 4)
            )
        );
        opps = OPPS(
            ComputeCreateAddress.getCreateAddress(address(pintDeploy), 2)
        );
        vePint = sipERC20(PINT(pint).ve());
        //send pint to address(100)
        vm.startPrank(treasury);
        pint.transfer(address(100), 1 ether);
        vm.stopPrank();
        pair = UniswapV2PairComputeLibrary.pairFor(
            address(factory),
            address(pint),
            address(weth)
        );
    }

    function initializeMainnetFork() public {
        mainnet = vm.createSelectFork(vm.rpcUrl("mainnet"));
    }
}
