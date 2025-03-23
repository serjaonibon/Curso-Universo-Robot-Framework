*** Settings ***
Documentation        Cenário de testes de pré-cadastro de clientes
#Library    ../resourses/libs/Account.py
Resource        ../resourses/Base.resource

Test Setup        Start session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve iniciar o cadastro do cliente
    [Tags]    smoke

    ${account}             Create Dictionary
    ...                    name=Papito Fernando
    ...                    email=papito@msn.com
    ...                    cpf=06097411871
    
    Delete Account By Email    ${account}[email]
    
    Submit signup form       ${account}
    Verify welcome message


Tentativa de pré-cadastro
    [Template]        Attempt signup
    ${EMPTY}           papito@gmail.com    62665766353    Por favor informe o seu nome completo
    Fernando Papito    ${EMPTY}            62665766353    Por favor, informe o seu melhor e-mail
    Fernando Papito    papito@gmail.com    ${EMPTY}       Por favor, informe o seu CPF
    Sergio Nibon       papito$gmail.com    62665766353    Oops! O email informado é inválido
    Ana Nibon          sergio@gmail.com    6266576635A    Oops! O CPF informado é inválido


*** Keywords ***
Attempt signup
    [Arguments]    ${name}    ${email}    ${cpf}    ${output_messege}    


    ${account}            Create Dictionary
    ...    name=${name}
    ...    email=${email} 
    ...    cpf=${cpf} 

    Submit signup form    ${account}
    Notice should be    ${output_messege}
