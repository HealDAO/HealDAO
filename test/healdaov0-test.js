const { expect } = require("chai");

describe("HealDAOv0", function () {
  let HealDAOv0, healDAO, owner, addr1, addr2;

  beforeEach(async function () {
    HealDAOv0 = await ethers.getContractFactory("HealDAOv0");
    healDAO = await HealDAOv0.deploy();
    [owner, addr1, addr2, _] = await ethers.getSigners();
  });

  describe("Setting and Getting Health Records", function () {
    it("Should set and get the health record for an address", async function () {
      const medicalState = {
        recentDiagnoses: "HTN",
        allergies: "PCN",
        medications: "Aspirin",
        history: "CHD",
        vitalSigns: "BP120/80",
        bloodworkPanel: "HbA1c"
      };

      const dentalState = {
        periodontalStatus: "Healthy",
        cranialNerveInjuries: "None",
        teethStatus: "M1Amalgam",
        procedures: "2023-09-25RCT"
      };

      await healDAO.setRecord(medicalState, dentalState);

      const [returnedMedical, returnedDental] = await healDAO.getRecord();

      expect(returnedMedical.recentDiagnoses).to.equal(medicalState.recentDiagnoses);
      expect(returnedDental.teethStatus).to.equal(dentalState.teethStatus);
    });
  });

  describe("Event emission", function () {
    it("Should emit a RecordUpdated event when a record is set", async function () {
      const medicalState = {
        recentDiagnoses: "HTN",
        allergies: "PCN",
        medications: "Aspirin",
        history: "CHD",
        vitalSigns: "BP120/80",
        bloodworkPanel: "HbA1c"
      };

      const dentalState = {
        periodontalStatus: "Healthy",
        cranialNerveInjuries: "None",
        teethStatus: "M1Amalgam",
        procedures: "2023-09-25RCT"
      };

      await expect(healDAO.setRecord(medicalState, dentalState))
        .to.emit(healDAO, "RecordUpdated")
        .withArgs(owner.address);
    });
  });
});
