*** Settings ***
Documentation     Esta suíte realiza o fluxo solicitado pelo desafio
Resource          ../../resources/main.robot
Suite Setup       Acessar página de login do gerente
Suite Teardown    Fechar o navegador

*** Test Cases ***
E2E - Cadastro e login
    [Documentation]     Realizar o login e cadastro usuário com sucesso
    [Tags]              E2E
    Dado que realizei o login como gerente do banco
    Quando cadastro um cliente
    E abro sua conta
    E realizo o login
    Então os dados da nova conta são exibidos

*** Keywords ***
Quando cadastro um cliente
    Dado que realizei o login como gerente do banco
    Quando clico para adicionar um cliente
    E preencho os campos com dados válidos
    E clico para confirmar o cadastro do cliente
    Então o alerta de cadastro sucedido é exibido

E abro sua conta
    Dado que realizei o login como gerente do banco
    Quando clico para abrir uma conta
    E seleciono o cliente criado
    E seleciono uma moeda
    E confirmo a abertura da conta
    Então o alerta de abertura sucedida é exibido

E realizo o login
    Clicar em Home
    Clicar em Customer Login
    Dado que estou na página de login
    Quando seleciono o nome do novo cliente
    E clico em Login

