// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {SafeMath} from "openzeppelin-contracts/math/SafeMath.sol";
import {FlashLoanReceiverBase} from "aave-v3-core/flashloan/base/FlashLoanReceiverBase.sol";

contract FlashLoan is FlashLoanReceiverBase {
  using SafeMath for uint;

  constructor(IPoolAddressesProvider _addressProvider)
    public
    FlashLoanReceiverBase(_addressProvider)
  {}

  function testFlashLoan(address asset, uint amount) external {
    uint balance = IERC20(asset).balanceOf(address(this));
    require(balance > amount, "Balance should be higher than amount");
    address receiver = address(this);

    address[] memory amounts = new uint[](1);
    amounts[0] = amount;
    // 0 = no debt, 1 = stable, 2 = variable
    // 0 = pay all loans 
    uint [] memory modes = new uint[](1);
    modes[0] = 0;

    address onBehalfOf = address(this);

    bytes memory params = ""; // extra data to pass abi.encode(...)
    uint16 referralCode = 0;

    POOL.flashLoan(
      receiver,
      assets,
      amounts,
      modes,
      onBehalfOf, // This gets the debt if mode is 1 or 2
      params,
      referralCode
    );
  }

  function executeOperation(
    address[] calldata assets,
    uint[] calldata amounts,
    uint[] calldata premiums,
    address initiator,
    bytes calldata params
  ) external override returns (bool) {
    // Do stuff here (arbitrage, liqudation, etc.)
    // abi.decode(params) here to decode your params
    for (uint i = 0; i < assets.length; i++) {
      emit Log("borrowed", amounts[i]);
      emit Log("fee", premiums[i]);

      uint amountOwning = amounts[i].add(premiums[i]);
      IERC20(assets[i]).approve(address(POOL), amountOwning);
    }
    return true;
  }
}