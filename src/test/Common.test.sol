// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;
import {Test} from "forge-std/Test.sol";

contract Common is Test {
    uint256 mainnet;

    function setUpBase() public {}

    function initializeMainnetFork() public {
        mainnet = vm.createSelectFork(vm.rpcUrl("mainnet"));
    }

    function getCreateAddress(address deployer, uint256 nonce)
        internal
        view
        returns (address result)
    {
        assembly {
            let ptr := mload(0x40)
            mstore(ptr, deployer)
            mstore(add(0x20, ptr), nonce)
            result := and(
                0xffffffffffffffffffffffffffffffffffffffff,
                keccak256(ptr, 0x40)
            )
            mstore(ptr, 0x0)
            mstore(add(0x20, ptr), 0x0)
        }
    }
}
