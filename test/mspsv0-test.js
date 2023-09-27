const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MSPS", function () {
    let MSPS;
    let msp;
    let owner;
    let addr1;
    let addr2;

    beforeEach(async function () {
        MSPS = await ethers.getContractFactory("MSPSv0");
        [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
        msp = await MSPS.deploy();
        await msp.deployed();
    });

    describe("Proposal Submission", function () {
        it("Should allow users to submit proposals", async function () {
            await msp.connect(addr1).submitProposal("Test Description", "Test Rationale", "Test Documentation");
            const proposal = await msp.proposals(1);
            expect(proposal.proposer).to.equal(addr1.address);
            expect(proposal.description).to.equal("Test Description");
        });
    });

    describe("Voting", function () {
        beforeEach(async function () {
            await msp.connect(addr1).submitProposal("Test Description", "Test Rationale", "Test Documentation");
        });

        it("Should allow users to vote on proposals", async function () {
            await msp.connect(addr2).vote(1, true);
            const proposal = await msp.proposals(1);
            expect(proposal.votesFor).to.equal(1);
        });

        it("Should not allow users to vote twice on the same proposal", async function () {
            await msp.connect(addr2).vote(1, true);
            await expect(msp.connect(addr2).vote(1, false)).to.be.revertedWith("Already voted on this proposal");
        });
    });

    describe("Proposal Implementation", function () {
        beforeEach(async function () {
            await msp.connect(addr1).submitProposal("Test Description", "Test Rationale", "Test Documentation");
            await msp.connect(addr2).vote(1, true);
        });

        it("Should allow proposals with more votes in favor to be implemented", async function () {
            await msp.implementProposal(1);
            const proposal = await msp.proposals(1);
            expect(proposal.implemented).to.equal(true);
        });

        it("Should not allow proposals with more votes against to be implemented", async function () {
            await msp.connect(addr1).vote(1, false);
            await expect(msp.implementProposal(1)).to.be.revertedWith("Proposal not approved");
        });

        it("Should not allow already implemented proposals to be implemented again", async function () {
            await msp.implementProposal(1);
            await expect(msp.implementProposal(1)).to.be.revertedWith("Proposal already implemented");
        });
    });
});
