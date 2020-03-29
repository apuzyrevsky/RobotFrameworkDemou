*** Settings ***
Documentation     A test suite containing tests related to add item to the basket.
Test Setup        Valid Login
Resource          resource.robot

*** Test Cases ***
Valid Checkout
    Add Item To The Basket
    Open Basket
    Check That Added Item Is Present
    Proceed To Check Out Step One
    Fill in Personal Info  ${firstname}  ${lastname}  ${postalcode}
    Finish Check Out
    [Teardown]    Close Browser


