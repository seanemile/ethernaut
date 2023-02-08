// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {CoinFlip} from "../src/CoinFlip.sol";
import "forge-std/Test.sol";

contract CoinFlipTest is Test {
    CoinFlip public coinFlip;
    uint256 constant FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function setUp() public {
        coinFlip = new CoinFlip();
    }

    function testFlip() public {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 _coinFlip = blockValue / FACTOR;
        bool side = _coinFlip == 1 ? true : false;
        bool success = coinFlip.flip(side);
        assertTrue(success);
        vm.roll(100);
        blockValue = uint256(blockhash( 100 - 1));
         _coinFlip = blockValue / FACTOR;
        side = _coinFlip == 1 ? true : false;
        success = coinFlip.flip(side);
        assertTrue(success);
    }
}
