*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${URL}    http://172.24.200.27:8080
${username}    admin
${password}    Sentinell
${localUsername}    admin
${localPassword}    seventh
${identifier}    JQ2I-ABXI-HAXB-EYWE
${localIdentifier}    Z3WW-PGGB-7QWW-EC3C
${localURL}    http://localhost:8080
${standardLicenceDemonstration}    GFX2UUKXLSSYHC3WW4IVASFQ
${standardLicence}    TLWHQKHTV5GSMW4R4R67OJQX
${incorrectStandardLicence}    MXGDJZENU6YZOLM3OQOTUGVT
# ${AccountCode}    1000

*** Keywords ***

Start Browser
    Open Browser    browser=Firefox
    Maximize Browser Window

Stop Browser
    Capture Page Screenshot
    Close Browser

Login Page
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=//input[@name='userName']

Login Page Local
    Go To    url=${localURL}
    Wait Until Element Is Visible    locator=//input[@name='userName']
Empty Credentials
    
    Click Button    locator=//input[@class='btn btn-default btn-login']
    Element Should Be Visible    locator=//div[@ng-show='errors'][contains(.,'Login inválido.')]

Empty Username
    Reload Page
    Wait Until Element Is Visible    locator=//input[@name='userName']
    Input Text    locator=//input[@name='password']   text=${password}
    Click Button    locator=//input[@class='btn btn-default btn-login']
    Element Should Be Visible    locator=//div[@ng-show='errors'][contains(.,'Login inválido.')]

Empty Password
    Reload Page
    Wait Until Element Is Visible    locator=//input[@name='userName']
    Input Text    locator=//input[@name='userName']    text=${username}
    Click Button    locator=//input[@class='btn btn-default btn-login']
    Element Should Be Visible    locator=//div[@ng-show='errors'][contains(.,'Login inválido.')]

Wrong Credentials
    Reload Page
    Wait Until Element Is Visible    locator=//input[@name='userName']
    Input Text    locator=//input[@name='userName']    text=username@user
    Input Text    locator=//input[@name='password']   text=Password@2023
    Click Button    locator=//input[@class='btn btn-default btn-login']
    Element Should Be Visible    locator=//div[@ng-show='errors'][contains(.,'Login inválido.')]

Wrong User
    Reload Page
    Wait Until Element Is Visible    locator=//input[@name='userName']
    Input Text    locator=//input[@name='userName']    text=username@user
    Input Text    locator=//input[@name='password']   text=${password}
    Click Button    locator=//input[@class='btn btn-default btn-login']
    Element Should Be Visible    locator=//div[@ng-show='errors'][contains(.,'Login inválido.')]

Wrong Password
    Reload Page
    Wait Until Element Is Visible    locator=//input[@name='userName']
    Input Text    locator=//input[@name='userName']    text=${username}
    Input Text    locator=//input[@name='password']   text=123456987@@2023
    Click Button    locator=//input[@class='btn btn-default btn-login']
    Element Should Be Visible    locator=//div[@ng-show='errors'][contains(.,'Login inválido.')]

Uppercase Password
    Reload Page
    Wait Until Element Is Visible    locator=//input[@name='userName']
    Input Text    locator=//input[@name='userName']    text=${username}
    Input Text    locator=//input[@name='password']   text=SENTINELL
    Click Button    locator=//input[@class='btn btn-default btn-login']
    Element Should Be Visible    locator=//div[@ng-show='errors'][contains(.,'Login inválido.')]

Correct Login
    Reload Page
    Wait Until Element Is Visible    locator=//input[@name='userName']
    Input Text    locator=//input[@name='userName']    text=${username}
    Input Text    locator=//input[@name='password']   text=${password}
    Click Button    locator=//input[@class='btn btn-default btn-login']
    Wait Until Element Is Visible    locator=//div[@class='section-header'][contains(.,'Atendimento')]

Correct Login Local
    Reload Page
    Wait Until Element Is Visible    locator=//input[@name='userName']
    Input Text    locator=//input[@name='userName']    text=${localUsername}
    Input Text    locator=//input[@name='password']   text=${localPassword}
    Click Button    locator=//input[@class='btn btn-default btn-login']
Licence Page
    Login Page Local
    Correct Login Local
    Wait Until Element Is Visible    locator=//a[contains(.,'Licenças')]
    Click Element    locator=//a[contains(.,'Licenças')]
    Wait Until Element Is Visible    locator=//a[contains(.,'Licenças')]
    Element Should Be Visible    locator=//span[@class='text-bold ng-binding'][contains(.,'${localIdentifier}')]

