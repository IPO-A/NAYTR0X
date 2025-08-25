// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.27;

import {ERC1363} from "@openzeppelin/contracts/token/ERC20/extensions/ERC1363.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Bridgeable} from "@openzeppelin/community-contracts/token/ERC20/extensions/ERC20Bridgeable.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20FlashMint} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20FlashMint.sol";
import {ERC20Pausable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {ERC20Votes} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import {Nonces} from "@openzeppelin/contracts/utils/Nonces.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @custom:security-contact 77alikhaled588@gmail.com
contract NAYTROX is ERC20, ERC20Bridgeable, ERC20Burnable, ERC20Pausable, Ownable, ERC1363, ERC20Permit, ERC20Votes, ERC20FlashMint {
    address public immutable TOKEN_BRIDGE;
    error Unauthorized();

    constructor(address tokenBridge, address recipient, address initialOwner)
        ERC20("NAYTROX", "MTX")
        Ownable(initialOwner)
        ERC20Permit("NAYTROX")
    {
        require(tokenBridge != address(0), "Invalid TOKEN_BRIDGE address");
        TOKEN_BRIDGE = tokenBridge;
        if (block.chainid == 56) {
            _mint(recipient, 25000000000000000000000000 * 10 ** decimals());
        }
    }

    function _checkTokenBridge(address caller) internal view override {
        if (caller != TOKEN_BRIDGE) revert Unauthorized();
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // The following functions are overrides required by Solidity.

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Pausable, ERC20Votes)
    {
        super._update(from, to, value);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC20Bridgeable, ERC1363)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function nonces(address owner)
        public
        view
        override(ERC20Permit, Nonces)
        returns (uint256)
    {
        return super.nonces(owner);
    }
}