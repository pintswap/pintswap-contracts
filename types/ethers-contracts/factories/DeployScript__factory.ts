/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import { Contract, Interface, type ContractRunner } from "ethers";
import type { DeployScript, DeployScriptInterface } from "../DeployScript";

const _abi = [
  {
    inputs: [],
    name: "IS_SCRIPT",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "run",
    outputs: [
      {
        components: [
          {
            internalType: "string",
            name: "name",
            type: "string",
          },
          {
            internalType: "address payable",
            name: "addr",
            type: "address",
          },
          {
            internalType: "bytes",
            name: "bytecode",
            type: "bytes",
          },
          {
            internalType: "bytes",
            name: "args",
            type: "bytes",
          },
          {
            internalType: "string",
            name: "artifact",
            type: "string",
          },
          {
            internalType: "string",
            name: "deploymentContext",
            type: "string",
          },
          {
            internalType: "string",
            name: "chainIdAsString",
            type: "string",
          },
        ],
        internalType: "struct DeployerDeployment[]",
        name: "newDeployments",
        type: "tuple[]",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

export class DeployScript__factory {
  static readonly abi = _abi;
  static createInterface(): DeployScriptInterface {
    return new Interface(_abi) as DeployScriptInterface;
  }
  static connect(
    address: string,
    runner?: ContractRunner | null
  ): DeployScript {
    return new Contract(address, _abi, runner) as unknown as DeployScript;
  }
}
