// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "forge-std/Test.sol";

import "../src/Force.sol";

contract Destory {
    function destroy(address payable _address) public payable {
        selfdestruct(_address);
    }
}

contract ForceTest is Test {
    Force public force;
    Destory public destroy;

    function setUp() public {
        force = new Force();
        destroy = new Destory();
    }

    function testForce() public {
        destroy.destroy{value: 1 ether}(payable(address(force)));
        assertEq(address(force).balance, 1 ether);
    }
}
