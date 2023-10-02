// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HealDAO {

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
    event UpdatedMedications(address indexed records);
    event UpdatedAllergies(address indexed records);
    event UpdatedBloodworks(address indexed records);
    event UpdatedDiagnoses(address indexed records);
    event UpdatedGlobals(address indexed records);
    event UpdatedProcedures(address indexed records);
    event UpdatedVitals(address indexed records);

    function addAllergy(string memory allergyAbbreviation) public {
        allergies.push(Allergy(allergyAbbreviation));
        emit AllergyAdded(address(this), allergyAbbreviation);
    }

    function addBloodwork(string memory bloodworkAbbreviation, uint16 measure, uint8 multiplier, string memory unitAbbreviation, uint16 day, uint16 month, uint16 year) public {
        Date memory timestamp = Date(day, month, year);
        bloodworks.push(Bloodwork(bloodworkAbbreviation, measure, multiplier, unitAbbreviation, timestamp));
        emit BloodworkAdded(address(this), bloodworkAbbreviation, measure, unitAbbreviation, timestamp);
    }

    function addDiagnosis(string memory diagnosisAbbreviation, uint16 numTimes, string memory locationList) public {
        diagnoses.push(Diagnosis(diagnosisAbbreviation, numTimes, locationList));
        emit DiagnosisAdded(address(this), diagnosisAbbreviation);
    }

    function addGlobal(string memory globalAbbreviation, uint16 measure, uint8 multiplier, string memory unitAbbreviation, uint16 day, uint16 month, uint16 year) public {
        Date memory timestamp = Date(day, month, year);
        globals.push(Global(globalAbbreviation, measure, multiplier, unitAbbreviation, timestamp));
        emit GlobalInfoAdded(address(this), globalAbbreviation, timestamp);
    }

    function addMedication(string memory drugAbbreviation, uint16 dose, uint8 multiplier, string memory unitAbbreviation, uint16 frequency, uint16 duration, uint16 lastDay, uint16 lastMonth, uint16 lastYear) public {
        Date memory lastDate = Date(lastDay, lastMonth, lastYear);
        medications.push(Medication(drugAbbreviation, dose, multiplier, unitAbbreviation, frequency, duration, lastDate));
        emit MedicationAdded(address(this), drugAbbreviation);
    }

    function addProcedure(string memory procedureAbbreviation, uint16 numTimes, string memory locationList) public {
        procedures.push(Procedure(procedureAbbreviation, numTimes, locationList));
        emit ProcedureAdded(address(this), procedureAbbreviation);
    }

    function addVital(string memory vitalAbbreviation, uint16 measure, uint8 multiplier, string memory unitAbbreviation, uint16 day, uint16 month, uint16 year) public {
        Date memory timestamp = Date(day, month, year);
        vitals.push(Vital(vitalAbbreviation, measure, multiplier, unitAbbreviation, timestamp));
        emit VitalAdded(address(this), vitalAbbreviation, timestamp);
    }

    // Individual getters
    function getAllergies() public view returns (string memory) {
        string memory result = "";
        for(uint16 i = 0; i < allergies.length; i++) {
            result = string(abi.encodePacked(result, allergies[i].allergyAbbreviation, "; "));
        }
        return result;
    }

    function getBloodworks() public view returns (string memory) {
        string memory result = "";
        for(uint16 i = 0; i < bloodworks.length; i++) {
            Bloodwork memory bw = bloodworks[i];
            result = string(abi.encodePacked(result, bw.bloodworkAbbreviation, "-", uint2str(bw.measure), "-", uint2str(bw.multiplier), "-", bw.unitAbbreviation, "-", date2str(bw.timestamp), "; "));
        }
        return result;
    }

    function getDiagnoses() public view returns (string memory) {
        string memory result = "";
        for(uint16 i = 0; i < diagnoses.length; i++) {
            Diagnosis memory diag = diagnoses[i];
            result = string(abi.encodePacked(result, diag.diagnosisAbbreviation, "-", uint2str(diag.numTimes), "-", diag.locationList, "; "));

        }
        return result;
    }

    function getGlobals() public view returns (string memory) {
        string memory result = "";
        for(uint16 i = 0; i < globals.length; i++) {
            Global memory glob = globals[i];
            result = string(abi.encodePacked(result, glob.globalAbbreviation, "-", uint2str(glob.measure), "-", uint2str(glob.multiplier), "-", glob.unitAbbreviation, "-", date2str(glob.timestamp), "; "));
        }
        return result;
    }

    function getMedications() public view returns (string memory) {
        string memory result = "";
        for(uint16 i = 0; i < medications.length; i++) {
            Medication memory med = medications[i];
            result = string(abi.encodePacked(result, med.drugAbbreviation, "-", uint2str(med.dose), "-", uint2str(med.multiplier), "-", med.unitAbbreviation, "-", uint2str(med.frequency), "-", uint2str(med.duration), "-", date2str(med.lastDate), "; "));
        }
        return result;
    }

    function getProcedures() public view returns (string memory) {
        string memory result = "";
        for(uint16 i = 0; i < procedures.length; i++) {
            Procedure memory proc = procedures[i];
            result = string(abi.encodePacked(result, proc.procedureAbbreviation, "-", uint2str(proc.numTimes), "-", proc.locationList, "; "));

        }
        return result;
    }

    function getVitals() public view returns (string memory) {
        string memory result = "";
        for(uint16 i = 0; i < vitals.length; i++) {
            Vital memory vit = vitals[i];
            result = string(abi.encodePacked(result, vit.vitalAbbreviation, "-", uint2str(vit.measure), "-", uint2str(vit.multiplier), "-", vit.unitAbbreviation, "-", date2str(vit.timestamp), "; "));
        }
        return result;
    }

    function updateAllergies(Allergy[] memory newAllergies) public {
        delete allergies;

        for(uint i = 0; i < newAllergies.length; i++) {
            allergies.push(newAllergies[i]);
        }
        emit UpdatedAllergies(address(this));
    }

    function updateBloodworks(Bloodwork[] memory newBloodworks) public {
        delete bloodworks;

        for(uint i = 0; i < newBloodworks.length; i++) {
            bloodworks.push(newBloodworks[i]);
        }
        emit UpdatedBloodworks(address(this));
    }

    function updateDiagnoses(Diagnosis[] memory newDiagnoses) public {
        delete diagnoses;

        for(uint i = 0; i < newDiagnoses.length; i++) {
            diagnoses.push(newDiagnoses[i]);
        }

        emit UpdatedDiagnoses(address(this));
    }

    function updateGlobals(Global[] memory newGlobals) public {
        delete globals;

        for(uint i = 0; i < newGlobals.length; i++) {
            globals.push(newGlobals[i]);
        }
        emit UpdatedGlobals(address(this));
    }

    function updateMedications(Medication[] memory newMedications) public {
        delete medications;

        for(uint i = 0; i < newMedications.length; i++) {
            medications.push(newMedications[i]);
        }
        emit UpdatedMedications(address(this));
    }

    function updateProcedures(Procedure[] memory newProcedures) public {
        delete procedures;

        for(uint i = 0; i < newProcedures.length; i++) {
            procedures.push(newProcedures[i]);
        }
        emit UpdatedProcedures(address(this));
    }

    function updateVitals(Vital[] memory newVitals) public {
        delete vitals;

        for(uint i = 0; i < newVitals.length; i++) {
            vitals.push(newVitals[i]);
        }
        emit UpdatedVitals(address(this));
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
