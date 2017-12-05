*** Settings ***
Library  Selenium2Library

*** Variables ***
${PRODUCT_TABLE_LOCATOR}  xpath=//form/table[1]
${PRODUCT_TABLE_ELEMENTS_LOCATOR}  //form/table[1]//tr

*** Keywords ***

Get Product Table Elements
    Wait Until Element Is Visible  ${PRODUCT_TABLE_ELEMENTS_LOCATOR}
    ${productTableElementList}  Get Webelements  ${PRODUCT_TABLE_ELEMENTS_LOCATOR}
    [Return]  ${productTableElementList}

Get Row Element By Name
    [Arguments]  ${Name}
    ${productTableElementList}  Get Webelements  ${PRODUCT_TABLE_ELEMENTS_LOCATOR}
    ${nameElement}  Get Webelement  xpath=//form/table[1]/tr

Get Quantity Element Locator By Name
    [Arguments]  ${Name}
    ${quantityElementLocator}  Catenate  SEPARATOR=  xpath=//form/table[1]/tr/td[text()='  ${Name}
    ${quantityElementLocator}  Catenate  SEPARATOR=  ${quantityElementLocator}  ']/following-sibling::td/input[@id='line_item_quantity_  ${Name}
    ${quantityElementLocator}  Catenate  SEPARATOR=  ${quantityElementLocator}  ']
    [Return]  ${quantityElementLocator}

Old Get Quantity Element By Name
    [Arguments]  ${Name}
    ${quantityElementLocator}  Get Quantity Element Locator By Name  ${Name}
    ${quantityElement}  Get Webelement  ${quantityElementLocator}
    [Return]  ${quantityElement}

Get Quantity Element By Name
    [Arguments]  ${Name}
    ${quantityElementLocator}  Catenate  SEPARATOR=  id=line_item_quantity_  ${Name}
    ${quantityElement}  Get Webelement  ${quantityElementLocator}
    [Return]  ${quantityElement}

Enter Quantity By Name
    [Arguments]  ${Name}  ${Quantity}
    ${quantityElement}  Get Quantity Element By Name  ${Name}
    Wait Until Element Is Visible  ${quantityElement}
    Input Text  ${quantityElement}  ${Quantity}


Get State Element By Value
    [Arguments]  ${State}
    ${stateElementByValue}  Get State Element By Value  ${State}

Select State By Value
    [Arguments]  ${State}
    ${stateSelectElementLocator}  Get Webelement  //select[@name='state']
    Select From List By Value  ${stateSelectElementLocator}  ${State}

Submit Form
    ${submitInputElementLocator}  Get Webelement  //form/input[@name='commit']
    Wait Until Element Is Visible  ${submitInputElementLocator}
    Click Element  ${submitInputElementLocator}

Get Product TR
    [Arguments]  ${Name}  ${RowNumber}
    ${productTableElementList}  Get Product Table Elements
    ${productTableTRElement}  Get Product Table Elements
    ${productTableElementList}  Get Webelements  ${PRODUCT_TABLE_ELEMENTS_LOCATOR}
    :FOR  ${productTRElement}  IN  ${productTableElementList}
    \    ${name}  Get Text  ${PRODUCT_TABLE_ELEMENTS_LOCATOR}[2]

Get Product Table Cell
    [Arguments]  ${Row}  ${Column}
    Wait Until Element Is Visible  ${PRODUCT_TABLE_LOCATOR}
    Log To Console  Getting table cell ${Row} ${Column}...
    ${cellContents}  Get Table Cell  ${PRODUCT_TABLE_LOCATOR}  ${Row}  ${Column}
    [Return]  ${cellContents}


