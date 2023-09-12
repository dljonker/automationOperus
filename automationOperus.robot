*** Settings ***
Documentation    Essa suite testa o Operus
Resource         automationOperusResources.robot
Test Setup       Start Browser
Test Teardown    Stop Browser


*** Test Cases ***

# Login Tests
#     [Documentation]    Este teste verifica a tela de login do sistema.
#     [Tags]    login
#     Login Page
#     Empty Credentials
#     Empty Username
#     Empty Password
#     Wrong Credentials
#     Wrong User
#     Wrong Password
#     Uppercase Password
#     Correct Login

# Licence Tests
#     [Documentation]    Esse teste verifica o licenciamento do sistema
#     [Tags]    licence
#     Licence Page
#     Licence Manipulation
    # Refazerm separando os testes

Account TimeSchedule Tests
    [Documentation]    Este teste verifica a função de adicionar/editar/remover tabelas de horário
    ...    de acesso da conta
    [Tags]    timetable
    Login Page
    Account Access Page "1000"
    TimeSchedule Tab
    Add TimeSchedule