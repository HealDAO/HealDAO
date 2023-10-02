// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HealDAO {

    address public owner;
    mapping(address => bool) public accessor;

    enum DataLimitType {
        ALLERGIES,
        BLOODWORKS,
        DIAGNOSES,
        GLOBALS,
        MEDICATIONS,
        PROCEDURES,
        VITALS
    }

    uint16 public MAX_ALLERGIES_LENGTH = 100;
    uint16 public MAX_BLOODWORKS_LENGTH = 100;
    uint16 public MAX_DIAGNOSES_LENGTH = 100;
    uint16 public MAX_GLOBALS_LENGTH = 100;
    uint16 public MAX_MEDICATIONS_LENGTH = 100;
    uint16 public MAX_PROCEDURES_LENGTH = 100;
    uint16 public MAX_VITALS_LENGTH = 100;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    modifier isAllowed() {
        require(accessor[msg.sender] || msg.sender == owner, "Not authorized");
        _;
    }

    function grantAccess(address _address) public onlyOwner {
        accessor[_address] = true;
    }

    function revokeAccess(address _address) public onlyOwner {
        accessor[_address] = false;
    }

    // List limits
    function setListLimit(DataLimitType dataType, uint16 newLength) public onlyOwner {
        if (dataType == DataLimitType.ALLERGIES) {
            MAX_ALLERGIES_LENGTH = newLength;
        } else if (dataType == DataLimitType.BLOODWORKS) {
            MAX_BLOODWORKS_LENGTH = newLength;
        } else if (dataType == DataLimitType.DIAGNOSES) {
            MAX_DIAGNOSES_LENGTH = newLength;
        } else if (dataType == DataLimitType.GLOBALS) {
            MAX_GLOBALS_LENGTH = newLength;
        } else if (dataType == DataLimitType.MEDICATIONS) {
            MAX_MEDICATIONS_LENGTH = newLength;
        } else if (dataType == DataLimitType.PROCEDURES) {
            MAX_PROCEDURES_LENGTH = newLength;
        } else if (dataType == DataLimitType.VITALS) {
            MAX_VITALS_LENGTH = newLength;
        }
    }

    // Subcomponents
    struct Date {
        uint16 day;
        uint16 month;
        uint16 year;
    }

    // Tracked records
    struct Allergy {
        string allergyAbbreviation;
    }

    struct Bloodwork {
        string bloodworkAbbreviation;
        uint16 measure;
        uint8 multiplier;
        string unitAbbreviation;
        Date timestamp;
    }

    struct Diagnosis {
        string diagnosisAbbreviation;
        uint16 numTimes;
        string locationList; // Comma-separated locations
    }

    struct Global {
        string globalAbbreviation;
        uint16 measure;
        uint8 multiplier;
        string unitAbbreviation;
        Date timestamp;
    }

    struct Medication {
        string drugAbbreviation;
        uint16 dose;
        uint8 multiplier;
        string unitAbbreviation;
        uint16 frequency;
        uint16 duration;
        Date lastDate;
    }

    struct Procedure {
        string procedureAbbreviation;
        uint16 numTimes;
        string locationList;
    }

    struct Vital {
        string vitalAbbreviation;
        uint16 measure;
        uint8 multiplier;
        string unitAbbreviation;
        Date timestamp;
    }

    Medication[] public medications;
    Allergy[] public allergies;
    Bloodwork[] public bloodworks;
    Diagnosis[] public diagnoses;
    Global[] public globals;
    Procedure[] public procedures;
    Vital[] public vitals;

    event AllergyAdded(address indexed records, string allergy);
    event BloodworkAdded(address indexed records, string testType, uint16 measure, string unit, Date testDate);
    event DiagnosisAdded(address indexed records, string indexed diagnosisAbbreviation);
    event GlobalInfoAdded(address indexed records, string globalType, Date timestamp);
    event MedicationAdded(address indexed records, string indexed drugAbbreviation);
    event ProcedureAdded(address indexed records, string procedureType);
    event VitalAdded(address indexed records, string vitalType, Date timestamp);

    function addAllergy(string memory allergyAbbreviation) public isAllowed {
        allergies.push(Allergy(allergyAbbreviation));
        emit AllergyAdded(address(this), allergyAbbreviation);

        // Remove the oldest allergy if the length exceeds the max length
        while (allergies.length > MAX_ALLERGIES_LENGTH) {
            // Remove the first element
            for (uint i = 0; i < allergies.length - 1; i++) {
                allergies[i] = allergies[i + 1];
            }
            allergies.pop();
        }
    }

    function addBloodwork(string memory bloodworkAbbreviation, uint16 measure, uint8 multiplier, string memory unitAbbreviation, uint16 day, uint16 month, uint16 year) public isAllowed {
        Date memory timestamp = Date(day, month, year);
        bloodworks.push(Bloodwork(bloodworkAbbreviation, measure, multiplier, unitAbbreviation, timestamp));
        emit BloodworkAdded(address(this), bloodworkAbbreviation, measure, unitAbbreviation, timestamp);

        // Remove the oldest bloodwork if the length exceeds the max length
        while (bloodworks.length > MAX_BLOODWORKS_LENGTH) {
            // Remove the first element
            for (uint i = 0; i < bloodworks.length - 1; i++) {
                bloodworks[i] = bloodworks[i + 1];
            }
            bloodworks.pop();
        }
    }

    function addDiagnosis(string memory diagnosisAbbreviation, uint16 numTimes, string memory locationList) public isAllowed {
        diagnoses.push(Diagnosis(diagnosisAbbreviation, numTimes, locationList));
        emit DiagnosisAdded(address(this), diagnosisAbbreviation);

        // Remove the oldest diagnosis if the length exceeds the max length
        while (diagnoses.length > MAX_DIAGNOSES_LENGTH) {
            // Remove the first element
            for (uint i = 0; i < diagnoses.length - 1; i++) {
                diagnoses[i] = diagnoses[i + 1];
            }
            diagnoses.pop();
        }
    }

    function addGlobal(string memory globalAbbreviation, uint16 measure, uint8 multiplier, string memory unitAbbreviation, uint16 day, uint16 month, uint16 year) public isAllowed {
        Date memory timestamp = Date(day, month, year);
        globals.push(Global(globalAbbreviation, measure, multiplier, unitAbbreviation, timestamp));
        emit GlobalInfoAdded(address(this), globalAbbreviation, timestamp);

        // Remove the oldest global if the length exceeds the max length
        while (globals.length > MAX_GLOBALS_LENGTH) {
            // Remove the first element
            for (uint i = 0; i < globals.length - 1; i++) {
                globals[i] = globals[i + 1];
            }
            globals.pop();
        }
    }

    function addMedication(string memory drugAbbreviation, uint16 dose, uint8 multiplier, string memory unitAbbreviation, uint16 frequency, uint16 duration, uint16 lastDay, uint16 lastMonth, uint16 lastYear) public isAllowed {
        Date memory lastDate = Date(lastDay, lastMonth, lastYear);
        medications.push(Medication(drugAbbreviation, dose, multiplier, unitAbbreviation, frequency, duration, lastDate));
        emit MedicationAdded(address(this), drugAbbreviation);

        // Remove the oldest medication if the length exceeds the max length
        while (medications.length > MAX_MEDICATIONS_LENGTH) {
            // Remove the first element
            for (uint i = 0; i < medications.length - 1; i++) {
                medications[i] = medications[i + 1];
            }
            medications.pop();
        }
    }

    function addProcedure(string memory procedureAbbreviation, uint16 numTimes, string memory locationList) public isAllowed {
        procedures.push(Procedure(procedureAbbreviation, numTimes, locationList));
        emit ProcedureAdded(address(this), procedureAbbreviation);

        // Remove the oldest procedure if the length exceeds the max length
        while (procedures.length > MAX_PROCEDURES_LENGTH) {
            // Remove the first element
            for (uint i = 0; i < procedures.length - 1; i++) {
                procedures[i] = procedures[i + 1];
            }
            procedures.pop();
        }
    }

    function addVital(string memory vitalAbbreviation, uint16 measure, uint8 multiplier, string memory unitAbbreviation, uint16 day, uint16 month, uint16 year) public isAllowed {
        Date memory timestamp = Date(day, month, year);
        vitals.push(Vital(vitalAbbreviation, measure, multiplier, unitAbbreviation, timestamp));
        emit VitalAdded(address(this), vitalAbbreviation, timestamp);

        // Remove the oldest vital if the length exceeds the max length
        while (vitals.length > MAX_VITALS_LENGTH) {
            // Remove the first element
            for (uint i = 0; i < vitals.length - 1; i++) {
                vitals[i] = vitals[i + 1];
            }
            vitals.pop();
        }
    }

    // Individual getters
    function getAllergies() public view isAllowed returns (string memory) {
        string memory result = "";
        for(uint16 i = 0; i < allergies.length; i++) {
            result = string(abi.encodePacked(result, allergies[i].allergyAbbreviation, "; "));
        }
        return result;
    }

    function getBloodworks() public view isAllowed returns (string memory) {
        string memory result = "";
        for(uint16 i = 0; i < bloodworks.length; i++) {
            Bloodwork memory bw = bloodworks[i];
            result = string(abi.encodePacked(result, bw.bloodworkAbbreviation, "-", uint2str(bw.measure), "-", uint2str(bw.multiplier), "-", bw.unitAbbreviation, "-", date2str(bw.timestamp), "; "));
        }
        return result;
    }

    function getDiagnoses() public view isAllowed returns (string memory) {
        string memory result = "";
        for(uint16 i = 0; i < diagnoses.length; i++) {
            Diagnosis memory diag = diagnoses[i];
            result = string(abi.encodePacked(result, diag.diagnosisAbbreviation, "-", uint2str(diag.numTimes), "-", diag.locationList, "; "));

        }
        return result;
    }

    function getGlobals() public view isAllowed returns (string memory) {
        string memory result = "";
        for(uint16 i = 0; i < globals.length; i++) {
            Global memory glob = globals[i];
            result = string(abi.encodePacked(result, glob.globalAbbreviation, "-", uint2str(glob.measure), "-", uint2str(glob.multiplier), "-", glob.unitAbbreviation, "-", date2str(glob.timestamp), "; "));
        }
        return result;
    }

    function getMedications() public view isAllowed returns (string memory) {
        string memory result = "";
        for(uint16 i = 0; i < medications.length; i++) {
            Medication memory med = medications[i];
            result = string(abi.encodePacked(result, med.drugAbbreviation, "-", uint2str(med.dose), "-", uint2str(med.multiplier), "-", med.unitAbbreviation, "-", uint2str(med.frequency), "-", uint2str(med.duration), "-", date2str(med.lastDate), "; "));
        }
        return result;
    }

    function getProcedures() public view isAllowed returns (string memory) {
        string memory result = "";
        for(uint16 i = 0; i < procedures.length; i++) {
            Procedure memory proc = procedures[i];
            result = string(abi.encodePacked(result, proc.procedureAbbreviation, "-", uint2str(proc.numTimes), "-", proc.locationList, "; "));

        }
        return result;
    }

    function getVitals() public view isAllowed returns (string memory) {
        string memory result = "";
        for(uint16 i = 0; i < vitals.length; i++) {
            Vital memory vit = vitals[i];
            result = string(abi.encodePacked(result, vit.vitalAbbreviation, "-", uint2str(vit.measure), "-", uint2str(vit.multiplier), "-", vit.unitAbbreviation, "-", date2str(vit.timestamp), "; "));
        }
        return result;
    }

    // Helper functions to convert uint to string and Date to string format
    function date2str(Date memory _date) internal pure returns (string memory) {
        return string(abi.encodePacked(uint2str(_date.day), "/", uint2str(_date.month), "/", uint2str(_date.year)));
    }

    function uint2str(uint16 _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        
        uint16 j = _i;
        uint16 length;
        
        while (j != 0) {
            length++;
            j /= 10;
        }
        
        bytes memory bstr = new bytes(length);
        uint16 k = length;
        
        while (_i != 0) {
            k = k - 1;
            bstr[k] = bytes1(uint8(48 + _i % 10));
            _i /= 10;
        }
        
        return string(bstr);
    }

    function timestampToDate(uint256 timestamp) internal pure returns (Date memory) {
        uint16 year = uint16((timestamp / 31536000) + 1970);
        uint16 month = uint16((timestamp % 31536000) / 2628000 + 1);
        uint16 day = uint16(((timestamp % 31536000) % 2628000) / 86400 + 1);
        return Date(day, month, year);
    }

}
