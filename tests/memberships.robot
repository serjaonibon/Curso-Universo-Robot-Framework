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

