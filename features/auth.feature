Feature: User Authentication

Scenario: login as user
Given I store the raw value { "email" : "ankita@mymoneykarma.com", "password": "Ankita" } as bodyData in scenario scope
And I set body to `bodyData`
When I POST to /user
Then response code should be 201
Then response body should be valid json
Then response body should contain accessToken
Then I store the value of body path "$.accessToken" as access token

Scenario: login as user with incorrect password
Given I store the raw value { "email" : "ankita@mymoneykarma.com", "password": "Ankit" } as bodyData in scenario scope
And I set body to `bodyData`
When I POST to /user
Then response code should be 404
Then response body should be valid json

Scenario: login as user with not registered email
Given I store the raw value { "email" : "ankia@mymoneykarma.com", "password": "Ankita" } as bodyData in scenario scope
And I set body to `bodyData`
When I POST to /user
Then response code should be 404
Then response body should be valid json


