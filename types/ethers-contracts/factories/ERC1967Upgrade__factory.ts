/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Contract, Interface, type ContractRunner } from "ethers";
import type {
  ERC1967Upgrade,
  ERC1967UpgradeInterface,
} from "../ERC1967Upgrade";

const _abi = [
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "address",
        name: "previousAdmin",
        type: "address",
      },
      {
        indexed: false,
        internalType: "address",
        name: "newAdmin",
        type: "address",
      },
    ],
    name: "AdminChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "beacon",
        type: "address",
      },
    ],
    name: "BeaconUpgraded",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "implementation",
        type: "address",
      },
    ],
    name: "Upgraded",
    type: "event",
  },
] as const;

export class ERC1967Upgrade__factory {
  static readonly abi = _abi;
  static createInterface(): ERC1967UpgradeInterface {
    return new Interface(_abi) as ERC1967UpgradeInterface;
  }
  static connect(
    address: string,
    runner?: ContractRunner | null
  ): ERC1967Upgrade {
    return new Contract(address, _abi, runner) as unknown as ERC1967Upgrade;
  }
}
