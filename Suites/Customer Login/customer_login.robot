*** Settings ***
Documentation    Esta suíte testa as páginas do Cliente
Resource         ../../resources/main.robot
Test Setup       Acessar página de login do cliente
Test Teardown    Fechar o navegador

*** Test Cases ***
TC 01 - Realizar login
    [Documentation]     Realizar o login do usuário com sucesso
    [Tags]              FB    Customer
    Dado que estou na página de login
    Quando seleciono um nome
    E clico em Login
    Então os dados da conta são exibidos

TC 02 - Realizar depósito
    [Documentation]     Realizar um depósito com sucesso
    [Tags]              FB    Customer
    Dado que realizei o login como cliente do banco
    Quando clico para realizar um depósito
    E informo um valor
    E confirmo o depósito do valor
    Então a mensagem de depósito sucedido é exibida
    E o valor de saldo é incrementado
     
 TC 03 - Realizar saque
    [Documentation]     Realizar um saque com sucesso
    [Tags]              FB    Customer
    Dado que realizei o login como cliente do banco
    Quando clico para realizar um saque
    E informo um valor menor que o saldo
    E confirmo o saque do valor
    Então a mensagem de transação sucedida é exibida
    E o saldo é decrementado

 TC 04 - Realizar logout
    [Documentation]     Realizar o logout com sucesso
    [Tags]              FB    Customer
    Dado que realizei o login como cliente do banco
    Quando clico em logout
    Então a página de login é exibida
