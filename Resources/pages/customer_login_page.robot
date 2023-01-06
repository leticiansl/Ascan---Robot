*** Settings ***
Resource    ../main.robot

*** Variables ***
&{login}
### Button ###
...    bt_Home=//button[@class='btn home'][contains(.,'Home')]
...    bt_Login=//button[@class='btn btn-default'][contains(.,'Login')]
### Select ###
...    sel_Name=id:userSelect


*** Keywords ***
###  General Customer Login
Dado que realizei o login como cliente do banco
    Dado que estou na página de login
    Quando seleciono um nome
    E clico em Login    

###  TC 01 - Realizar login  
Dado que estou na página de login
    Então a página de login é exibida

Quando seleciono um nome
    Select From List By Label           ${login.sel_Name}     ${data_Customer.FirstName} ${data_Customer.LastName}

E clico em Login
    Click Element    ${login.bt_Login}
    Wait Until Page Contains Element    ${acc.msg_Welcome}    ${gen.Timeout}

###  TC 04 - Realizar logout
Então a página de login é exibida
    Wait Until Page Contains Element    ${login.sel_Name}     ${gen.Timeout}
    