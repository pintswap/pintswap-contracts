// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ComputeCreateAddress} from "./utils/ComputeCreateAddress.sol";
import {WOCKRedemption} from "./WOCKRedemption.sol";
import {TRISRedemption} from "./TRISRedemption.sol";

contract PINTDeployer2 {
    constructor() {
        address pintDeployer1 = ComputeCreateAddress.getCreateAddress(msg.sender, 1);
        address pint = ComputeCreateAddress.getCreateAddress(pintDeployer1, 3);
        new WOCKRedemption(pint);
        new TRISRedemption(pint);
        assembly {
            return(0x0, 0x0)
        }
    }
}
