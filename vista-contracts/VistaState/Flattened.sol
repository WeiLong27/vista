// Sources flattened with hardhat v2.19.4 https://hardhat.org

// SPDX-License-Identifier: MIT AND UNLICENSED

// File @openzeppelin/contracts/access/IAccessControl.sol

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (access/IAccessControl.sol)

pragma solidity ^0.8.0;

/**
 * @dev External interface of AccessControl declared to support ERC165 detection.
 */
interface IAccessControl {
    /**
     * @dev Emitted when `newAdminRole` is set as ``role``'s admin role, replacing `previousAdminRole`
     *
     * `DEFAULT_ADMIN_ROLE` is the starting admin for all roles, despite
     * {RoleAdminChanged} not being emitted signaling this.
     *
     * _Available since v3.1._
     */
    event RoleAdminChanged(bytes32 indexed role, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole);

    /**
     * @dev Emitted when `account` is granted `role`.
     *
     * `sender` is the account that originated the contract call, an admin role
     * bearer except when using {AccessControl-_setupRole}.
     */
    event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);

    /**
     * @dev Emitted when `account` is revoked `role`.
     *
     * `sender` is the account that originated the contract call:
     *   - if using `revokeRole`, it is the admin role bearer
     *   - if using `renounceRole`, it is the role bearer (i.e. `account`)
     */
    event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);

    /**
     * @dev Returns `true` if `account` has been granted `role`.
     */
    function hasRole(bytes32 role, address account) external view returns (bool);

    /**
     * @dev Returns the admin role that controls `role`. See {grantRole} and
     * {revokeRole}.
     *
     * To change a role's admin, use {AccessControl-_setRoleAdmin}.
     */
    function getRoleAdmin(bytes32 role) external view returns (bytes32);

    /**
     * @dev Grants `role` to `account`.
     *
     * If `account` had not been already granted `role`, emits a {RoleGranted}
     * event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     */
    function grantRole(bytes32 role, address account) external;

    /**
     * @dev Revokes `role` from `account`.
     *
     * If `account` had been granted `role`, emits a {RoleRevoked} event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     */
    function revokeRole(bytes32 role, address account) external;

    /**
     * @dev Revokes `role` from the calling account.
     *
     * Roles are often managed via {grantRole} and {revokeRole}: this function's
     * purpose is to provide a mechanism for accounts to lose their privileges
     * if they are compromised (such as when a trusted device is misplaced).
     *
     * If the calling account had been granted `role`, emits a {RoleRevoked}
     * event.
     *
     * Requirements:
     *
     * - the caller must be `account`.
     */
    function renounceRole(bytes32 role, address account) external;
}


// File @openzeppelin/contracts/utils/Context.sol

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}


// File @openzeppelin/contracts/utils/introspection/IERC165.sol

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/introspection/IERC165.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}


// File @openzeppelin/contracts/utils/introspection/ERC165.sol

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/introspection/ERC165.sol)

pragma solidity ^0.8.0;

/**
 * @dev Implementation of the {IERC165} interface.
 *
 * Contracts that want to implement ERC165 should inherit from this contract and override {supportsInterface} to check
 * for the additional interface id that will be supported. For example:
 *
 * ```solidity
 * function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
 *     return interfaceId == type(MyInterface).interfaceId || super.supportsInterface(interfaceId);
 * }
 * ```
 *
 * Alternatively, {ERC165Storage} provides an easier to use but more expensive implementation.
 */
abstract contract ERC165 is IERC165 {
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == type(IERC165).interfaceId;
    }
}


// File @openzeppelin/contracts/utils/math/Math.sol

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v4.8.0) (utils/math/Math.sol)

pragma solidity ^0.8.0;

/**
 * @dev Standard math utilities missing in the Solidity language.
 */
