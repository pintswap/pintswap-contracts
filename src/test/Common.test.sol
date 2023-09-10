// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;
import {Test} from "forge-std/Test.sol";
import {PINT} from "../PINT.sol";
import {sipERC20} from "../sipERC20.sol";
import {PINTDeploy} from "../PINTDeployer.sol";
import {ComputeCreateAddress} from "../utils/ComputeCreateAddress.sol";
import {IERC20Metadata} from "openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol";

contract Common is Test {
    uint256 mainnet;

    PINT pint;
    sipERC20 vePint;
    PINTDeploy pintDeploy;

    function setUpBase() public {
        pintDeploy = new PINTDeploy();
        pint = PINT(
            payable(
                ComputeCreateAddress.getCreateAddress(address(pintDeploy), 4)
            )
        );
        vePint = sipERC20(PINT(pint).ve());
    }

    function initializeMainnetFork() public {
        mainnet = vm.createSelectFork(vm.rpcUrl("mainnet"));
    }
}
