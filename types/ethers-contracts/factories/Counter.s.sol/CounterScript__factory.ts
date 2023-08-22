/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import {
  Contract,
  ContractFactory,
  ContractTransactionResponse,
  Interface,
} from "ethers";
import type { Signer, ContractDeployTransaction, ContractRunner } from "ethers";
import type { NonPayableOverrides } from "../../common";
import type {
  CounterScript,
  CounterScriptInterface,
} from "../../Counter.s.sol/CounterScript";

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
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "setUp",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

const _bytecode =
  "0x6080604052600b805462ff00ff19166201000117905534801561002157600080fd5b5061011b806100316000396000f3fe6080604052348015600f57600080fd5b5060043610603c5760003560e01c80630a9254e4146041578063c0406226146043578063f8ccbf47146049575b600080fd5b005b6041606f565b600b54605b9062010000900460ff1681565b604051901515815260200160405180910390f35b7f885cb69240a935d632d79c317109709ecfa91a80626ff3989d68f67f5b1dd12d60001c6001600160a01b031663afc980406040518163ffffffff1660e01b8152600401600060405180830381600087803b15801560cc57600080fd5b505af115801560df573d6000803e3d6000fd5b5050505056fea264697066735822122009c9e9c94df164625ff8850c028625652d02a0ade9291a220b792dbe6b49ce2464736f6c634300080f0033";

type CounterScriptConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: CounterScriptConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class CounterScript__factory extends ContractFactory {
  constructor(...args: CounterScriptConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override getDeployTransaction(
    overrides?: NonPayableOverrides & { from?: string }
  ): Promise<ContractDeployTransaction> {
    return super.getDeployTransaction(overrides || {});
  }
  override deploy(overrides?: NonPayableOverrides & { from?: string }) {
    return super.deploy(overrides || {}) as Promise<
      CounterScript & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(runner: ContractRunner | null): CounterScript__factory {
    return super.connect(runner) as CounterScript__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): CounterScriptInterface {
    return new Interface(_abi) as CounterScriptInterface;
  }
  static connect(
    address: string,
    runner?: ContractRunner | null
  ): CounterScript {
    return new Contract(address, _abi, runner) as unknown as CounterScript;
  }
}
