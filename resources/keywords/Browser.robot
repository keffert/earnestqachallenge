*** Settings ***
Library  Selenium2Library

*** Keywords ***

Start Selenium Tests
    [Arguments]  ${URL}
    Open Browser  ${URL}  chrome
    Set Selenium Implicit Wait  30 seconds

Stop Selenium Tests
    Close Browser
