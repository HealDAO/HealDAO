# HealDAO

## Table of Contents
- [Introduction](#introduction)
- [Privacy with Oasis Sapphire ParaTime](#privacy-with-oasis-sapphire-paratime)
- [HealDAO Smart Contract](#healdao-smart-contract)
  - [Structs](#structs)
  - [Setters](#setters)
  - [Getters](#getters)
  - [Access Control](#access-control)
- [MSPS System](#msps-system)
- [Contribution & Governance](#contribution--governance)
- [License](#license)

## Introduction
HealDAO is a decentralized autonomous organization (DAO) designed to revolutionize the way health records are stored, accessed, and verified on the blockchain. Our primary goal is to ensure that medical data remains private, secure, and easily accessible, all while maintaining the highest standards of data integrity.

## Privacy with Oasis Sapphire ParaTime
HealDAO prioritizes user privacy. We leverage the Oasis Sapphire ParaTime, a cutting-edge privacy-preserving layer, to ensure that all health records stored within the system remain confidential. This layer provides end-to-end encryption, ensuring that only authorized parties can access the data, while still benefiting from the transparency and security of the blockchain.

## HealDAO Smart Contract

### Structs
The core of HealDAO's smart contract is organized around various structs that represent different aspects of medical data:

```
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
```

### Setters
Setters are functions that allow users to input or update their health records. Setters correspond to a list size limit, set by the owner, by reducing the limit size previous records may be deleted:

- `addAllergy`
- `addBloodwork`
- `addDiagnosis`
- `addGlobal`
- `addMedication`
- `addProcedure`
- `addVital`

### Getters
Getters are functions that retrieve stored data, they may be combined to form combinatorial data (i.e., as in the test file):

- `getAllergies`
- `getBloodworks`
- `getDiagnoses`
- `getGlobals`
- `getMedications`
- `getProcedures`
- `getVitals`

### Access Control
To ensure data integrity and security, HealDAO implements access control mechanisms. Only authorized users can update or modify records. The current implementation revolves around the need to temporarily grant access, hence the `accessor` mapping-- in this way, entities will have revokable access that can span varying amounts of time.

## MSPS System
The Minified Standardized Patient Summary (MSPS) system is a groundbreaking approach to representing medical data in a compact yet comprehensive format. Designed with the principles of Ethereum Improvement Proposals (EIP), the MSPS system allows for the minification and expansion of medical data, ensuring that it remains both storage-efficient and human-readable. The system is designed to maximally be flexible in accomodating a very wide variety of medical and clinical conditions, use cases, and scenarios.

### Contribution & Governance
HealDAO operates as a DAO, meaning that its community members can propose changes or modifications to the MSPS standard. Through a governance mechanism, proposals undergo a review and voting process, ensuring that any updates to the system are in the best interest of all stakeholders.

## License
HealDAO is open-source and licensed under the MIT License. We encourage contributions from the community to continually improve and expand the system.
