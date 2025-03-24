*** Settings ***
Documentation        Suite de teste de adesões de planos

Resource        ../resourses/Base.resource
Resource        ../resourses/pages/login.resource


Test Setup        Start session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve poder realizar uma nova adesão

    ${data}    Get Json fixture        memberships        create
 
    Delete Account By Email        ${data}[account][email]
    Insert Account                 ${data}[account]

    SignIn admin
    Go to memberships 
    Creat new membership    ${data}        
    #Isso foi utilizado para na hora de gerar o log, 
    # trazer uma informação que é oculta
    # ${html}    Get Page Source
    # Log    ${html}
    Toast should be    Matrícula cadastrada com sucesso.
   
   #Sleep    5

Não deve realizar adesão qduplicada
    [Tags]        dup

    ${data}    Get Json fixture        memberships        duplicate

    Insert Membership    ${data}

    SignIn admin
    Go to memberships     
    Creat new membership    ${data}
    Toast should be    O usuário já possui matrícula.

Deve buscar por nome
    [Tags]        search

    ${data}    Get Json fixture    memberships    search


    Insert Membership    ${data}

    SignIn admin
    Go to memberships
    Search by name          ${data}[account][name]
    Shold filter by name    ${data}[account][name]

Deve excluir uma matrícula 
    [Tags]    remove   

    ${data}    Get Json fixture    memberships    remove


    Insert Membership    ${data}

    SignIn admin
    Go to memberships
    Request remove    ${data}[account][name]
    Confirm removal
    Membership should not be visible    ${data}[account][name]


    


    




