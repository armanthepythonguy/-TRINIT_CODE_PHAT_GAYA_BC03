// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract crowdFund{
    uint id = 0;
    struct Transaction{
        uint fund_id;
        address giver;
        uint amount;
    }
    struct donation{
        uint fund_id;
        uint amount;
        uint amount_got;
        address aggregator;
        string title;
        string details;
    }
    donation[] public donations;
    Transaction[] public  transactions;

    function setDonations(string memory _title, string memory _details, address _address, uint _amount) public {
        donation memory Donation;
        Donation.fund_id = id;
        Donation.amount = _amount;
        Donation.amount_got = 0;
        Donation.aggregator = _address;
        Donation.title = _title;
        Donation.details = _details;
        donations.push(Donation);
        id+=1;
    }

    function getDonations(uint _index) public view returns (string memory title, string memory details, uint amount,uint amount_got) {
        donation storage Donation = donations[_index];
        return (Donation.title, Donation.details ,Donation.amount, Donation.amount_got);
    }

    function sendBal(uint _index) payable public {
        uint amount = msg.value;
        donation storage Donation = donations[_index];
        payable(Donation.aggregator).transfer(amount);
        Donation.amount_got+=amount;
        Transaction memory transaction;
        transaction.fund_id = Donation.fund_id;
        transaction.giver = msg.sender;
        transaction.amount = amount;
        transactions.push(transaction);
    }


}