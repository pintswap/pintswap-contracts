// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Common} from "./Common.test.sol";
import {PINTDeploy} from "../PINTDeployer.sol";
import {PINT} from "../PINT.sol";
import {sipERC20} from "../sipERC20.sol";
import {console2} from "forge-std/console2.sol";
import {ComputeCreateAddress} from "../utils/ComputeCreateAddress.sol";
import {IERC20Metadata} from "openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol";

contract PintDeployerTest is Common {
    PINT pint;
    sipERC20 vePint;
    PINTDeploy pintDeploy;

    function setUp() public {
        initializeMainnetFork();
        setUpBase();
        pintDeploy = new PINTDeploy();
        pint = PINT(
            payable(
                ComputeCreateAddress.getCreateAddress(address(pintDeploy), 4)
            )
        );
        vePint = sipERC20(PINT(pint).ve());
    }

    function testBasicRun() public {
        assertEq(pint.decimals(), 18);
        console2.log(address(100));
        assertEq(pint.name(), "PINT");
        assertEq(pint.symbol(), "PINT");
        bytes32 hash;
        address ve = address(vePint);
        assembly {
          hash := extcodehash(ve)
        }
        console2.log(uint256(hash));
/*
        console2.log(vePint.name());
        assertEq(bytes(vePint.symbol()), bytes("sipPINT"));
        assertEq(vePint.symbol(), "sipPINT");
*/
    }
}
