// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

library ComputeCreateAddress {
    function getCreateAddress(address deployer, uint256 nonce)
        internal
        pure
        returns (address)
    {
        bytes memory data;

        if (nonce == 0x00)
            data = abi.encodePacked(
                uint8(0xd6),
                uint8(0x94),
                deployer,
                uint8(0x80)
            );
        else if (nonce <= 0x7f)
            data = abi.encodePacked(
                uint8(0xd6),
                uint8(0x94),
                deployer,
                uint8(nonce)
            );
        else if (nonce <= 0xff)
            data = abi.encodePacked(
                uint8(0xd7),
                uint8(0x94),
                deployer,
                uint8(0x81),
                uint8(nonce)
            );
        else if (nonce <= 0xffff)
            data = abi.encodePacked(
                uint8(0xd8),
                uint8(0x94),
                deployer,
                uint8(0x82),
                uint16(nonce)
            );
        else if (nonce <= 0xffffff)
            data = abi.encodePacked(
                uint8(0xd9),
                uint8(0x94),
                deployer,
                uint8(0x83),
                uint24(nonce)
            );
        else
            data = abi.encodePacked(
                uint8(0xda),
                uint8(0x94),
                deployer,
                uint8(0x84),
                uint32(nonce)
            );
        return address(uint160(uint256(keccak256(data))));
    }
}