library Math {
    enum Rounding {
        Down, // Toward negative infinity
        Up, // Toward infinity
        Zero // Toward zero
    }

    /**
     * @dev Returns the largest of two numbers.
     */
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a > b ? a : b;
    }

    /**
     * @dev Returns the smallest of two numbers.
     */
    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }

    /**
     * @dev Returns the average of two numbers. The result is rounded towards
     * zero.
     */
    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        // (a + b) / 2 can overflow.
        return (a & b) + (a ^ b) / 2;
    }

    /**
     * @dev Returns the ceiling of the division of two numbers.
     *
     * This differs from standard division with `/` in that it rounds up instead
     * of rounding down.
     */
    function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        // (a + b - 1) / b can overflow on addition, so we distribute.
        return a == 0 ? 0 : (a - 1) / b + 1;
    }

    /**
     * @notice Calculates floor(x * y / denominator) with full precision. Throws if result overflows a uint256 or denominator == 0
     * @dev Original credit to Remco Bloemen under MIT license (https://xn--2-umb.com/21/muldiv)
     * with further edits by Uniswap Labs also under MIT license.
     */
    function mulDiv(
        uint256 x,
        uint256 y,
        uint256 denominator
    ) internal pure returns (uint256 result) {
        unchecked {
            // 512-bit multiply [prod1 prod0] = x * y. Compute the product mod 2^256 and mod 2^256 - 1, then use
            // use the Chinese Remainder Theorem to reconstruct the 512 bit result. The result is stored in two 256
            // variables such that product = prod1 * 2^256 + prod0.
            uint256 prod0; // Least significant 256 bits of the product
            uint256 prod1; // Most significant 256 bits of the product
            assembly {
                let mm := mulmod(x, y, not(0))
                prod0 := mul(x, y)
                prod1 := sub(sub(mm, prod0), lt(mm, prod0))
            }

            // Handle non-overflow cases, 256 by 256 division.
            if (prod1 == 0) {
                return prod0 / denominator;
            }

            // Make sure the result is less than 2^256. Also prevents denominator == 0.
            require(denominator > prod1);

            ///////////////////////////////////////////////
            // 512 by 256 division.
            ///////////////////////////////////////////////

            // Make division exact by subtracting the remainder from [prod1 prod0].
            uint256 remainder;
            assembly {
                // Compute remainder using mulmod.
                remainder := mulmod(x, y, denominator)

                // Subtract 256 bit number from 512 bit number.
                prod1 := sub(prod1, gt(remainder, prod0))
                prod0 := sub(prod0, remainder)
            }

            // Factor powers of two out of denominator and compute largest power of two divisor of denominator. Always >= 1.
            // See https://cs.stackexchange.com/q/138556/92363.

            // Does not overflow because the denominator cannot be zero at this stage in the function.
            uint256 twos = denominator & (~denominator + 1);
            assembly {
                // Divide denominator by twos.
                denominator := div(denominator, twos)

                // Divide [prod1 prod0] by twos.
                prod0 := div(prod0, twos)

                // Flip twos such that it is 2^256 / twos. If twos is zero, then it becomes one.
                twos := add(div(sub(0, twos), twos), 1)
            }

            // Shift in bits from prod1 into prod0.
            prod0 |= prod1 * twos;

            // Invert denominator mod 2^256. Now that denominator is an odd number, it has an inverse modulo 2^256 such
            // that denominator * inv = 1 mod 2^256. Compute the inverse by starting with a seed that is correct for
            // four bits. That is, denominator * inv = 1 mod 2^4.
            uint256 inverse = (3 * denominator) ^ 2;

            // Use the Newton-Raphson iteration to improve the precision. Thanks to Hensel's lifting lemma, this also works
            // in modular arithmetic, doubling the correct bits in each step.
            inverse *= 2 - denominator * inverse; // inverse mod 2^8
            inverse *= 2 - denominator * inverse; // inverse mod 2^16
            inverse *= 2 - denominator * inverse; // inverse mod 2^32
            inverse *= 2 - denominator * inverse; // inverse mod 2^64
            inverse *= 2 - denominator * inverse; // inverse mod 2^128
            inverse *= 2 - denominator * inverse; // inverse mod 2^256

            // Because the division is now exact we can divide by multiplying with the modular inverse of denominator.
            // This will give us the correct result modulo 2^256. Since the preconditions guarantee that the outcome is
            // less than 2^256, this is the final result. We don't need to compute the high bits of the result and prod1
            // is no longer required.
            result = prod0 * inverse;
            return result;
        }
    }

    /**
     * @notice Calculates x * y / denominator with full precision, following the selected rounding direction.
     */
    function mulDiv(
        uint256 x,
        uint256 y,
        uint256 denominator,
        Rounding rounding
    ) internal pure returns (uint256) {
        uint256 result = mulDiv(x, y, denominator);
        if (rounding == Rounding.Up && mulmod(x, y, denominator) > 0) {
            result += 1;
        }
        return result;
    }

    /**
     * @dev Returns the square root of a number. If the number is not a perfect square, the value is rounded down.
     *
     * Inspired by Henry S. Warren, Jr.'s "Hacker's Delight" (Chapter 11).
     */
    function sqrt(uint256 a) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        // For our first guess, we get the biggest power of 2 which is smaller than the square root of the target.
        //
        // We know that the "msb" (most significant bit) of our target number `a` is a power of 2 such that we have
        // `msb(a) <= a < 2*msb(a)`. This value can be written `msb(a)=2**k` with `k=log2(a)`.
        //
        // This can be rewritten `2**log2(a) <= a < 2**(log2(a) + 1)`
        // → `sqrt(2**k) <= sqrt(a) < sqrt(2**(k+1))`
        // → `2**(k/2) <= sqrt(a) < 2**((k+1)/2) <= 2**(k/2 + 1)`
        //
        // Consequently, `2**(log2(a) / 2)` is a good first approximation of `sqrt(a)` with at least 1 correct bit.
        uint256 result = 1 << (log2(a) >> 1);

        // At this point `result` is an estimation with one bit of precision. We know the true value is a uint128,
        // since it is the square root of a uint256. Newton's method converges quadratically (precision doubles at
        // every iteration). We thus need at most 7 iteration to turn our partial result with one bit of precision
        // into the expected uint128 result.
        unchecked {
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            return min(result, a / result);
        }
    }

    /**
     * @notice Calculates sqrt(a), following the selected rounding direction.
     */
    function sqrt(uint256 a, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = sqrt(a);
            return result + (rounding == Rounding.Up && result * result < a ? 1 : 0);
        }
    }

    /**
     * @dev Return the log in base 2, rounded down, of a positive value.
     * Returns 0 if given 0.
     */
    function log2(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >> 128 > 0) {
                value >>= 128;
                result += 128;
            }
            if (value >> 64 > 0) {
                value >>= 64;
                result += 64;
            }
            if (value >> 32 > 0) {
                value >>= 32;
                result += 32;
            }
            if (value >> 16 > 0) {
                value >>= 16;
                result += 16;
            }
            if (value >> 8 > 0) {
                value >>= 8;
                result += 8;
            }
            if (value >> 4 > 0) {
                value >>= 4;
                result += 4;
            }
            if (value >> 2 > 0) {
                value >>= 2;
                result += 2;
            }
            if (value >> 1 > 0) {
                result += 1;
            }
        }
        return result;
    }

    /**
     * @dev Return the log in base 2, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log2(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log2(value);
            return result + (rounding == Rounding.Up && 1 << result < value ? 1 : 0);
        }
    }

    /**
     * @dev Return the log in base 10, rounded down, of a positive value.
     * Returns 0 if given 0.
     */
    function log10(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >= 10**64) {
                value /= 10**64;
                result += 64;
            }
            if (value >= 10**32) {
                value /= 10**32;
                result += 32;
            }
            if (value >= 10**16) {
                value /= 10**16;
                result += 16;
            }
            if (value >= 10**8) {
                value /= 10**8;
                result += 8;
            }
            if (value >= 10**4) {
                value /= 10**4;
                result += 4;
            }
            if (value >= 10**2) {
                value /= 10**2;
                result += 2;
            }
            if (value >= 10**1) {
                result += 1;
            }
        }
        return result;
    }

    /**
     * @dev Return the log in base 10, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log10(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log10(value);
            return result + (rounding == Rounding.Up && 10**result < value ? 1 : 0);
        }
    }

    /**
     * @dev Return the log in base 256, rounded down, of a positive value.
     * Returns 0 if given 0.
     *
     * Adding one to the result gives the number of pairs of hex symbols needed to represent `value` as a hex string.
     */
    function log256(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >> 128 > 0) {
                value >>= 128;
                result += 16;
            }
            if (value >> 64 > 0) {
                value >>= 64;
                result += 8;
            }
            if (value >> 32 > 0) {
                value >>= 32;
                result += 4;
            }
            if (value >> 16 > 0) {
                value >>= 16;
                result += 2;
            }
            if (value >> 8 > 0) {
                result += 1;
            }
        }
        return result;
    }

    /**
     * @dev Return the log in base 10, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    function log256(uint256 value, Rounding rounding) internal pure returns (uint256) {
        unchecked {
            uint256 result = log256(value);
            return result + (rounding == Rounding.Up && 1 << (result * 8) < value ? 1 : 0);
        }
    }
}


// File @openzeppelin/contracts/utils/Strings.sol

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v4.8.0) (utils/Strings.sol)

pragma solidity ^0.8.0;

/**
 * @dev String operations.
 */
