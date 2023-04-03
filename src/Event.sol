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
    string public baseURI;
    
    Attendee[] public attendance;
    mapping(address => bool) hasClaimed;

    struct Attendee {
        address attendeeAddress;
        string attendeeMinerTag;
    }

    constructor(string memory baseUri, address _host, string memory _hostName, uint _eventDateTimestamp, string memory eventName, string memory eventSymbol) ERC721(eventName, eventSymbol) {
        host = _host;
        hostName = _hostName;
        eventDateTimestamp = _eventDateTimestamp;
        baseURI = baseUri;
    }

    function attend(string memory _attendeeMinerTag) public {
        require(block.timestamp <= eventDateTimestamp, "You cannot attend an event that has already happened");
        require(!hasClaimed[msg.sender], "You have already RSVP'd");
        
        attendance.push(Attendee(msg.sender, _attendeeMinerTag));
        attendanceCount++;

        hasClaimed[msg.sender] = true;

        _mint(msg.sender, attendanceCount);
        _setTokenURI(attendanceCount, baseURI);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireMinted(tokenId);

        return baseURI;
    }
}