Licence Manipulation
    Element Should Be Visible    locator=//span[@ng-show='licenses == null'][contains(.,'Nenhum registro encontrado')]
    Click Button    locator=//button[@name='add'][contains(.,'Adicionar licença')]
    Wait Until Element Is Visible    locator=//label[@class='control-label'][contains(.,'Licença')]
    Input Text    locator=//input[contains(@ng-model,'license.serial')]    text=${incorrectStandardLicence}
    Click Button    locator=//button[@class='btn btn-primary btn-save btn-new-license'][contains(.,'Adicionar')]
    Wait Until Element Is Visible    locator=//div[@class='growl-message ng-binding'][contains(.,'A licença foi gerada para uma máquina diferente.')]
    Input Text    locator=//input[contains(@ng-model,'license.serial')]     text=${standardLicenceDemonstration}    clear=${True}
    Click Button    locator=//button[@class='btn btn-primary btn-save btn-new-license'][contains(.,'Adicionar')]
    Wait Until Element Is Visible    locator=//td[@class='ng-binding'][contains(.,'STPSTD-ENT')]    timeout=30
    Click Button    locator=//button[@name='add'][contains(.,'Adicionar licença')]
    Wait Until Element Is Visible    locator=//label[@class='control-label'][contains(.,'Licença')]
    Input Text    locator=//input[contains(@ng-model,'license.serial')]    text=${standardLicence}
    Click Button    locator=//button[@class='btn btn-primary btn-save btn-new-license'][contains(.,'Adicionar')]
    Wait Until Element Is Visible    locator=//code[@class='ng-binding'][contains(.,'TLWHQK-HTV5GS-MW4R4R-67OJQX')]

Account Access Page "${AccountCode}"
    ${Title}    Get Location
    ${sefude}    Set Variable    http://172.24.200.27:8080/app/login
    IF    $Title == $sefude
        Correct Login
        Go To    url=${URL}/app/v2/accounts/${AccountCode}/account-access
    ELSE
        Go To    url=${URL}/app/v2/accounts/${AccountCode}/account-access
    END    
    

TimeSchedule Tab
    Wait Until Element Is Visible    locator=//li[@class='tabs-grid-item tabs-number-3'][contains(.,'HORÁRIOS')]
    Click Element    locator=//li[@class='tabs-grid-item tabs-number-3'][contains(.,'HORÁRIOS')]

Add TimeSchedule
    Click Button    locator=//button[@name='add'][contains(.,'Adicionar horário')]
    Input Text    locator=//input[contains(@name,'name')]    text=Tabela de testes
    Input Text    locator=//input[contains(@name,'description')]    text=Tabela para testes automatizados
    Click Element    locator=//input[contains(@ng-model,'selectedDays.mondaySchedules')]
    Input Text    locator=//input[contains(@ng-model,'fromTime')]    text=1200
    Input Text    locator=//input[contains(@ng-model,'toTime')]    text=1300
    Click Element    locator=//button[@type='button'][contains(.,'Incluir')]
    Element Should Be Visible    locator=//span[@class='label label-g-scope'][contains(.,'12:00 às 13:00')]lg label-primary mx-1 ng-binding n
    Click Button    locator=//input[contains(@ng-model,'selectedDays.holiday1Schedules')]
    Input Text    locator=//input[contains(@ng-model,'fromTime')]    text=1300    clear=True
    Input Text    locator=//input[contains(@ng-model,'toTime')]    text=1500    clear=True
    Click Element    locator=//input[contains(@ng-model,'selectedDays.mondaySchedules')]
    Click Element    locator=//button[@type='button'][contains(.,'Incluir')]
    Element Should Be Visible    locator=//div[@class='custom-td-alignment ng-binding'][contains(.,'Segunda-feira')]
    Element Should Be Visible    locator=//div[@class='custom-td-alignment ng-binding'][contains(.,'Feriado 1')]
    Element Should Be Visible    locator=//span[@class='label label-lg label-primary mx-1 ng-binding ng-scope'][contains(.,'12:00 às 13:00')]
    Element Should Be Visible    locator=//span[@class='label label-lg label-primary mx-1 ng-binding ng-scope'][contains(.,'13:00 às 15:00')]
    Click Button    locator=//button[@class='btn btn-primary btn-save'][contains(.,'Salvar')]
    Element Should Be Visible    locator=//td[@class='ng-binding'][contains(.,'Tabela de testes')]