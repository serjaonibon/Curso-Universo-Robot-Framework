*** Settings ***
Documentation        Ações e componentes do co,ponente Toast

Library        Browser


*** Keywords ***
Toast should be
    [Arguments]        ${expected_text}

    ${select}        Set Variable        .Toastify__toast-body

    Wait For Elements State    css=${select}
    ...    visible    5
    
    Get Text    css=${select}
    ...    equal    
    ...    ${expected_text}
    
    Take Screenshot    selector=${select}
