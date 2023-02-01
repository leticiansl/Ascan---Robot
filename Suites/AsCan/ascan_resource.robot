*** Settings ***
Resource    ../../resources/main.robot

*** Keywords ***
Dado que realizei o login como gerente do banco
    Wait Until Element Is Visible    ${manager.bt_AddCustomer}       ${gen.Timeout}

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

Quando clico para abrir uma conta
    Click Element    ${manager.bt_OpenAccount}

E seleciono o cliente criado
    Wait Until Element Is Visible    ${manager.sel_Customer}    ${gen.Timeout}
    Select From List By Label        ${manager.sel_Customer}    ${data_newCustomer.FirstName} ${data_newCustomer.LastName}

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

Clicar em Home
    Click Element    locator=${home.bt_Home}

Clicar em Customer Login
    Click Element    locator=${home.bt_CustomerLogin}

Dado que estou na página de login
    Wait Until Page Contains Element    ${login.sel_Name}     ${gen.Timeout}
    
Quando seleciono o nome do novo cliente
    Select From List By Label           ${login.sel_Name}     ${data_newCustomer.FirstName} ${data_newCustomer.LastName}

E clico em Login
    Click Element    ${login.bt_Login}

Então os dados da nova conta são exibidos
    Page Should Contain         ${data_newCustomer.FirstName} ${data_newCustomer.LastName}    ${gen.Timeout}