library Strings {
    bytes16 private constant _SYMBOLS = "0123456789abcdef";
    uint8 private constant _ADDRESS_LENGTH = 20;

    /**
     * @dev Converts a `uint256` to its ASCII `string` decimal representation.
     */
    function toString(uint256 value) internal pure returns (string memory) {
        unchecked {
            uint256 length = Math.log10(value) + 1;
            string memory buffer = new string(length);
            uint256 ptr;
            /// @solidity memory-safe-assembly
            assembly {
                ptr := add(buffer, add(32, length))
            }
            while (true) {
                ptr--;
                /// @solidity memory-safe-assembly
                assembly {
                    mstore8(ptr, byte(mod(value, 10), _SYMBOLS))
                }
                value /= 10;
                if (value == 0) break;
            }
            return buffer;
        }
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
     */
    function toHexString(uint256 value) internal pure returns (string memory) {
        unchecked {
            return toHexString(value, Math.log256(value) + 1);
        }
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
     */
    function toHexString(uint256 value, uint256 length) internal pure returns (string memory) {
        bytes memory buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = _SYMBOLS[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Strings: hex length insufficient");
        return string(buffer);
    }

    /**
     * @dev Converts an `address` with fixed length of 20 bytes to its not checksummed ASCII `string` hexadecimal representation.
     */
    function toHexString(address addr) internal pure returns (string memory) {
        return toHexString(uint256(uint160(addr)), _ADDRESS_LENGTH);
    }
}


// File @openzeppelin/contracts/access/AccessControl.sol

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v4.8.0) (access/AccessControl.sol)

pragma solidity ^0.8.0;




/**
 * @dev Contract module that allows children to implement role-based access
 * control mechanisms. This is a lightweight version that doesn't allow enumerating role
 * members except through off-chain means by accessing the contract event logs. Some
 * applications may benefit from on-chain enumerability, for those cases see
 * {AccessControlEnumerable}.
 *
 * Roles are referred to by their `bytes32` identifier. These should be exposed
 * in the external API and be unique. The best way to achieve this is by
 * using `public constant` hash digests:
 *
 * ```
 * bytes32 public constant MY_ROLE = keccak256("MY_ROLE");
 * ```
 *
 * Roles can be used to represent a set of permissions. To restrict access to a
 * function call, use {hasRole}:
 *
 * ```
 * function foo() public {
 *     require(hasRole(MY_ROLE, msg.sender));
 *     ...
 * }
 * ```
 *
 * Roles can be granted and revoked dynamically via the {grantRole} and
 * {revokeRole} functions. Each role has an associated admin role, and only
 * accounts that have a role's admin role can call {grantRole} and {revokeRole}.
 *
 * By default, the admin role for all roles is `DEFAULT_ADMIN_ROLE`, which means
 * that only accounts with this role will be able to grant or revoke other
 * roles. More complex role relationships can be created by using
 * {_setRoleAdmin}.
 *
 * WARNING: The `DEFAULT_ADMIN_ROLE` is also its own admin: it has permission to
 * grant and revoke this role. Extra precautions should be taken to secure
 * accounts that have been granted it.
 */
abstract contract AccessControl is Context, IAccessControl, ERC165 {
    struct RoleData {
        mapping(address => bool) members;
        bytes32 adminRole;
    }

    mapping(bytes32 => RoleData) private _roles;

    bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;

    /**
     * @dev Modifier that checks that an account has a specific role. Reverts
     * with a standardized message including the required role.
     *
     * The format of the revert reason is given by the following regular expression:
     *
     *  /^AccessControl: account (0x[0-9a-f]{40}) is missing role (0x[0-9a-f]{64})$/
     *
     * _Available since v4.1._
     */
    modifier onlyRole(bytes32 role) {
        _checkRole(role);
        _;
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == type(IAccessControl).interfaceId || super.supportsInterface(interfaceId);
    }

    /**
     * @dev Returns `true` if `account` has been granted `role`.
     */
    function hasRole(bytes32 role, address account) public view virtual override returns (bool) {
        return _roles[role].members[account];
    }

    /**
     * @dev Revert with a standard message if `_msgSender()` is missing `role`.
     * Overriding this function changes the behavior of the {onlyRole} modifier.
     *
     * Format of the revert message is described in {_checkRole}.
     *
     * _Available since v4.6._
     */
    function _checkRole(bytes32 role) internal view virtual {
        _checkRole(role, _msgSender());
    }

    /**
     * @dev Revert with a standard message if `account` is missing `role`.
     *
     * The format of the revert reason is given by the following regular expression:
     *
     *  /^AccessControl: account (0x[0-9a-f]{40}) is missing role (0x[0-9a-f]{64})$/
     */
    function _checkRole(bytes32 role, address account) internal view virtual {
        if (!hasRole(role, account)) {
            revert(
                string(
                    abi.encodePacked(
                        "AccessControl: account ",
                        Strings.toHexString(account),
                        " is missing role ",
                        Strings.toHexString(uint256(role), 32)
                    )
                )
            );
        }
    }

    /**
     * @dev Returns the admin role that controls `role`. See {grantRole} and
     * {revokeRole}.
     *
     * To change a role's admin, use {_setRoleAdmin}.
     */
    function getRoleAdmin(bytes32 role) public view virtual override returns (bytes32) {
        return _roles[role].adminRole;
    }

    /**
     * @dev Grants `role` to `account`.
     *
     * If `account` had not been already granted `role`, emits a {RoleGranted}
     * event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     *
     * May emit a {RoleGranted} event.
     */
    function grantRole(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role)) {
        _grantRole(role, account);
    }

    /**
     * @dev Revokes `role` from `account`.
     *
     * If `account` had been granted `role`, emits a {RoleRevoked} event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     *
     * May emit a {RoleRevoked} event.
     */
    function revokeRole(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role)) {
        _revokeRole(role, account);
    }

    /**
     * @dev Revokes `role` from the calling account.
     *
     * Roles are often managed via {grantRole} and {revokeRole}: this function's
     * purpose is to provide a mechanism for accounts to lose their privileges
     * if they are compromised (such as when a trusted device is misplaced).
     *
     * If the calling account had been revoked `role`, emits a {RoleRevoked}
     * event.
     *
     * Requirements:
     *
     * - the caller must be `account`.
     *
     * May emit a {RoleRevoked} event.
     */
    function renounceRole(bytes32 role, address account) public virtual override {
        require(account == _msgSender(), "AccessControl: can only renounce roles for self");

        _revokeRole(role, account);
    }

    /**
     * @dev Grants `role` to `account`.
     *
     * If `account` had not been already granted `role`, emits a {RoleGranted}
     * event. Note that unlike {grantRole}, this function doesn't perform any
     * checks on the calling account.
     *
     * May emit a {RoleGranted} event.
     *
     * [WARNING]
     * ====
     * This function should only be called from the constructor when setting
     * up the initial roles for the system.
     *
     * Using this function in any other way is effectively circumventing the admin
     * system imposed by {AccessControl}.
     * ====
     *
     * NOTE: This function is deprecated in favor of {_grantRole}.
     */
    function _setupRole(bytes32 role, address account) internal virtual {
        _grantRole(role, account);
    }

    /**
     * @dev Sets `adminRole` as ``role``'s admin role.
     *
     * Emits a {RoleAdminChanged} event.
     */
    function _setRoleAdmin(bytes32 role, bytes32 adminRole) internal virtual {
        bytes32 previousAdminRole = getRoleAdmin(role);
        _roles[role].adminRole = adminRole;
        emit RoleAdminChanged(role, previousAdminRole, adminRole);
    }

    /**
     * @dev Grants `role` to `account`.
     *
     * Internal function without access restriction.
     *
     * May emit a {RoleGranted} event.
     */
    function _grantRole(bytes32 role, address account) internal virtual {
        if (!hasRole(role, account)) {
            _roles[role].members[account] = true;
            emit RoleGranted(role, account, _msgSender());
        }
    }

    /**
     * @dev Revokes `role` from `account`.
     *
     * Internal function without access restriction.
     *
     * May emit a {RoleRevoked} event.
     */
    function _revokeRole(bytes32 role, address account) internal virtual {
        if (hasRole(role, account)) {
            _roles[role].members[account] = false;
            emit RoleRevoked(role, account, _msgSender());
        }
    }
}


