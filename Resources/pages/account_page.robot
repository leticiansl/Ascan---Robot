*** Settings ***
Resource    ../main.robot
Library    Collections

*** Variables ***
&{acc}
### Button ###
...    bt_Home=//button[@class='btn home'][contains(.,'Home')]
...    bt_Logout=//button[@ng-show='logout'][contains(.,'Logout')]
...    bt_Transactions=//button[@ng-class='btnClass1'][contains(.,'Transactions')]
...    bt_Deposit=//button[@ng-class='btnClass2'][contains(.,'Deposit')]
...    bt_Withdrawl=//button[@ng-class='btnClass3'][contains(.,'Withdrawl')]
### Input ###
...    inp_Amount=//input[@ng-model='amount']
### Message ###
...    msg_DepositSuccess=//span[@class='error ng-binding'][contains(.,'Deposit Successful')]
...    msg_TransactionSucess=//span[@class='error ng-binding'][contains(.,'Transaction successful')]
...    msg_Welcome=//strong[contains(.,'Welcome ${data_Customer.FirstName} ${data_Customer.LastName} !!')]                                                                      
### Select ###
...    sel_AccNumber=id:accountSelect
### Submit ###
...    sub_Deposit=//button[@type='submit'][contains(.,'Deposit')]
...    sub_Withdrawl=//button[@type='submit'][contains(.,'Withdraw')]
### Others ###
...    balance=(//strong[@class='ng-binding'])[2]

*** Keywords ***
### General 
Get Balance
    ${value}=       Get Text    ${acc.balance}
    ${value}=       Convert To Integer    ${value}   
    Set To Dictionary    ${data_Customer}    Balance    ${value}

Increased Balance   
    [Return]    ${{${data_Customer.Balance}+${data_Customer.DepositValue}}}

Decreased Balance
    [Return]    ${${data_Customer.Balance}-${data_Customer.WithdrawlValue}}

Dados da conta são exibidos
    [Arguments]      &{CUSTOMER}
    Page Should Contain         ${CUSTOMER.FirstName} ${CUSTOMER.LastName}    ${gen.Timeout}

###  TC 01 - Realizar login  
Então os dados da conta são exibidos
    Dados da conta são exibidos    &{data_Customer}

Então os dados da nova conta são exibidos
    Dados da conta são exibidos    &{data_newCustomer}

###  TC 02 - Realizar depósito
Quando clico para realizar um depósito
    Get Balance
    Click Element    ${acc.bt_Deposit}

E informo um valor
    Wait Until Element Is Visible          ${acc.inp_Amount}                            ${gen.Timeout}
    Input Text        ${acc.inp_Amount}    ${data_Customer.DepositValue}

E confirmo o depósito do valor
    Click Element    ${acc.sub_Deposit}

Então a mensagem de depósito sucedido é exibida
    Page Should Contain Element    ${acc.msg_DepositSuccess}                            

E o valor de saldo é incrementado
    ${value}=    Increased Balance
    Page Should Contain         Balance : ${value}             

###  TC 03 - Realizar saque
Quando clico para realizar um saque
    Get Balance
    Click Element    ${acc.bt_Withdrawl}

E informo um valor menor que o saldo
    Wait Until Element Is Visible          ${acc.inp_Amount}                            ${gen.Timeout}              
    Input Text        ${acc.inp_Amount}    ${data_Customer.WithdrawlValue}

E confirmo o saque do valor
    Click Element    ${acc.sub_Withdrawl}

Então a mensagem de transação sucedida é exibida
    Page Should Contain Element    ${acc.msg_TransactionSucess}                       

E o saldo é decrementado
    ${value}=    Decreased Balance
    Page Should Contain         Balance : ${value}                                 

###  TC 04 - Realizar logout
Quando clico em logout
    Click Element    ${acc.bt_Logout}
