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
  TagsReader,
  TagsReaderInterface,
} from "../../Deployer.sol/TagsReader";

const _abi = [
  {
    inputs: [
      {
        internalType: "string",
        name: "context",
        type: "string",
      },
    ],
    name: "readTagsFromContext",
    outputs: [
      {
        internalType: "string[]",
        name: "tags",
        type: "string[]",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

const _bytecode =
  "0x608060405234801561001057600080fd5b506105fe806100206000396000f3fe608060405234801561001057600080fd5b506004361061002b5760003560e01c80633192a99614610030575b600080fd5b61004361003e366004610251565b610059565b604051610050919061031f565b60405180910390f35b606060007f885cb69240a935d632d79c317109709ecfa91a80626ff3989d68f67f5b1dd12d60001c60601b60601c6001600160a01b031663d930a0e66040518163ffffffff1660e01b8152600401600060405180830381865afa1580156100c4573d6000803e3d6000fd5b505050506040513d6000823e601f3d908101601f191682016040526100ec9190810190610434565b90506000816040516020016101019190610469565b60408051601f19818403018152908290526360f9bb1160e01b82529150600090737109709ecfa91a80626ff3989d68f67f5b1dd12d906360f9bb119061014b90859060040161049b565b600060405180830381865afa158015610168573d6000803e3d6000fd5b505050506040513d6000823e601f3d908101601f191682016040526101909190810190610434565b90506101bd8187876040516020016101a99291906104ae565b6040516020818303038152906040526101c7565b9695505050505050565b604051631263f73d60e21b8152606090737109709ecfa91a80626ff3989d68f67f5b1dd12d9063498fdcf49061020390869086906004016104d7565b6000604051808303816000875af1158015610222573d6000803e3d6000fd5b505050506040513d6000823e601f3d908101601f1916820160405261024a9190810190610505565b9392505050565b6000806020838503121561026457600080fd5b823567ffffffffffffffff8082111561027c57600080fd5b818501915085601f83011261029057600080fd5b81358181111561029f57600080fd5b8660208285010111156102b157600080fd5b60209290920196919550909350505050565b60005b838110156102de5781810151838201526020016102c6565b838111156102ed576000848401525b50505050565b6000815180845261030b8160208601602086016102c3565b601f01601f19169290920160200192915050565b6000602080830181845280855180835260408601915060408160051b870101925083870160005b8281101561037457603f198886030184526103628583516102f3565b94509285019290850190600101610346565b5092979650505050505050565b634e487b7160e01b600052604160045260246000fd5b604051601f8201601f1916810167ffffffffffffffff811182821017156103c0576103c0610381565b604052919050565b600082601f8301126103d957600080fd5b815167ffffffffffffffff8111156103f3576103f3610381565b610406601f8201601f1916602001610397565b81815284602083860101111561041b57600080fd5b61042c8260208301602087016102c3565b949350505050565b60006020828403121561044657600080fd5b815167ffffffffffffffff81111561045d57600080fd5b61042c848285016103c8565b6000825161047b8184602087016102c3565b6d17b1b7b73a32bc3a39973539b7b760911b920191825250600e01919050565b60208152600061024a60208301846102f3565b601760f91b815281836001830137642e7461677360d81b91016001810191909152600601919050565b6040815260006104ea60408301856102f3565b82810360208401526104fc81856102f3565b95945050505050565b6000602080838503121561051857600080fd5b825167ffffffffffffffff8082111561053057600080fd5b818501915085601f83011261054457600080fd5b81518181111561055657610556610381565b8060051b610565858201610397565b918252838101850191858101908984111561057f57600080fd5b86860192505b838310156105bb5782518581111561059d5760008081fd5b6105ab8b89838a01016103c8565b8352509186019190860190610585565b999850505050505050505056fea26469706673582212201ccd870aa19b682a2559a73cb67d72587f7beb29b7323a67d8ad01fa85da797464736f6c634300080f0033";

type TagsReaderConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: TagsReaderConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class TagsReader__factory extends ContractFactory {
  constructor(...args: TagsReaderConstructorParams) {
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
      TagsReader & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(runner: ContractRunner | null): TagsReader__factory {
    return super.connect(runner) as TagsReader__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): TagsReaderInterface {
    return new Interface(_abi) as TagsReaderInterface;
  }
  static connect(address: string, runner?: ContractRunner | null): TagsReader {
    return new Contract(address, _abi, runner) as unknown as TagsReader;
  }
}