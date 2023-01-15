
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../../../src/Uniswap/v2/Swap.sol";

contract UniswapTest is Test {
    Swap s;

    function setUp() public {
        s = new Swap();
    }
}
