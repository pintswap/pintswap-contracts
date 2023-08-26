// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;
import {Test} from "forge-std/Test.sol";
import {PINT} from "../PINT.sol";
import {sipERC20} from "../sipERC20.sol";
import {PINTDeploy} from "../PINTDeployer.sol";
import {ComputeCreateAddress} from "../utils/ComputeCreateAddress.sol";
import {OPPS} from "../OPPS.sol";
import {IERC20Metadata} from "openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol";

contract Common is Test {
    uint256 mainnet;

    PINT pint;
    sipERC20 vePint;
    PINTDeploy pintDeploy;
    OPPS opps;

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
    }

    function initializeMainnetFork() public {
        mainnet = vm.createSelectFork(vm.rpcUrl("mainnet"));
    }
}
