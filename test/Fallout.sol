// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "forge-std/Test.sol";

contract FalloutTest is Test {
    address public fallout;
    address public owner;
    address public attacker;

    function setUp() public {
        owner = makeAddr("owner");
        startHoax(owner);
        bytes memory bytecode = abi.encodePacked(vm.getCode("Fallout.sol"));
        address addr;
        assembly {
            addr := create(1000000000, add(bytecode, 0x20), mload(bytecode))
        }
        fallout = addr;
    }

    function test() public {
        vm.stopPrank();
        startHoax(attacker);
        (bool success,) = payable(address(fallout)).call{value: 0.0001 ether}("");
        require(success, "failed to call to send ether");
    }
}
