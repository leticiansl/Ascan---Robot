*** Settings ***
Documentation   Esta suíte testa as páginas do gerente
Resource        ../../resources/main.robot
Test Setup      Acessar página de login do gerente
Test Teardown   Fechar o navegador

*** Test Cases ***
TM 01 - Cadastrar cliente
    [Documentation]     Realizar o cadastro de um novo cliente com sucesso
    [Tags]              FB    Manager
    Dado que realizei o login como gerente do banco
    Quando clico para adicionar um cliente
    E preencho os campos com dados válidos
    E clico para confirmar o cadastro do cliente
    Então o alerta de cadastro sucedido é exibido
    E o cliente é exibido na aba Customers

TM 02 - Abrir conta
    [Documentation]     Realizar a abertura de conta de um cliente cadastrado 
    [Tags]              FB    Manager
    Dado que realizei o login como gerente do banco
    Quando clico para abrir uma conta
    E seleciono um cliente
    E seleciono uma moeda
    E confirmo a abertura da conta
    Então o alerta de abertura sucedida é exibido
    E a conta do cliente é exibida na aba Customers

TM 03 - Buscar cliente
# Teste irá falhar devido a um bug no sistema
    [Documentation]     Realizar a busca por nome completo de um cliente cadastrado 
    [Tags]              FB    Manager
    Dado que realizei o login como gerente do banco
    Quando clico para visualizar os clientes
    E pesquiso o nome de um cliente
    Então o cliente é exibido na aba Customers

TM 04 - Deletar cliente
# Teste irá falhar devido a um erro na implementação
    [Documentation]     Realizar a exclusão de um cliente cadastrado 
    [Tags]              FB    Manager
    Dado que realizei o login como gerente do banco
    Quando pesquiso o nome de um cliente
    E clico para deletar o cadastro
    Então o cadastro do cliente é excluido do sistema

