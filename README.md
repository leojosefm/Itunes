# Itunes
## Parsing Itunes library XML using Python
This small project is created with the aim of learning XML parsing using Python and also help analyze the itunes library. The folks who are familiar with Itunes library XML would know iTunes library file as pairs of key values instead of more meaningful XML tags. So the main script "myitunes.py" can be used for fetching meaningful informations from itunes library
It also use itunes webservice to update an aritists top albums, primary genre etc.

## Script
1. myitunes.py :- This script reads library xml file from local PC (C:\\Users\\<User>\\Music\\iTunes) and loads the Oracle tables (Express edition) installed on local machine.
2. itunes.py :- This script fetches more information like primary genre, most popular albums etc about the all the artists  present in the itunes library from https://itunes.apple.com
3. itunes.sql :- This script contains SQL Statements for creating all the Oracle Objects required : Tables/Views/Triggers required for Data loading and Analysis

## PL/SQL
SP_ARTISTS_NORMALIZATION: This stored procedure is for elimination repeating groups in ARTISTS column
eg) Enrique & Sean Paull :- into two different record 1) Enrique 2) Sean Paull

## Analytics
### 1. Top 15 Artists
Oracle View : VIEW_TOP_15_ARTISTS will give top 15 artists from the library based on their songs playcount, number of songs in the library and also other details like their primary genre, most played song etc.

### 2. Top 25 Songs
Oracle View: VIEW_TOP_25_SONGS gives most played 25 songs.

### 3. Most Skipped Songs
Oracle View: VIEW_MOST_SKIPPED gives most skipped songs.

### 4. Genre Distribution
Oracle View: VIEW_PLAY_COUNT_DISTRIBUTION gives information on what Genre has more songs, played more etc

### 5. Song Era
Oracle View: VIEW_TIME_BUCKET gives information on how many songs are there in the library from each decade.

### 6. Most recently played
Oracle view : VIEW_MOST_RECENTLY_PLAYED gives most recently played songs. This is calculated by the difference in Playcount from previous loads
