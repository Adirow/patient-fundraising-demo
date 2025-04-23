//
pragma solidity ^0.8.0;

/**
 * @title PatientFundraising
 * @dev simple smart contract for transparent patient fundraising
 */
contract PatientFundraising {
    struct Patient {
        address payable patientAddress;
        string name;
        string medicalCondition;
        uint256 targetAmount;
        uint256 raisedAmount;
        bool isVerified;
    }

    struct Transaction {
        address from;
        address to;
        uint256 amount;
        uint256 timestamp;
        string purpose;
    }

    address public admin;

    // Mapping of patient IDs to Patient structs
    mapping(uint256 => Patient) public patients;


    mapping(address => bool) public verifiedVendors;


    mapping(uint256 => uint256) public patientFunds;


    Transaction[] public transactions;

    // Patient counter
    uint256 public patientCount;

    // Events
    event DonationReceived(uint256 patientId, address donor, uint256 amount);
    event VendorPayment(
        uint256 patientId,
        address vendor,
        uint256 amount,
        string purpose
    );

    constructor() {
        admin = msg.sender;
        patientCount = 0;
    }

    /**
     * @dev Donate to a specific patient
     * @param _patientId The ID of the patient to donate to
     * @param _purpose The purpose of the donation
     */
    function donateToPatient(
        uint256 _patientId,
        string memory _purpose
    ) public payable {
        require(
            _patientId > 0 && _patientId <= patientCount,
            "Invalid patient ID"
        );
        require(patients[_patientId].isVerified, "Patient is not verified");
        require(msg.value > 0, "Donation amount must be greater than 0");


        patients[_patientId].raisedAmount += msg.value;
        patientFunds[_patientId] += msg.value;


        transactions.push(
            Transaction({
                from: msg.sender,
                to: patients[_patientId].patientAddress,
                amount: msg.value,
                timestamp: block.timestamp,
                purpose: _purpose
            })
        );

        emit DonationReceived(_patientId, msg.sender, msg.value);
    }

    /**
     * @dev Pay a verified vendor for medical services
     * @param _patientId The ID of the patient making the payment
     * @param _vendorAddress The address of the vendor to pay
     * @param _amount The amount to pay
     * @param _purpose The purpose of the payment
     */
    function payVendor(
        uint256 _patientId,
        address payable _vendorAddress,
        uint256 _amount,
        string memory _purpose
    ) public {
        require(
            _patientId > 0 && _patientId <= patientCount,
            "Invalid patient ID"
        );
        require(
            msg.sender == patients[_patientId].patientAddress,
            "Only patient can make payments"
        );
        require(verifiedVendors[_vendorAddress], "Vendor is not verified");
        require(patientFunds[_patientId] >= _amount, "Insufficient funds");

        // Update available funds
        patientFunds[_patientId] -= _amount;


        _vendorAddress.transfer(_amount);

        // Record the transaction
        transactions.push(
            Transaction({
                from: msg.sender,
                to: _vendorAddress,
                amount: _amount,
                timestamp: block.timestamp,
                purpose: _purpose
            })
        );

        emit VendorPayment(_patientId, _vendorAddress, _amount, _purpose);
    }

    // Helper function to add a test patient (for demo purposes)
    function addTestPatient(
        address payable _patientAddress,
        string memory _name,
        string memory _condition,
        uint256 _target
    ) public {
        patientCount++;
        patients[patientCount] = Patient({
            patientAddress: _patientAddress,
            name: _name,
            medicalCondition: _condition,
            targetAmount: _target,
            raisedAmount: 0,
            isVerified: true
        });
    }


    function addTestVendor(address _vendorAddress) public {
        verifiedVendors[_vendorAddress] = true;
    }


    function getAllTransactions() public view returns (Transaction[] memory) {
        return transactions;
    }
}
