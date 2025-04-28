// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
 * @author not-so-secure-dev
 * @title PasswordStore
 * @notice This contract allows you to store a private password that others won't be able to see.
 * You can update your password at any time.
 */
contract PasswordStore {
    error PasswordStore__NotOwner();

    address private s_owner;
    // !bug-high since this is stored in storage anyone can view it by viewing contract's storage slots. This is not a safe-place to store the password
    string private s_password;

    event SetNewPassword();

    constructor() {
        s_owner = msg.sender; // !info whoever deploys this contract is the owner.
    }

    /*
     * @notice This function allows only the owner to set a new password.
     * @param newPassword The new password to set.
     */
    // !bug-high any user can set the password here - missing access control
    function setPassword(string memory newPassword) external {
        s_password = newPassword;
        emit SetNewPassword();
    }

    /*
     * @notice This allows only the owner to retrieve the password.
     * @param newPassword The new password to set.
     */
    // !bug-low no param is implemented in here. Maybe it doesn't need any parameter
    function getPassword() external view returns (string memory) {
        if (msg.sender != s_owner) {
            revert PasswordStore__NotOwner();
        }
        return s_password;
    }
}
