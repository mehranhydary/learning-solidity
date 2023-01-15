// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IERC20} from 'v2-periphery/interfaces/IERC20.sol';
import {IUniswapV2Router02} from "v2-periphery/interfaces/IUniswapV2Router02.sol";
import {IUniswapV2Factory} from "v2-core/interfaces/IUniswapV2Factory.sol";

contract Liquidity {
  address private constant UNISWAP_V2_ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
  address private constant UNISWAP_V2_FACTORY = 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
  
  event LiquidityAdded(
    address tokenA,
    address tokenB,
    uint amountA,
    uint amountB
  );

  event LiquidityRemoved(
    address tokenA,
    address tokenB,
    uint liquidity,
    uint amountA,
    uint amountB
  );

  function addLiquidity(
    address _tokenA,
    address _tokenB,
    uint _amountA,
    uint _amountB
  ) external {
    IERC20(_tokenA).transferFrom(msg.sender, address(this), _amountA);
    IERC20(_tokenB).transferFrom(msg.sender, address(this), _amountB);

    IERC20(_tokenA).approve(UNISWAP_V2_ROUTER, _amountA);
    IERC20(_tokenB).approve(UNISWAP_V2_ROUTER, _amountB);

    IUniswapV2Router02(UNISWAP_V2_ROUTER).addLiquidity(
      _tokenA,
      _tokenB,
      _amountA,
      _amountB,
      1,
      1,
      address(this),
      block.timestamp
    );

    emit LiquidityAdded(_tokenA, _tokenB, _amountA, _amountB);
  }

  function removeLiquidity(address _tokenA, address _tokenB) external {
    address pair = IUniswapV2Factory(UNISWAP_V2_FACTORY).getPair(_tokenA, _tokenB);
    uint liquidity = IERC20(pair).balanceOf(address(this));
    IERC20(pair).approve(UNISWAP_V2_ROUTER, liquidity);
    (uint amountA, uint amountB) = IUniswapV2Router02(UNISWAP_V2_ROUTER).removeLiquidity(
      _tokenA,
      _tokenB,
      liquidity,
      1,
      1,
      address(this),
      block.timestamp
    );
    
    emit LiquidityRemoved(_tokenA, _tokenB, liquidity, amountA, amountB);
  }
}