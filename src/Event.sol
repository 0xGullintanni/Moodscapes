// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.8.0) (token/ERC20/ERC20.sol)

pragma solidity ^0.8.13;


import { ERC721 } from './ERC721.sol';
import { Ownable } from './Ownable.sol';
import { ERC721URIStorage } from './ERC721URIStorage.sol';

contract Event is ERC721URIStorage, Ownable {
    uint256 public attendanceCount;
    uint256 public eventDateTimestamp;
    address public host;
    string public hostName;
    
    Attendee[] public attendance;

    struct Attendee {
        address attendeeAddress;
        string attendeeMinerTag;
    }

    constructor(address _host, string memory _hostName, uint _eventDateTimestamp, string memory eventName, string memory eventSymbol) ERC721(eventName, eventSymbol) {
        host = _host;
        hostName = _hostName;
        eventDateTimestamp = _eventDateTimestamp;
    }

    function attend(string memory _attendeeMinerTag) public {
        require(block.timestamp <= eventDateTimestamp, "You cannot attend an event that has already happened");
        attendance.push(Attendee(msg.sender, _attendeeMinerTag));
        attendanceCount++;

        _mint(msg.sender, attendanceCount);
        _setTokenURI(attendanceCount, _baseURI());
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/QmQZaEW3xHoh6hfG8oduZFz3gdb6AZHYRdWeBfAnZf8PXa";
    }
}