// File @openzeppelin/contracts/token/ERC20/IERC20.sol

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}


// File @openzeppelin/contracts/interfaces/IERC20.sol

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (interfaces/IERC20.sol)

pragma solidity ^0.8.0;


// File contracts/Structs.sol

// Original license: SPDX_License_Identifier: UNLICENSED
pragma solidity ^0.8.17;

enum OptionBarrierType {
    None,
    KnockIn
}

struct Deposit {
    uint256 amount;
    address receiver;
}

struct Withdrawal {
    uint256 amountShares;
    address receiver;
}

enum VaultStatus {
    DepositsClosed,
    DepositsOpen,
    NotTraded,
    Traded,
    TradeExpired,
    PayoffCalculated,
    FeesCollected,
    WithdrawalQueueProcessed,
    Zombie
}

struct OptionBarrier {
    uint256 barrierBps;
    uint256 barrierAbsoluteValue;
    uint256 strikeBps;
    uint256 strikeAbsoluteValue;
    string asset;
    string oracleName;
    OptionBarrierType barrierType;
}

struct SP0VaultMetadata {
    uint256 vaultStart;
    uint256 tradeDate;
    uint256 tradeExpiry;
    uint256 aprBps;
    uint256 tenorInDays;
    uint256 underlyingAmount; // This is how many assets were ever deposited into the vault
    uint256 currentAssetAmount; // This is how many assets are currently allocated for the vault (not sent for trade)
    uint256 totalCouponPayoff;
    uint256 vaultFinalPayoff;
    uint256 queuedWithdrawalsSharesAmount;
    uint256 queuedWithdrawalsCount;
    uint256 optionBarriersCount;
    uint256 leverage;
    address vaultAddress;
    VaultStatus vaultStatus;
    bool isKnockedIn;
    OptionBarrier[] optionBarriers;
}

