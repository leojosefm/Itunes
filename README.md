# Itunes
## Parsing Itunes library XML using Python
This small project is created with the aim of learning XML parsing using Python and also help analyze the itunes library. The folks who are familiar with Itunes library XML would know iTunes library file as pairs of key values instead of more meaningful XML tags. So the main script "myitunes.py" can be used for fetching meaningful informations from itunes library
It also use itunes webservice to update an aritists top albums, primary genre etc.

## Script
1. myitunes.py :- This script reads library xml file from local PC (C:\\Users\\<User>\\Music\\iTunes) and loads the Oracle tables (Express edition) installed on local machine.
2. itunes.py :- This script fetches more information like primary genre, most popular albums etc about the all the artists  present in the itunes library 
3. itunes.sql :- This script contains SQL Statements for creating all the Oracle Objects required : Tables/Views/Triggers required for Data loading and Analysis

## Analytics
