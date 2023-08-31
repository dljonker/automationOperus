*** Settings ***
Documentation    Essa suite testa o Operus
Resource         automationOperusResources.robot
Test Setup       Start Browser
Test Teardown    Stop Browser


*** Test Cases ***

Login Tests
    [Documentation]    Este teste verifica a tela de login do sistema.
    [Tags]    login
    Login Page
    Empty Credentials
    Empty Username
    Empty Password
    Wrong Credentials
    Wrong User
    Wrong Password
    Uppercase Password
    Correct Login

Licence Tests
    [Documentation]    Esse teste verifica o licenciamento do sistema
    [Tags]    licence
    Licence Page
    Licence Manipulation