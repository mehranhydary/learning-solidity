# <h1 align="center"> Learning Solidity through Decentralized Finance</h1>

**This code will explore to use Uniswap, Curve, etc. with Foundry.**

### Goals

1. Understand Uniswap V2 Core and Periphery
2. Understand Curve
3. Understand Uniswap V3 Core and Periphery

### Getting Started

#### Use Foundry:

These instructions only work if you already have Foundry installed. See [here](https://github.com/foundry-rs/foundry) for more information.

1. Create an .env file

In this .env file, add a variable called ETH_RPC_URL and set it equal to your RPC end point. You can get an RPC end point from Alchemy or Infura.

Once the file is set, run `source .env` in your terminal.

2. Run anvil

Anvil is a local Ethereum node. Since we are working with DeFi contracts, a lot of the contracts we will be working with are already deployed to mainnet. Instead of redeploying them, we will use our RPC endpoint and Anvil to create a forked version of the main Ethereum network on our local node.

Run `anvil --fork-url $ETH_RPC_URL` in your terminal to start a local node that is a fork of the main Ethereum network. This node will be running on `http://localhost:8545`.

3. Use Foundry

To start working with the code in this repository, open a new terminal and run the following code.

```bash
forge install # Only have to do this once
forge test --fork-url http://localhost:8545 # Run this every time you want to test your new code
```

This code will install all of the dependencies and then run the tests in this repository.

### Features

-   Write / run tests with Foundry:

```bash
forge test --fork-url http://localhost:8545
```

-   Install libraries with Foundry.

```bash
forge install rari-capital/solmate # Already in this repo, just an example
```

### Notes

Whenever you install new libraries using Foundry, make sure to update your `remappings.txt` file by running `forge remappings > remappings.txt`. This is required because we use `hardhat-preprocessor` and the `remappings.txt` file to allow Hardhat to resolve libraries you install with Foundry.