struct RoundData {
    int256 answer;
    uint256 startedAt;
    uint256 updatedAt;
    uint80 answeredInRound;
}


// File contracts/interfaces/ISP0Product.sol

// Original license: SPDX_License_Identifier: UNLICENSED
pragma solidity ^0.8.17;

interface ISP0Product {
    function vistaState() external view returns (address);

    function asset() external view returns (address);

    function name() external view returns (string memory);

    function managementFeeBps() external view returns (uint256);

    function yieldFeeBps() external view returns (uint256);

    function isDepositQueueOpen() external view returns (bool);

    function maxDepositAmountLimit() external view returns (uint256);

    function sumVaultUnderlyingAmounts() external view returns (uint256);

    function queuedDepositsTotalAmount() external view returns (uint256);

    function queuedDepositsCount() external view returns (uint256);

    function vaults(
        address vaultAddress
    )
        external
        view
        returns (
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            address,
            VaultStatus,
            bool
        );

    function vaultAddresses() external view returns (address[] memory);

    function depositQueue() external view returns (Deposit[] memory);

    function withdrawalQueues(
        address vaultAddress
    ) external view returns (Withdrawal[] memory);

    function isValidVault(address vaultAddress) external view returns (bool);

    function getVaultAddresses() external view returns (address[] memory);

