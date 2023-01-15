
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../../../src/Uniswap/v2/Liquidity.sol";
import {IERC20} from "v2-periphery/interfaces/IERC20.sol";
import {IUniswapV2Factory} from "v2-core/interfaces/IUniswapV2Factory.sol";

contract LiquidityTest is Test {
    Liquidity l;
    address private constant UNISWAP_V2_FACTORY = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    address DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F; 
    address Y4 = 0xdF5e0e81Dff6FAF3A7e52BA697820c5e32D806A8; 
    address WHALE = 0x70747df6AC244979A2ae9CA1e1A82899d02bbea4; 

    address whale = WHALE;

    function setUp() public {
        l = new Liquidity();
    }

    function testFailApproval() public {
        uint amountA = 5000 * 10 ** 18;
        uint256 amountB = 5000 * 10 ** 18;
        address tokenA = DAI;
        address tokenB = Y4;
        vm.startPrank(whale);
        l.addLiquidity(
          tokenA,
          tokenB,
          amountA,
          amountB
        );
        vm.stopPrank();
    }

    function testApprovalAndAddLiquidity() public {
        uint amountA = 5000 * 10 ** 18;
        uint amountB = 5000 * 10 ** 18;
        address tokenA = DAI;
        address tokenB = Y4;
        vm.startPrank(whale);
        IERC20(tokenA).approve(address(l), amountA);
        IERC20(tokenB).approve(address(l), amountB);
        l.addLiquidity(
          tokenA,
          tokenB,
          amountA,
          amountB
        );
        address pair = IUniswapV2Factory(UNISWAP_V2_FACTORY).getPair(tokenA, tokenB);
        uint liquidity = IERC20(pair).balanceOf(address(l));
        assert(liquidity > 0);
        vm.stopPrank();
    }

    function testRemoveLiquidity() public {
      uint amountA = 5000 * 10 ** 18;
      uint amountB = 5000 * 10 ** 18;
      address tokenA = DAI;
      address tokenB = Y4;
      vm.startPrank(whale);
      IERC20(tokenA).approve(address(l), amountA);
      IERC20(tokenB).approve(address(l), amountB);
      l.addLiquidity(
        tokenA,
        tokenB,
        amountA,
        amountB
      );
      address pair = IUniswapV2Factory(UNISWAP_V2_FACTORY).getPair(tokenA, tokenB);
      uint liquidityBefore = IERC20(pair).balanceOf(address(l));
      l.removeLiquidity(tokenA, tokenB);
      uint liquidityAfter = IERC20(pair).balanceOf(address(l));
      assert(liquidityBefore > liquidityAfter);
      vm.stopPrank();
    }
}
