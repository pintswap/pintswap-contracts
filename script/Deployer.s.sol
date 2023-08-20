// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import "forge-deploy/DeployScript.sol";
import "generated/deployer/DeployerFunctions.g.sol";

contract Deployments is DeployScript {
    using DeployerFunctions for Deployer;

    function deploy() external returns (PINTDeploy) {
        return deployer.deploy_PINTDeploy("PINTDeploy_01");
    }
}
