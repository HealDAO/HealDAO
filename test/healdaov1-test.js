const { expect } = require("chai");

describe("HealthRecordsDAO", function () {
  let HealthRecordsDAO, healthRecords, owner, addr1, addr2;

  beforeEach(async function () {
    HealthRecordsDAO = await ethers.getContractFactory("HealthRecordsDAO");
    healthRecords = await HealthRecordsDAO.deploy();
    [owner, addr1, addr2, _] = await ethers.getSigners();
  });

  // describe("Adding and Retrieving Health Records", function () {

  //   it("Should add and retrieve an allergy", async function () {
  //     await healthRecords.addAllergy("Pollen");
  //     const allergies = await healthRecords.getAllergies();
  //     expect(allergies).to.include("Pollen");
  //   });

  //   it("Should add and retrieve a bloodwork", async function () {
  //     await healthRecords.addBloodwork("HbA1c", 56, 1, "mmol/L", 25, 9, 2023); // Corrected value to integer
  //     const bloodworks = await healthRecords.getBloodworks();
  //     expect(bloodworks).to.include("HbA1c");
  //   });

  //   it("Should add and retrieve a diagnosis", async function () {
  //     await healthRecords.addDiagnosis("HTN", 2, "L1,L2"); // Corrected format
  //     const diagnoses = await healthRecords.getDiagnoses();
  //     expect(diagnoses).to.include("HTN");
  //   });

  //   it("Should add and retrieve global health data", async function () {
  //     await healthRecords.addGlobal("BMI", 25, 1, "kg/m2", 25, 9, 2023);
  //     const globals = await healthRecords.getGlobals();
  //     expect(globals).to.include("BMI");
  //   });

  //   it("Should add and retrieve a medication", async function () {
  //     await healthRecords.addMedication("ABC", 10, 1, 2, 5, 25, 9, 2023);
  //     const meds = await healthRecords.getMedications();
  //     expect(meds).to.include("ABC");
  //   });

  //   it("Should add and retrieve a procedure", async function () {
  //     await healthRecords.addProcedure("RCT", 1, "L1"); // Corrected format
  //     const procedures = await healthRecords.getProcedures();
  //     expect(procedures).to.include("RCT");
  //   });

  //   it("Should add and retrieve a vital", async function () {
  //     await healthRecords.addVital("BP", 986, 1, "F", 25, 9, 2023); // Provide day, month, and year
  //     const vitals = await healthRecords.getVitals();
  //     expect(vitals).to.include("BP");
  //   });
  // });

  // describe("Updating Health Records", function () {

  //   it("Should update and retrieve medications", async function () {
  //     const newMedications = [{
  //       drugAbbreviation: "Ibuprofen",
  //       dose: 200,
  //       multiplier: 1,
  //       frequency: 3,
  //       duration: 7,
  //       lastDate: { day: 26, month: 9, year: 2023 }
  //     }];
  //     await healthRecords.updateMedications(newMedications);
  //     const medications = await healthRecords.getMedications();
  //     expect(medications).to.include("Ibuprofen");
  //   });

  //   it("Should update and retrieve allergies", async function () {
  //     const newAllergies = [{ allergyAbbreviation: "NSAIDs" }];
  //     await healthRecords.updateAllergies(newAllergies);
  //     const allergies = await healthRecords.getAllergies();
  //     expect(allergies).to.include("NSAIDs");
  //   });

  //   it("Should update and retrieve bloodworks", async function () {
  //     const newBloodworks = [{
  //       bloodworkAbbreviation: "LDL",
  //       measure: 100,
  //       multiplier: 1,
  //       unitAbbreviation: "mg/dL",
  //       timestamp: { day: 26, month: 9, year: 2023 }
  //     }];
  //     await healthRecords.updateBloodworks(newBloodworks);
  //     const bloodworks = await healthRecords.getBloodworks();
  //     expect(bloodworks).to.include("LDL");
  //   });

  //   it("Should update and retrieve diagnoses", async function () {
  //     const newDiagnoses = [{
  //       diagnosisAbbreviation: "DM2",
  //       numTimes: 1,
  //       locationList: ["L3"]
  //     }];

  //     // Convert locationList to a comma-separated string
  //     const locationListString = newDiagnoses[0].locationList.join(", ");
  //     newDiagnoses[0].locationList = locationListString;

  //     await healthRecords.updateDiagnoses(newDiagnoses);
  //     const diagnoses = await healthRecords.getDiagnoses();
  //     expect(diagnoses).to.include("DM2");
  //   });

  //   it("Should update and retrieve global health data", async function () {
  //     const newGlobals = [{
  //       globalAbbreviation: "HR",
  //       measure: 75,
  //       multiplier: 1,
  //       unitAbbreviation: "bpm",
  //       timestamp: { day: 26, month: 9, year: 2023 }
  //     }];
  //     await healthRecords.updateGlobals(newGlobals);
  //     const globals = await healthRecords.getGlobals();
  //     expect(globals).to.include("HR");
  //   });

  //   it("Should update and retrieve procedures", async function () {
  //     const newProcedures = [{
  //       procedureAbbreviation: "CABG",
  //       numTimes: 1,
  //       locationList: ["L4"]
  //     }];

  //     // Convert locationList to a comma-separated string
  //     const locationListString = newProcedures[0].locationList.join(", ");
  //     newProcedures[0].locationList = locationListString;

  //     await healthRecords.updateProcedures(newProcedures);
  //     const procedures = await healthRecords.getProcedures();
  //     expect(procedures).to.include("CABG");
  //   });

  //   it("Should update and retrieve vitals", async function () {
  //     const newVitals = [{
  //       vitalAbbreviation: "Temp",
  //       measure: 986, // 98.6 multiplied by 10
  //       multiplier: 10,
  //       unitAbbreviation: "F",
  //       timestamp: { day: 26, month: 9, year: 2023 }
  //     }];
  //     await healthRecords.updateVitals(newVitals);
  //     const vitals = await healthRecords.getVitals();
  //     expect(vitals).to.include("Temp");
  //   });
  // });

  // describe("Event emission", function () {

  //   it("Should emit an AllergyAdded event when an allergy is added", async function () {
  //     await expect(healthRecords.addAllergy("Pollen"))
  //       .to.emit(healthRecords, "AllergyAdded")
  //       .withArgs(healthRecords.address, "Pollen");
  //   });

  //   it("Should emit a BloodworkAdded event when a bloodwork is added", async function () {
  //     await expect(healthRecords.addBloodwork("HbA1c", 56, 10, "mmol/L", 25, 9, 2023))
  //       .to.emit(healthRecords, "BloodworkAdded")
  //       .withArgs(healthRecords.address, "HbA1c", 56, "mmol/L", { day: 25, month: 9, year: 2023 });
  //   });

  //   it("Should emit a DiagnosisAdded event when a diagnosis is added", async function () {
  //     await expect(healthRecords.addDiagnosis("HTN", 2, "L1, L2"))
  //       .to.emit(healthRecords, "DiagnosisAdded")
  //       .withArgs(healthRecords.address, "HTN");
  //   });

  //   it("Should emit a GlobalInfoAdded event when global data is added", async function () {
  //     await expect(healthRecords.addGlobal("BMI", 25, 1, "kg/m2", 25, 9, 2023))
  //       .to.emit(healthRecords, "GlobalInfoAdded")
  //       .withArgs(healthRecords.address, "BMI", { day: 25, month: 9, year: 2023 });
  //   });

  //   it("Should emit a MedicationAdded event when a medication is added", async function () {
  //     await expect(healthRecords.addMedication("ABC", 10, 1, 2, 5, 25, 9, 2023))
  //       .to.emit(healthRecords, "MedicationAdded")
  //       .withArgs(healthRecords.address, "ABC");
  //   });

  //   it("Should emit a ProcedureAdded event when a procedure is added", async function () {
  //     await expect(healthRecords.addProcedure("RCT", 1, "L1"))
  //       .to.emit(healthRecords, "ProcedureAdded")
  //       .withArgs(healthRecords.address, "RCT");
  //   });

  //   it("Should emit a VitalAdded event when a vital is added", async function () {
  //     await expect(healthRecords.addVital("BP", 120, 1, "mmHg", 25, 9, 2023))
  //       .to.emit(healthRecords, "VitalAdded")
  //       .withArgs(healthRecords.address, "BP", { day: 25, month: 9, year: 2023 });
  //   });
  // });

  describe("Generating Representative Health Records Data for MSPS", function () {
    
    it("Should generate a representative health records data", async function () {
      
      // 1. Create multiple records per type of data structure:
      await healthRecords.addAllergy("AX_PNT");
      await healthRecords.addAllergy("AX_TRNT");
      await healthRecords.addAllergy("AX_MLK");
      await healthRecords.addAllergy("AX_EGG");
      await healthRecords.addAllergy("AX_WHT");

      await healthRecords.addBloodwork("BX_ALT", 25, 1, "UX_IUL", 25, 9, 2023);
      await healthRecords.addBloodwork("BX_ALB", 45, 10, "UX_GDL", 25, 9, 2023);
      await healthRecords.addBloodwork("BX_ALP", 90, 1, "UX_UL", 25, 9, 2023);
      await healthRecords.addBloodwork("BX_AMY", 80, 1, "UX_UL", 25, 9, 2023);
      await healthRecords.addBloodwork("BX_ANA", 0, 1, "UX_POSNEG", 25, 9, 2023);
      await healthRecords.addBloodwork("BX_AST", 30, 1, "UX_IUL", 26, 9, 2023);
      await healthRecords.addBloodwork("BX_BILT", 8, 100, "UX_MGDL", 26, 9, 2023);
      await healthRecords.addBloodwork("BX_BILD", 2, 100, "UX_MGDL", 26, 9, 2023);
      await healthRecords.addBloodwork("BX_BUN", 10, 1, "UX_MGDL", 26, 9, 2023);
      await healthRecords.addBloodwork("BX_CRP", 5, 1, "UX_MGL", 26, 9, 2023);

      await healthRecords.addDiagnosis("DX_CO", 1, "LX_71, LX_26, LX_37");
      await healthRecords.addDiagnosis("DX_JAWS", 1, "LX_46, LX_LLL");
      await healthRecords.addDiagnosis("DX_CRKT", 2, "LX_HD, LX_PR, LX_ANT");
      await healthRecords.addDiagnosis("DX_CXBT", 3, "LX_SUP, LX_DIST");
      await healthRecords.addDiagnosis("DX_HPV", 1, "LX_CRAN, LX_EXT");
      await healthRecords.addDiagnosis("DX_HL", 4, "LX_PR");
      await healthRecords.addDiagnosis("DX_HTN", 2, "LX_HD, LX_EXT");
      await healthRecords.addDiagnosis("DX_HHD", 1, "LX_ANT, LX_DIST");

      await healthRecords.addGlobal("GX_SX", 0, 1, "UX_SX", 25, 9, 2023);
      await healthRecords.addGlobal("GX_WT", 123, 1, "UX_KG", 25, 9, 2023);
      await healthRecords.addGlobal("GX_HT", 174, 1, "UX_CM", 25, 9, 2023);
      await healthRecords.addGlobal("GX_BT", 1, 1, "UX_BT", 25, 9, 2023);
      
      await healthRecords.addMedication("RX_AMLO", 10, 1, "UX_MG", 2, 5, 25, 9, 2023);
      await healthRecords.addMedication("RX_AMOX", 10, 1, "UX_MG", 2, 5, 25, 9, 2023);
      await healthRecords.addMedication("RX_AMCL", 10, 1, "UX_MG", 2, 5, 25, 9, 2023);
      await healthRecords.addMedication("RX_ARIPI", 10, 1, "UX_MG", 2, 5, 25, 9, 2023);
      await healthRecords.addMedication("RX_ASHW", 10, 1, "UX_MG", 2, 5, 25, 9, 2023);
      await healthRecords.addMedication("RX_ASPR", 10, 1, "UX_MG", 2, 5, 25, 9, 2023);
      await healthRecords.addMedication("RX_ATOR", 10, 1, "UX_MG", 2, 5, 25, 9, 2023);
      await healthRecords.addMedication("RX_AZIT", 10, 1, "UX_MG", 2, 5, 25, 9, 2023);
      
      await healthRecords.addProcedure("TX_APPX", 3, "LX_SUP, LX_DIST");
      await healthRecords.addProcedure("TX_BA", 1, "LX_CRAN, LX_EXT");
      await healthRecords.addProcedure("TX_BMT", 4, "LX_PR");
      await healthRecords.addProcedure("TX_CF", 2, "LX_HD, LX_EXT");
      await healthRecords.addProcedure("TX_CHLCY", 1, "LX_ANT, LX_DIST");
      
      await healthRecords.addVital("VX_BP", 986, 10, "UX_MMHG", 25, 9, 2023);
      await healthRecords.addVital("VX_HR", 78, 1, "UX_BPM", 26, 9, 2023);
      
      // 2. Retrieve data from individual getters:
      const allergies = await healthRecords.getAllergies();
      const bloodworks = await healthRecords.getBloodworks();
      const diagnoses = await healthRecords.getDiagnoses();
      const globals = await healthRecords.getGlobals();
      const meds = await healthRecords.getMedications();
      const procedures = await healthRecords.getProcedures();
      const vitals = await healthRecords.getVitals();
      
      // 3. Consolidate objects to a single JSON:
      const consolidatedData = {
        allergies: allergies,
        bloodworks: bloodworks,
        diagnoses: diagnoses,
        globals: globals,
        meds: meds,
        procedures: procedures,
        vitals: vitals
      };

      console.log(JSON.stringify(consolidatedData, null, 2));  // This will print the consolidated data
      
      // Make sure that the consolidated data includes all the records
      expect(consolidatedData.allergies).to.include("AX_TRNT");
      expect(consolidatedData.bloodworks).to.include("BX_BUN");
      expect(consolidatedData.diagnoses).to.include("DX_HTN");
      expect(consolidatedData.globals).to.include("GX_HT");
      expect(consolidatedData.meds).to.include("RX_ATOR");
      expect(consolidatedData.procedures).to.include("TX_CF");
      expect(consolidatedData.vitals).to.include("VX_HR");
    });
  });
});
