*** Settings ***
Library   Selenium2Library

*** Variables ***
${ORDER_SUBTOTAL_ELEMENT_LOCATOR}  xpath=id("subtotal")
${ORDER_TAXES_ELEMENT_LOCATOR}  xpath=id("taxes")
${ORDER_TOTAL_ELEMENT_LOCATOR}  xpath=id("total")

*** Keywords ***

Get Order Subtotal
    Wait Until Element Is Visible  ${ORDER_SUBTOTAL_ELEMENT_LOCATOR}
    ${orderSubtotal}  Get Text  ${ORDER_SUBTOTAL_ELEMENT_LOCATOR}
    [Return]  ${orderSubtotal}

Get Order Taxes
    Wait Until Element Is Visible  ${ORDER_TAXES_ELEMENT_LOCATOR}
    ${orderTaxes}  Get Text  ${ORDER_TAXES_ELEMENT_LOCATOR}
    [Return]  ${orderTaxes}

Get Order Total
    Wait Until Element Is Visible  ${ORDER_TOTAL_ELEMENT_LOCATOR}
    ${orderTotal}  Get Text  ${ORDER_TOTAL_ELEMENT_LOCATOR}
    [Return]  ${orderTotal}
