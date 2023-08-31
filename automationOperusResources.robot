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
    Input Text    locator=//input[@name='password']   text=${Localpassword}
    Click Button    locator=//input[@class='btn btn-default btn-login']
Licence Page
    Login Page
    Correct Login Local
    Wait Until Element Is Visible    locator=//a[contains(.,'Licenças')]
    Click Element    locator=//a[contains(.,'Licenças')]
    Wait Until Element Is Visible    locator=//a[contains(.,'Licenças')]
    Element Should Be Visible    locator=//span[@class='text-bold ng-binding'][contains(.,'${identifier}')]

Insert Licences
    Element Should Be Visible    locator=//span[@ng-show='licenses == null'][contains(.,'Nenhum registro encontrado')]