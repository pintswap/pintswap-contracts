// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import "forge-deploy/DeployScript.sol";
import "generated/deployer/DeployerFunctions.g.sol";
import "forge-std/console2.sol";
import {DefaultDeployerFunction, DeployOptions} from "forge-deploy/DefaultDeployerFunction.sol";

contract Deployments is DeployScript {
    using DeployerFunctions for Deployer;
    using DefaultDeployerFunction for Deployer;

    function deploy() external returns (PINTDeploy) {
        console2.log("deploying");
        bytes memory bytecode = abi.encodePacked(
            vm.getCode("PINTDeployer.sol:PINTDeploy")
        );
        address deployed;
        assembly {
            deployed := create(0, add(bytecode, 0x20), mload(bytecode))
        }
        vm.etch(address(100), deployed.code);
        return PINTDeploy(address(100));
    }
}
