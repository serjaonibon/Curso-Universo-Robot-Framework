*** Settings ***
Documentation        Arquivo principal do projeto Robot

Library            JSONLibrary

Library             Browser
Library             libs/Account.py
Library             libs/Database.py

Resource            pages/Landing.resource
Resource            pages/Welcome.resource
Resource            pages/login.resource
Resource            pages/Accounts.resource
Resource            pages/Memberships.resource

Resource            pages/Components/Navbar.resource
Resource            pages/Components/Toast.resource
Resource            pages/Components/BoxNotice.resource

*** Variables ***
${ADMIN_EMAIL}        sac@smartbit.com    
${ADMIN_PASS}         pwd123



#Helpers
*** Keywords ***
Start session
    New Browser    browser=chromium    headless=False
    New Page       http://localhost:3000/ 

Get Json fixture
    [Arguments]        ${file_name}    ${scenario}

    ${data}    Load Json From File    
    ...        C:/QAx/projects/smartbit-robot/resourses/fixtures/${file_name}.json
    ...    encoding=utf-8
    
    
    RETURN    ${data}[${scenario}]

SignIn admin
    
    Go to login pages
    Submit login form    ${ADMIN_EMAIL}    ${ADMIN_PASS} 
    User is logged in    ${ADMIN_EMAIL} 
    #Sleep    5



        