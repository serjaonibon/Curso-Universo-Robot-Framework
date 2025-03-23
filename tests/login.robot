*** Settings ***
Documentation        Cenário de testes do Login SAC

Resource        ../resourses/Base.resource
Resource    ../resourses/pages/login.resource

Test Setup       Start session
Test Teardown    Take Screenshot 


*** Test Cases ***
Deve logar como Gestor de Academia
    Go to login pages
    Submit login form    sac@smartbit.com    pwd123
    User is logged in    sac@smartbit.com

Não deve logar com senha incorreta
    [Tags]        inv_pass
    Go to login pages
    Submit login form    sac@smartbit.com    abc123

    Toast should be    As credenciais de acesso fornecidas são inválidas. Tente novamente!

Não deve logar com email não cadastrado
    [Tags]        email_404
    Go to login pages
    Submit login form  404@smartbit.com    abc123

    Toast should be    As credenciais de acesso fornecidas são inválidas. Tente novamente!    

    #Serve para salvar o HTML de uma página aula 33 -> 9minutos
    # Sleep    3
    # ${temp}    Get Page Source
    # Log        ${temp}
Tentativa de login com dados incorretos
    [Template]    Login with verify notice
    ${EMPTY}            ${EMPTY}    Os campos email e senha são obrigatórios.
    ${EMPTY}            pwd123      Os campos email e senha são obrigatórios.
    sac@smartbit.com    ${EMPTY}    Os campos email e senha são obrigatórios.
    www.teste.com.br    pwd123                                Oops! O email informado é inválido
    sac$smartbit.com    pwd123                                Oops! O email informado é inválido
    a@#jhjhjhjhjhjhr    pwd123                                Oops! O email informado é inválido
    aaaaaaaaaaaaaaaa    pwd123                                Oops! O email informado é inválido
    !@#$$#@!@@@@@@@@    pwd123                                Oops! O email informado é inválido

*** Keywords ***
Login with verify notice
    [Arguments]            ${email}    ${password}    ${output_message}

    Go to login pages
    Submit login form      ${email}    ${password}
    Notice should be       ${output_message}