*** Settings ***
Library     SeleniumLibrary
Library     String

###   Data   ###
Resource    data/general.robot
Resource    data/add_customer.robot
Resource    data/customer.robot


###   Pages  ###
Resource    pages/account_page.robot
Resource    pages/customer_login_page.robot
Resource    pages/home_page.robot
Resource    pages/manager_login_page.robot


###  Shared  ###
Resource    shared/setup_teardown.robot
