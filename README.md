# <h1 align="center"> Learning Decentralized Finance</h1>

**This code explores how to use Uniswap, Curve, etc. with Foundry.**

### Goals

1. Understand Uniswap V2 Core and Periphery

### Getting Started

#### Use Foundry:

Note: Add information about running anvil, running a forked version of mainnet using anvil, and then how you can use anvil with the forge testing framework.

```bash
forge install
forge test
```

### Features

-   Write / run tests with either Hardhat or Foundry:

```bash
forge test
```

-   Install libraries with Foundry.

```bash
forge install rari-capital/solmate # Already in this repo, just an example
```

### Notes

Whenever you install new libraries using Foundry, make sure to update your `remappings.txt` file by running `forge remappings > remappings.txt`. This is required because we use `hardhat-preprocessor` and the `remappings.txt` file to allow Hardhat to resolve libraries you install with Foundry.
