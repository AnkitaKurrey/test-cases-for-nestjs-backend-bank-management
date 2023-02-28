Feature: all the features intended for manager

Background: login as customeer
Given I store the raw value {"email":"309302219011@bitraipur.ac.in","password":"Manager"} as bodyData in scenario scope
And I set body to `bodyData`
When I POST to /user
Then response code should be 201
Then response body should be valid json
Then I store the value of body path $.accessToken as accessToken in global scope

Scenario: get all requested updates from customer
Given I set authorizaion header to bearer `accessToken`
When I GET /bank/showUpdates
Then response code should be 200
And response body should be valid json

Scenario: manager makes all the changes
Given I set authorizaion header to bearer `accessToken`
When I PATCH /bank/updatePending/1
Then response code should be 200
And response body should be valid json

Scenario: if id is invalid
Given I set authorizaion header to bearer `accessToken`
When I PATCH /bank/updatePending/8
Then response code should be 404
And response body should be valid json

