*** Settings ***
Library   Collections
Library   String
Resource  ../pages/OrderPage.robot
Resource  ../pages/OrderConfirmationPage.robot

*** Variables ***
${NAME_COLUMN_NUMBER}  1

*** Keywords ***
Process Row
    [Arguments]  ${Row}  ${RowElement}
    Set Test Variable  ${rowNumberByName}  ${EMPTY}
    :FOR  ${column}  IN  1  2  3  4
    \    Log To Console  Get Text  ${RowElement}
    \    ${tableCell}  Get Product Table Cell  ${Row}  ${column}
    \    Log To Console  ${tableCell}

Get Row Number By Name
    [Arguments]  ${Row}  ${RowElement}  ${Name}
    :FOR  ${rowNumber}  IN  2  3  4  5
    \    ${rowElementName}  Get Product Table Cell  ${Row}  ${NAME_COLUMN_NUMBER}
    \    Log To Console  RowElementName is ${RowElementName}
    \    Log To Console  Name is ${Name}
    \    Return From Keyword If  '${RowElementName}' == '${Name}'  ${rowNumber}
    [Return]  ${EMPTY}

Enter Order Data On Form
    [Arguments]  ${OrderTestData}
    Log To Console  Name is ${OrderTestData.name()}
    Log To Console  Quantity is ${OrderTestData.quantityOrdered()}
    Enter Quantity By Name  ${OrderTestData.name()}  ${OrderTestData.quantityOrdered()}

    Log To Console  State is ${OrderTestData.state()}
    Select State By Value  ${OrderTestData.state()}

Remove Dollar Sign
    [Arguments]  ${DollarValue}
    ${floatValue}  Get Substring  ${DollarValue}  1
    [return]  ${floatValue}

Verify Order
    [Arguments]  ${OrderTestData}
    ${orderSubtotal}  Get Order Subtotal
    Log To Console  Order Subtotal is ${orderSubtotal}
    ${orderSubtotalFloat}  Remove Dollar Sign  ${orderSubtotal}

    ${orderTaxes}  Get Order Taxes
    Log To Console  Order Taxes is ${orderTaxes}
    ${orderTaxesFloat}  Remove Dollar Sign  ${orderTaxes}

    ${orderTotal}  Get Order Total
    Log To Console  Order Total is ${orderTotal}
    ${orderTotalFloat}  Remove Dollar Sign  ${orderTotal}

    # ${expectedOrderSubtotal}  Evaluate  ${OrderTestData.quantityOrdered()} * ${OrderTestData.price(${OrderTestData.name()})}
    ${name}  Set Variable  ${OrderTestData.name()}
    Log To Console  Name is ${name}
    ${expectedOrderSubtotal}  Evaluate  ${OrderTestData.quantityOrdered()} * ${OrderTestData.price(name='${name}')}
    Should Be Equal As Numbers  ${expectedOrderSubtotal}  ${orderSubtotalFloat}

    ${state}  Set Variable  ${OrderTestData.state()}
    ${expectedSalesTax}  Set Variable  ${OrderTestData.salesTaxByState(state='${state}')}
    Should Be Equal As Numbers  ${expectedSalesTax}  ${orderTaxesFloat}

    ${expectedTotal}  Set Variable  ${OrderTestData.orderTotal()}
    Should Be Equal As Numbers  ${expectedTotal}  ${orderTotalFloat}

Run Order Test With Order Test Data
    [Arguments]  ${OrderTestData}  ${URL}
    Go To  ${URL}
    Enter Order Data On Form  ${OrderTestData}
    Submit Form
    Verify Order  ${OrderTestData}

    Log To Console  ***** Test Passed *****

