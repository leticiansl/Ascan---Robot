*** Settings ***
Resource    ../main.robot

*** Variables ***
&{home}
### Button ###
...    bt_Home=//button[@class='btn home'][contains(.,'Home')]
...    bt_CustomerLogin=//button[contains(.,'Customer Login')]
...    bt_BankManagerLogin=//button[contains(.,'Bank Manager Login')]

*** Keywords ***
Clicar em Customer Login
    Click Element    locator=${home.bt_CustomerLogin}

Clicar em Bank Manager Login
    Click Element    locator=${home.bt_BankManagerLogin}
