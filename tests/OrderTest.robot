*** Settings ***
Documentation    Suite description
Library   OperatingSystem
Library   Selenium2Library
Library   Collections
Library   CSVLibrary
Library   ../resources/lib/csvLibrary.py
Library   ../resources/lib/OrderTestData.py
Resource  ../resources/keywords/Browser.robot
Resource  ../resources/keywords/Order.robot

*** Variables ***
${testStartCounterOne} =  1
${testStopCounterNines} =  9999
${URL}  http://jungle-socks.herokuapp.com

*** Test Cases ***
Test Order Test Cases
    [Tags]    order

# ################################################################
# Setup
#
    Log To Console  ...
    Log To Console  Beginning Set Up....
    ${testStartCounter}  Get Environment Variable  TEST_START_COUNTER  default=${testStartCounterOne}
    Log To Console  testStartCounter is: ${testStartCounter}
    ${testStopCounter}  Get Environment Variable  TEST_STOP_COUNTER  default=${testStopCounterNines}
    Log To Console  testStopCounter is: ${testStopCounter}

    Start Selenium Tests  ${URL}
    # ${Filename}  Get Environment Variable  Filename  default=../data/jungle_socks_orders_all_states.csv
    ${testCases}=  Get List Of Dicts From CSV File  ${Filename}
    Log List  ${testCases}
    ${testCounter}  Set Variable  1
    ${testLimit}  Get Length  ${testCases}
    Log To Console  Set Up Complete.

# ################################################################
# Run Tests
#
    Log To Console  ...
    Log To Console  Beginning Tests...

    :FOR  ${testCase}  IN  @{testCases}
    \  Log Dictionary  ${testCase}
    \  Log To Console  ...
    \  Log To Console  Beginning Test ${testCounter} of ${testLimit}...
    \  Log To Console  ${testCase}
    \  ${testCounterNum}  Convert To Integer  ${testCounter}
    \  ${testStartCounterNum}  Convert To Integer  ${testStartCounter}
    \  ${testStopCounterNum}  Convert To Integer  ${testStopCounter}
    \  ${orderTestData}  setDict  ${testCase}
    \  Log to Console  ${orderTestData.name}
    \  Run Keyword If  ${testCounter} >= ${testStartCounterNum} and ${testCounter} <= ${testStopCounterNum}  Run Order Test With Order Test Data  ${orderTestData}  ${URL}
    \  Run Keyword Unless  ${testCounter} >= ${testStartCounterNum} and ${testCounter} <= ${testStopCounterNum}  Log To Console  ***** Test Skipped ******
    \  ${testCounter}  Evaluate  ${testCounter} + 1

    Log To Console  Testing Complete.

# ################################################################
# Teardown
#
    Log To Console  ...
    Log To Console  Beginning Tear Down...
    Stop Selenium Tests
    Log To Console  Tear Down Complete.

