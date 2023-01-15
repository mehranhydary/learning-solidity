
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../../../src/Uniswap/v2/Swap.sol";
import {IERC20} from "v2-periphery/interfaces/IERC20.sol";

contract UniswapTest is Test {
    Swap s;
    address DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F; // 18 decimals
    address DAI_WHALE = 0x82810e81CAD10B8032D39758C8DBa3bA47Ad7092; // Has 15m DAI as of 1/14/23
    address WBTC = 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599; // 8 decimals

    address whale = DAI_WHALE;

    function setUp() public {
        s = new Swap();
    }

    function testFailApproval() public {
        uint amountIn = 1000000 * 10 ** 18;
        uint amountOutMin = 1;
        address tokenIn = DAI;
        address tokenOut = WBTC;
        vm.prank(whale);
        s.swap(
            tokenIn,
            tokenOut,
            amountIn,
            amountOutMin,
            whale
        );
    }

    function testApprovalAndSwap() public {
        uint amountIn = 1000000 * 10 ** 18;
        uint amountOutMin = 1;
        address tokenIn = DAI;
        address tokenOut = WBTC;
        vm.startPrank(whale);
        uint tokenOutBalance = IERC20(tokenOut).balanceOf(msg.sender);
        IERC20(tokenIn).approve(address(s), amountIn);
        s.swap(
            tokenIn,
            tokenOut,
            amountIn,
            amountOutMin,
            whale
        );
        assert(IERC20(tokenOut).balanceOf(whale) > tokenOutBalance);
    }
}
