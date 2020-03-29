*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${SERVER}           saucedemo.com
${BROWSER}          Chrome
${LOGIN URL}        https://www.${SERVER}/index.html
${STORE URL}        https://www.${SERVER}/inventory.html
${BASKET URL}       https://www.${SERVER}/cart.html
${STEP ONE URL}     https://www.${SERVER}/checkout-step-one.html
${STEP TWO URL}     https://www.${SERVER}/checkout-step-two.html
${DELAY}            0
${VALID USER}       standard_user
${VALID PASSWORD}   secret_sauce
${BACKPACK ITEM}    //*[@id="item_4_title_link"]
${firstname}        Tony
${lastname}         Stark
${postalcode}       42069

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
 #   Maximize Browser Window
    Set Selenium Speed    ${DELAY}

Go To Login Page
    Go To   ${LOGIN URL}
    Location Should Be    ${LOGIN URL}

Input Username
    [Arguments]    ${username}
    Input Text     user-name    ${username}

Input Password
    [Arguments]    ${password}
    Input Text     password    ${password}

Click Login Button
    Click Button    //*[@id="login_button_container"]/div/form/input[3]

Store Page Should be Open
    Location Should Be    ${STORE URL}

Valid Login
    Open Browser To Login Page
    Input Username  standard_user
    Input Password  secret_sauce
    Click Login Button
    Store Page Should be Open

Add Item To The Basket
    Click Element   ${BACKPACK ITEM}
    Click Element    //*[@id="inventory_item_container"]/div/div/div/button

Open Basket
    Click Element   shopping_cart_container
    Location Should Be  ${BASKET URL}

Check That Added Item Is Present
    Element Should Be Visible   ${BACKPACK ITEM}

Proceed To Check Out Step One
    Click Element   //*[@id="cart_contents_container"]/div/div[2]/a[2]
    Location Should Be  ${STEP ONE URL}
    
Fill in Personal Info
    [Arguments]     ${firstname}    ${lastname}     ${postalcode}
    Input Text      first-name       ${firstname}
    Input Text      last-name        ${lastname}
    Input Text      postal-code      ${postalcode}
    Click Element    //*[@id="checkout_info_container"]/div/form/div[2]/input

Finish Check Out
    Location Should Be  ${STEP TWO URL}
    Element Should Be Visible   ${BACKPACK ITEM}
    Click Element   //*[@id="checkout_summary_container"]/div/div[2]/div[8]/a[2]
    Element Should Be Visible   //*[@id="checkout_complete_container"]/h2
