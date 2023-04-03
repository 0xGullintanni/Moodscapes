// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import { Event } from "../src/Event.sol";
import { EventFactory } from "../src/EventFactory.sol";

contract EventTest is Test {
    address internal _event;
    EventFactory internal factory;
    address internal bob = address(0x1);
    string internal bobMinerTag = "Bob";

    function setUp() public {
        vm.deal(bob, 100 ether);
    
        factory = new EventFactory();
        _event = factory.createEvent(bob, bobMinerTag, block.timestamp + 1000000000000, "Bob's Event", "BOBSEVENT");
    }

    function testSetUp() public {
        assertEq(bob.balance, 100 ether);
        assertEq(Event(_event).host(), bob);
        assertEq(Event(_event).hostName(), bobMinerTag);
        assertEq(Event(_event).eventDateTimestamp(), block.timestamp + 1000000000000);
        assertEq(Event(_event).owner(), address(factory));
        assertEq(Event(_event).attendanceCount(), 0);
        assertEq(factory.owner(), address(this));
    }

    function testAttend() public {
        assertEq(Event(_event).host(), bob);
        assertEq(Event(_event).hostName(), bobMinerTag);
        assertEq(Event(_event).eventDateTimestamp(), block.timestamp + 1000000000000);
        assertEq(Event(_event).owner(), address(factory));
        assertEq(factory.owner(), address(this));

        Event(_event).attend(bobMinerTag);
        assertEq(Event(_event).attendanceCount(), 1);
        assertEq(Event(_event).tokenURI(1), "https://ipfs.io/ipfs/QmQZaEW3xHoh6hfG8oduZFz3gdb6AZHYRdWeBfAnZf8PXa/");

        Event(_event).attend(bobMinerTag);
        assertEq(Event(_event).attendanceCount(), 2);
        assertEq(Event(_event).tokenURI(2), "https://ipfs.io/ipfs/QmQZaEW3xHoh6hfG8oduZFz3gdb6AZHYRdWeBfAnZf8PXa/");
    }
}