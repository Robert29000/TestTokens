import os
from brownie import WBNB, accounts

def main():
    test_account = accounts.add(os.getenv("PRIVATE_KEY"))
    token = WBNB.deploy({'from': test_account})