    function setManagementFeeBps(uint256 _managementFeeBps) external;

    function setYieldFeeBps(uint256 _yieldFeeBps) external;

    function setMaxDepositAmountLimit(uint256 _maxDepositAmountLimit) external;

    function createVault(
        string memory _tokenName,
        string memory _tokenSymbol,
        uint256 _vaultStart
    ) external returns (address vaultAddress);

    function setVaultMetadata(
        address vaultAddress,
        SP0VaultMetadata calldata metadata
    ) external;

    function removeVault(address vaultAddress) external;

    function setTradeData(
        address vaultAddress,
        uint256 _tradeDate,
        uint256 _tradeExpiry,
        uint256 _aprBps,
        uint256 _tenorInDays
    ) external;

    function addOptionBarrier(
        address vaultAddress,
        OptionBarrier calldata optionBarrier
    ) external;

    function getOptionBarriers(
        address vaultAddress
    ) external view returns (OptionBarrier[] memory);

    function getOptionBarrier(
        address vaultAddress,
        uint256 index
    ) external view returns (OptionBarrier memory);

    function updateOptionBarrier(
        address vaultAddress,
        uint256 index,
        string calldata _asset,
        uint256 _strikeAbsoluteValue,
        uint256 _barrierAbsoluteValue
    ) external;

    function updateOptionBarrierOracle(
        address vaultAddress,
        uint256 index,
        string calldata _asset,
        string memory newOracleName
    ) external;

    function removeOptionBarrier(
        address vaultAddress,
        uint256 index,
        string calldata _asset
    ) external;

    function setVaultStatus(
        address vaultAddress,
        VaultStatus _vaultStatus
    ) external;

    function openVaultDeposits(address vaultAddress) external;

    function setKnockInStatus(address vaultAddress, bool newState) external;

    function addToDepositQueue(uint256 amount, address receiver) external;

    function processDepositQueue(
        address vaultAddress,
        uint256 maxProcessCount
    ) external;

    function addToWithdrawalQueue(
        address vaultAddress,
        uint256 amountShares,
        address receiver
    ) external;

    function checkBarriers(address vaultAddress) external;

    function calculateVaultFinalPayoff(
        address vaultAddress
    ) external returns (uint256 vaultFinalPayoff);

    function calculateKnockInRatio(
        address vaultAddress
    ) external view returns (uint256 knockInRatio);

