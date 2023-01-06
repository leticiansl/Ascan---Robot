*** Settings ***
Resource    ../main.robot

*** Variables ***
&{gen}
...    URL=https://www.way2automation.com/angularjs-protractor/banking/#/login
...    Browser=chrome
#...    Browser=headlesschrome
...    Timeout=10s