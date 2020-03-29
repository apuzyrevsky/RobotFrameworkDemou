*** Settings ***
Documentation     A test suite containing tests related to invalid login.
...
...               These tests are data-driven by their nature. They use a single
...               keyword, specified with Test Template setting, that is called
...               with different arguments to cover different scenarios.
...
...               This suite also demonstrates using setups and teardowns in
...               different levels.
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup        Go To Login Page
Test Template     Login With Invalid Credentials Should Fail
Resource          resource.robot

*** Test Cases ***               USERNAME        PASSWORD              ERROR MESSAGE
Invalid Username And Password    invalid          whatever             Epic sadface: Username and password do not match any user in this service
Empty Username                   ${EMPTY}         ${VALID PASSWORD}    Epic sadface: Username is required
Empty Password                   ${VALID USER}    ${EMPTY}             Epic sadface: Password is required

*** Keywords ***
Login With Invalid Credentials Should Fail
    [Arguments]    ${username}    ${password}    ${message}
    Input Username    ${username}
    Input Password    ${password}
    Click Login Button
    Element Text Should Be  //*[@id="login_button_container"]/div/form/h3   ${message}
