*** Settings ***
Documentation   Essa suíte expecifica as Keywords de Setup e Teardown
Resource        ../main.robot

*** Keywords ***
### General Setup 
Abrir o navegador
    Open Browser    browser=${gen.Browser}    options=add_experimental_option('excludeSwitches', ['enable-logging'])
    Maximize Browser Window
    
E acessar o site do banco
    Go To           ${gen.URL}
    Wait Until Element Is Visible    ${home.bt_Home}    ${gen.Timeout}

### Customer Login Setup 
Acessar página de login do cliente
    Abrir o navegador
    E acessar o site do banco
    Clicar em Customer Login

### Bank Manager Login Setup 
Acessar página de login do gerente
    Abrir o navegador
    E acessar o site do banco
    Clicar em Bank Manager Login

### General Teardown 
Fechar o navegador
    Sleep    1s
    Close Browser