    function receiveAssetsFromVistaState(
        address vaultAddress,
        uint256 amount
    ) external;

    function calculateFees(
        address vaultAddress
    )
        external
        view
        returns (uint256 totalFee, uint256 managementFee, uint256 yieldFee);

    function collectFees(address vaultAddress) external;

    function processWithdrawalQueue(
        address vaultAddress,
        uint256 maxProcessCount
    ) external;

    function rolloverVault(address vaultAddress) external;

    function sendAssetsToTrade(
        address vaultAddress,
        address receiver,
        uint256 amount
    ) external;

    function calculateCurrentYield(address vaultAddress) external;

    function getVaultMetadata(
        address vaultAddress
    ) external view returns (SP0VaultMetadata memory);
}


// File contracts/VistaState.sol

// Original license: SPDX_License_Identifier: UNLICENSED
pragma solidity ^0.8.17;


contract VistaState is AccessControl {
    // Create a new role identifier for the admin roles
    bytes32 public constant OPERATOR_ADMIN_ROLE =
        keccak256("OPERATOR_ADMIN_ROLE");
    bytes32 public constant TRADER_ADMIN_ROLE = keccak256("TRADER_ADMIN_ROLE");
    bytes32 public constant SERVICE_ADMIN_ROLE =
        keccak256("SERVICE_ADMIN_ROLE");

    event SP0ProductViewerUpdated(address indexed sp0ProductViewerAddress);
    event OracleAdded(string indexed oracleName, address indexed oracleAddress);
    event OracleRemoved(string indexed oracleName);
    event ProductAdded(
        string indexed productName,
        address indexed productAddress
    );
    event ProductRemoved(string indexed productName);
    event MarketMakerPermissionUpdated(
        address indexed marketMaker,
        bool indexed allow
    );
    event FeeRecipientUpdated(address indexed feeRecipient);
    event AssetsMovedToProduct(
        string indexed productName,
        address indexed vaultAddress,
        uint256 amount
    );

    mapping(address => bool) public marketMakerAllowList;
    mapping(string => address) public products;
    mapping(string => address) public oracleAddresses;

    string[] public oracleNames;
    string[] public productNames;
    address public feeRecipient;

    // Store this address for lookup on SDK side
    address public sp0ProductViewerAddress;

    /**
     * @notice VistaState contructor that sets up the admin roles
     * @param _operatorAdmin is the address of the operator admin
     * @param _traderAdmin is the address of the trader admin
     * @param _serviceAdmin is the address of the service admin
     */
    constructor(
        address _operatorAdmin,
        address _traderAdmin,
        address _serviceAdmin
    ) {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(OPERATOR_ADMIN_ROLE, _operatorAdmin);
        _setupRole(TRADER_ADMIN_ROLE, _traderAdmin);
        _setupRole(SERVICE_ADMIN_ROLE, _serviceAdmin);
    }

    /**
     * @notice Only operator admin can set the viewer address. SDK uses this to lookup viewer address
     * @param _sp0ProductViewerAddress is the address of the viewer contract
     */
    function setSP0ProductViewerAddress(
        address _sp0ProductViewerAddress
    ) public onlyRole(OPERATOR_ADMIN_ROLE) {
        sp0ProductViewerAddress = _sp0ProductViewerAddress;
        emit SP0ProductViewerUpdated(_sp0ProductViewerAddress);
    }

    /**
     * @notice Asserts whether the sender has the DEFAULT_ADMIN_ROLE
     * @param sender is the address to be checked
     */
    function isDefaultAdmin(address sender) public view returns (bool) {
        return hasRole(DEFAULT_ADMIN_ROLE, sender);
    }

    /**
     * @notice Asserts whether the sender has the TRADER_ADMIN_ROLE
     * @param sender is the address to be checked
     */
    function isTraderAdmin(address sender) public view returns (bool) {
        return hasRole(TRADER_ADMIN_ROLE, sender);
    }

    /**
     * @notice Asserts whether the sender has the OPERATOR_ADMIN_ROLE
     * @param sender is the address to be checked
     */
    function isOperatorAdmin(address sender) public view returns (bool) {
        return hasRole(OPERATOR_ADMIN_ROLE, sender);
    }

    /**
     * @notice Asserts whether the sender has the SERVICE_ADMIN_ROLE
     * @param sender is the address of callee
     */
    function isServiceAdmin(address sender) public view returns (bool) {
        return hasRole(SERVICE_ADMIN_ROLE, sender);
    }

    /**
     * @notice Returns all oracle names (ex: "BTC/USD,PYTH")
     */
    function getOracleNames() public view returns (string[] memory) {
        return oracleNames;
    }

    /**
     * @notice Operator admin has ability to add a new oracle
     * @param oracleName is the name of the new oracle (ex: "BTC/USD,PYTH")
     * @param oracleAddress is the address of the oracle
     */
    function addOracle(
        string memory oracleName,
        address oracleAddress
    ) public onlyRole(OPERATOR_ADMIN_ROLE) {
        require(oracleAddress != address(0), "400:IA");
        if (oracleAddresses[oracleName] == address(0)) {
            oracleNames.push(oracleName);
        }
        oracleAddresses[oracleName] = oracleAddress;
        emit OracleAdded(oracleName, oracleAddress);
    }

    /**
     * @notice Operator admin has ability to remove oracle
     * @param oracleName is the name of the oracle to be removed
     */
    function removeOracle(
        string memory oracleName
    ) public onlyRole(OPERATOR_ADMIN_ROLE) {
        bool found = false;
        uint256 index = 0;
        for (uint256 i = 0; i < oracleNames.length; i++) {
            if (
                keccak256(abi.encodePacked(oracleNames[i])) ==
                keccak256(abi.encodePacked(oracleName))
            ) {
                index = i;
                found = true;
                break;
            }
        }
        if (found) {
            // Swap last element with element at index, then pop to delete oracle
            oracleNames[index] = oracleNames[oracleNames.length - 1];
            oracleNames.pop();
            delete oracleAddresses[oracleName];
            emit OracleRemoved(oracleName);
        }
    }

    /**
     * @notice Returns all product names
     */
    function getProductNames() public view returns (string[] memory) {
        return productNames;
    }

    /**
     * @notice Operator admin has the ability to create a new product
     * @param productName is the name of the new product
     * @param product is the address of the product
     */
    function addProduct(
        string memory productName,
        address product
    ) public onlyRole(OPERATOR_ADMIN_ROLE) {
        require(product != address(0), "400:IA");
        if (products[productName] == address(0)) {
            productNames.push(productName);
        }
        products[productName] = product;
        emit ProductAdded(productName, product);
    }

    /**
     * @notice Operator admin has the ability to remove products
     * @param productName is the name of the product to be removed
     */
    function removeProduct(
        string memory productName
    ) public onlyRole(OPERATOR_ADMIN_ROLE) {
        bool found = false;
        uint256 index = 0;
        for (uint256 i = 0; i < productNames.length; i++) {
            if (
                keccak256(abi.encodePacked(productNames[i])) ==
                keccak256(abi.encodePacked(productName))
            ) {
                index = i;
                found = true;
            }
        }
        if (found) {
            // Swap last element with element at index, then pop to delete product
            productNames[index] = productNames[productNames.length - 1];
            productNames.pop();
            delete products[productName];
            emit ProductRemoved(productName);
        }
    }

    /**
     * @notice Operator admin can toggle whether trade with market maker
     * @param marketMaker is the address of the market maker
     * @param allow is whether funds can be sent to that market maker
     */
    function updateMarketMakerPermission(
        address marketMaker,
        bool allow
    ) public onlyRole(OPERATOR_ADMIN_ROLE) {
        require(marketMaker != address(0), "400:IA");
        marketMakerAllowList[marketMaker] = allow;
        emit MarketMakerPermissionUpdated(marketMaker, allow);
    }

    /**
     * @notice Only default admin can set the fee recipient
     * @param _feeRecipient is the address of the fee recipient
     */
    function setFeeRecipient(
        address _feeRecipient
    ) public onlyRole(DEFAULT_ADMIN_ROLE) {
        require(_feeRecipient != address(0), "400:IA");
        feeRecipient = _feeRecipient;
        emit FeeRecipientUpdated(_feeRecipient);
    }

    /**
     * @notice Moves assets to corresponding product and vault account
     * @param productName is the name of the product
     * @param vaultAddress is the address of the vault
     */
    function moveAssetsToProduct(
        string memory productName,
        address vaultAddress,
        uint256 amount
    ) public onlyRole(TRADER_ADMIN_ROLE) {
        address productAddress = products[productName];
        require(productAddress != address(0), "400:PN");

        ISP0Product sp0Product = ISP0Product(productAddress);
        IERC20(sp0Product.asset()).approve(productAddress, amount);
        sp0Product.receiveAssetsFromVistaState(vaultAddress, amount);
        emit AssetsMovedToProduct(productName, vaultAddress, amount);
    }
}
