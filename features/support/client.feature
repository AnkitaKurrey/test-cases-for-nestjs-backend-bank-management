Feature: all the features intended for customer

Background: login as customeer
Given I store the raw value { "email" : "ankita@mymoneykarma.com", "password": "Ankita" } as bodyData in scenario scope
And I set body to `bodyData`
When I POST to /user
Then response code should be 201
Then response body should be valid json
Then I store the value of body path $.accessToken as accessToken in global scope

Scenario: create new account
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"accountHolderName": "Sonal","contactNumber": 495677,"accountType": "saving"} as CreateAccount in scenario scope
And I set body to `CreateAccount`
When I POST to /bank
Then response code should be 201
And response body should be valid json

Scenario: missing field while creating new account
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"accountHolderName": "rugma","contactNumber": 495677} as MissingAccDetails in scenario scope
And I set body to `MissingAccDetails`
When I POST to /bank
Then response code should be 400
And response body should be valid json
And response body should contain message

Scenario: extra input field while creating new account
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"accountHolderName": "Ankita","contactNumber": 495677,"accountType": "saving","currentBalance":8000} as ExtraAccDetails in scenario scope
And I set body to `ExtraAccDetails`
When I POST to /bank
Then response code should be 400
And response body should be valid json
And response body should contain message

##############################################################################

Scenario: get account details
Given I set authorizaion header to bearer `accessToken`
When I GET /bank
Then response code should be 200
And response body should be valid json

#################################################################################

Scenario: can deposit amount
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"amount": 10000,"accountNumber": 40204926} as AmountDeposit in scenario scope
And I set body to `AmountDeposit`
When I POST to /bank/deposit
Then response code should be 201
And response body should be valid json

Scenario: missing fields while depositing amount
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"accountNumber": 40204926} as AmountDeposit in scenario scope
And I set body to `AmountDeposit`
When I POST to /bank/deposit
Then response code should be 400
And response body should be valid json

Scenario: extra fields while depositing amount
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"amount": 10000,"accountNumber": 40204926,"accountType":"loan"} as AmountDeposit in scenario scope
And I set body to `AmountDeposit`
When I POST to /bank/deposit
Then response code should be 400
And response body should be valid json

Scenario:  try to deposit 0 amount
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"amount": 0,"accountNumber": 40204926} as AmountDeposit in scenario scope
And I set body to `AmountDeposit`
When I POST to /bank/deposit
Then response code should be 400
And response body should be valid json

Scenario:  try to deposit amount in wrong account
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"amount": 100,"accountNumber": 4020492} as AmountDeposit in scenario scope
And I set body to `AmountDeposit`
When I POST to /bank/deposit
Then response code should be 404
And response body should be valid json

##############################################################

Scenario: can withdraw amount
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"amount": 10,"accountNumber": 40204926} as AmountWithdraw in scenario scope
And I set body to `AmountWithdraw`
When I POST to /bank/withdraw
Then response code should be 201
And response body should be valid json

Scenario: if customer wtry to withdraw amount more than balance in his account
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"amount":10000000,"accountNumber":40204926} as AmountWithdraw in scenario scope
And I set body to `AmountWithdraw`
When I POST to /bank/withdraw
Then response code should be 400
And response body should be valid json

Scenario:  try to withdraw amount from wrong account
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"amount": 100,"accountNumber": 137397} as AmountDeposit in scenario scope
And I set body to `AmountDeposit`
When I POST to /bank/deposit
Then response code should be 404
And response body should be valid json

Scenario:  try to withdraw 0 amount
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"amount": 0,"accountNumber": 40204926} as AmountDeposit in scenario scope
And I set body to `AmountDeposit`
When I POST to /bank/withdraw
Then response code should be 400
And response body should be valid json

#######################################################################

Scenario: can transfer amount from one account to another
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"receiversAccountNumber": 48215723,"amount": 50,"sendersAccountNumber":40204926} as AmountTransfer in scenario scope
And I set body to `AmountTransfer`
When I POST to /bank/transfer
Then response code should be 201
And response body should be valid json

Scenario: if receiversAccountNumber is wrong
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"receiversAccountNumber": 4817,"amount": 50,"sendersAccountNumber":40204926} as AmountTransfer in scenario scope
And I set body to `AmountTransfer`
When I POST to /bank/transfer
Then response code should be 404
And response body should be valid json

Scenario: if sendersAccountNumber is wrong
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"receiversAccountNumber": 48215723,"amount": 50,"sendersAccountNumber":1373979} as AmountTransfer in scenario scope
And I set body to `AmountTransfer`
When I POST to /bank/transfer
Then response code should be 404
And response body should be valid json

Scenario: if senders do not have enough balance to transfer amount
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"receiversAccountNumber": 48215723,"amount": 10000000,"sendersAccountNumber":40204926} as AmountTransfer in scenario scope
And I set body to `AmountTransfer`
When I POST to /bank/transfer
Then response code should be 400
And response body should be valid json

Scenario:  try to transfer 0 amount
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"receiversAccountNumber": 48215723,"amount": 0,"sendersAccountNumber":40204926} as AmountTransfer in scenario scope
And I set body to `AmountTransfer`
When I POST to /bank/transfer
Then response code should be 400
And response body should be valid json

###############################################################################

Scenario: get current balance
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"accountNumber": 40204926} as CurrentBalance in scenario scope
And I set body to `CurrentBalance`
When I POST to /bank/currentBalance
Then response code should be 201
And response body should be valid json

Scenario: if account number is invalid
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"accountNumber": 34461402} as CurrentBalance in scenario scope
And I set body to `CurrentBalance`
When I POST to /bank/currentBalance
Then response code should be 404
And response body should be valid json

##########################################################################

Scenario: can request for update in account details
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"accountHolderName": "AKkurrey","contactNumber":7879977} as UpdateUser in scenario scope
And I set body to `UpdateUser`
When I PATCH /bank/requestUpdate/40204926
Then response code should be 200
And response body should be valid json

Scenario: if account number is invalid
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"accountHolderName": "AKkurrey","contactNumber":7879977} as UpdateUser in scenario scope
And I set body to `UpdateUser`
When I PATCH /bank/requestUpdate/40385321
Then response code should be 404
And response body should be valid json

Scenario: if user inputs extra fiels
Given I set authorizaion header to bearer `accessToken`
And I store the raw value {"accountHolderName": "AKkurrey","contactNumber":7879977,"currentBalance":78998} as UpdateUser in scenario scope
And I set body to `UpdateUser`
When I PATCH /bank/requestUpdate/40385321
Then response code should be 400
And response body should be valid json











