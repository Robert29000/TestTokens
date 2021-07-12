import os
from brownie import TestToken, accounts

def main():
    test_account = accounts.add(os.getenv("PRIVATE_KEY"))
    token = TestToken.deploy("TestToken", "TSTK", 1000000000000, 18, {'from': test_account})