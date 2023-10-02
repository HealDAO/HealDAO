// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HealDAOv0 {

    struct MedicalState {
        string recentDiagnoses;
        string allergies;
        string medications;
        string history;
        string vitalSigns;
        string bloodworkPanel;
    }

    struct DentalState {
        string periodontalStatus;
        string cranialNerveInjuries;
        string teethStatus;
        string procedures;
    }

    struct HealthRecord {
        MedicalState medical;
        DentalState dental;
    }

    // Mapping from user's address to their health record
    mapping(address => HealthRecord) private records;

    // Event to notify when a record is updated
    event RecordUpdated(address indexed user);

    // Set the health record for the sender
    function setRecord(MedicalState memory medical, DentalState memory dental) public {
        records[msg.sender] = HealthRecord(medical, dental);
        emit RecordUpdated(msg.sender);
    }

    // Get the health record for the sender
    function getRecord() public view returns (MedicalState memory, DentalState memory) {
        return (records[msg.sender].medical, records[msg.sender].dental);
    }
}
