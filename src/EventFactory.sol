// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.8.0) (token/ERC20/ERC20.sol)

pragma solidity ^0.8.0;

import { Event } from './Event.sol';
import { Ownable } from './Ownable.sol';

contract EventFactory is Ownable {
    address[] public events;

    constructor() {}

    function createEvent(address _host, string calldata _hostName, uint eventDateTimestamp, string memory memoryCardName, string memory memoryCardSymbol) public returns(address) {
        require(_host != address(0), "Token address cannot be 0x0");
        require(eventDateTimestamp >= block.timestamp, "You cannot create an event in the past");

        Event _event = new Event(_host, _hostName, eventDateTimestamp, memoryCardName, memoryCardSymbol);
        events.push(address(_event));

        return address(_event);
    }

}