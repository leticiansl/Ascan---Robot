*** Settings ***
Resource    ../main.robot

*** Variables ***
${accNumber}
&{manager}
### Button ###
...    bt_Home=//button[@class='btn home'][contains(.,'Home')]
...    bt_AddCustomer=//button[@ng-class='btnClass1'][contains(.,'Add Customer')]
...    bt_OpenAccount=//button[@ng-class='btnClass2'][contains(.,'Open Account')]
...    bt_Customers=//button[@ng-class='btnClass3'][contains(.,'Customers')]
...    bt_Delete=//button[@ng-click='deleteCust(cust)'][contains(.,'Delete')]
### Input ###
...    inp_FirstName=//input[contains(@ng-model,'fName')]
...    inp_LastName=//input[contains(@ng-model,'lName')]
...    inp_PostCode=//input[contains(@ng-model,'postCd')]
...    inp_SearchCustomer=//input[contains(@ng-model,'searchCustomer')]
### Message ###
...    msg_CustomerAdded=Customer added successfully with customer id
...    msg_AccCreated=Account created successfully with account Number
### Select ###
...    sel_Customer=userSelect
...    sel_Currency=currency
### Submit ###
...    sub_AddCustomer=//button[@type='submit'][contains(.,'Add Customer')]
...    sub_Process=//button[@type='submit'][contains(.,'Process')]

*** Keywords ***
### General  
Dado que realizei o login como gerente do banco
    Wait Until Element Is Visible    ${manager.bt_AddCustomer}       ${gen.Timeout}

Quando clico para visualizar os clientes
    Click Element    ${manager.bt_Customers}

Pesquiso o nome do cliente
    [Arguments]      ${NAME}
    Wait Until Element Is Visible    ${manager.inp_SearchCustomer}   ${gen.Timeout}
    Input Text       ${manager.inp_SearchCustomer}    ${NAME}

Cliente é exibido
    [Arguments]      &{CUSTOMER}
    Page Should Contain    ${CUSTOMER.FirstName}
    Page Should Contain    ${CUSTOMER.LastName}

Seleciono um cliente
    [Arguments]      &{CUSTOMER}
    Wait Until Element Is Visible    ${manager.sel_Customer}    ${gen.Timeout}
    Select From List By Label        ${manager.sel_Customer}    ${CUSTOMER.FirstName} ${CUSTOMER.LastName}

###  TM 01 - Cadastrar cliente 
Quando clico para adicionar um cliente
    Click Element    ${manager.bt_AddCustomer}

E preencho os campos com dados válidos
    Wait Until Element Is Visible    ${manager.inp_FirstName}        ${gen.Timeout}
    Input Text       ${manager.inp_FirstName}    ${data_newCustomer.FirstName}
    Input Text       ${manager.inp_LastName}     ${data_newCustomer.LastName}
    Input Text       ${manager.inp_PostCode}     ${data_newCustomer.PostCode}
    
E clico para confirmar o cadastro do cliente
    Click Element    ${manager.sub_AddCustomer}

Então o alerta de cadastro sucedido é exibido
    ${alertMessage}=   Handle Alert   
    Should Contain   ${alertMessage}           ${manager.msg_CustomerAdded}

E o cliente é exibido na aba Customers
    Quando clico para visualizar os clientes
    Pesquiso o nome do cliente    ${data_newCustomer.FirstName}
    Cliente é exibido             &{data_newCustomer}

###  TM 02 - Abrir conta 
Quando clico para abrir uma conta
    Click Element    ${manager.bt_OpenAccount}

E seleciono um cliente
    Seleciono um cliente             &{data_Customer}

E seleciono o cliente criado
    Seleciono um cliente             &{data_newCustomer}

E seleciono uma moeda
    Wait Until Element Is Visible    ${manager.sel_Currency}    ${gen.Timeout}
    Select From List By Index        ${manager.sel_Currency}    2

E confirmo a abertura da conta
    Click Element    ${manager.sub_Process}

Então o alerta de abertura sucedida é exibido
    Sleep    2s
    ${alertMessage}=   Handle Alert 
    ${accNumber}=    Fetch From Right          ${alertMessage}  :
    Should Contain   ${alertMessage}           ${manager.msg_AccCreated}

E a conta do cliente é exibida na aba Customers
    Quando clico para visualizar os clientes
    Pesquiso o nome do cliente    ${data_Customer.FirstName}
    Cliente é exibido             &{data_Customer}
    Page Should Contain           ${accNumber}


###  TM 03 - Buscar cliente 
E pesquiso o nome de um cliente
    Pesquiso o nome do cliente    ${data_Customer.FirstName} ${data_Customer.LastName}

Então o cliente é exibido na aba Customers
    Cliente é exibido             &{data_Customer}

###  TM 04 - Deletar cliente 
Quando pesquiso o nome de um cliente
    Pesquiso o nome do cliente    ${data_Customer.FirstName}

E clico para deletar o cadastro
    Click Element    ${manager.bt_Delete}

Então o cadastro do cliente é excluido do sistema
    Page Should Not Contain    ${data_Customer.FirstName}
    Page Should Not Contain    ${data_Customer.LastName}