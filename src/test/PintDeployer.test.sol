// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {Common} from "./Common.test.sol";
import {PINTDeploy} from "../PINTDeployer.sol";
import {PINT} from "../PINT.sol";
import {vePINT} from "../vePINT.sol";
import {console2} from "forge-std/console2.sol";
import {ComputeCreateAddress} from "../utils/ComputeCreateAddress.sol";

contract PintDeployerTest is Common {
    PINT pint;
    vePINT vePint;
    PINTDeploy pintDeploy;

    function setUp() public {
        initializeMainnetFork();
        setUpBase();
        pintDeploy = new PINTDeploy();
        pint = PINT(
            payable(
                ComputeCreateAddress.getCreateAddress(address(pintDeploy), 2)
            )
        );
        vePint = vePINT(
            (ComputeCreateAddress.getCreateAddress(address(pintDeploy), 4))
        );
    }

    function testBasicRun() public {
        console2.log(pint.decimals());
    }
}
