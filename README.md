# About this project

This repo contains data used to create a logistic regression model to predict whether or not MLB (major league baseball) teams will make the playoffs or not. This repo was created by Matthew Wankiewicz. The purpose of this project is to determine whether or not the basis of Michael Lewis' book "Moneyball" was correct. Most of the data used is available on websites like baseball-reference.com and fangraphs.com and I will detail how I got the information.

Scripts contains two files and are used to create the dataset that is the basis for this report.
- Fangraphs Leaderboard.csv 
  - Fangraphs Leaderboad.csv is a file containing the FIP constants and other statistics over the years. It is located on the website https://www.fangraphs.com/guts.aspx?type=cn. Once you are on this website, there is a link in the top right side of the table that says "Export Data". Once you click this, it will download a .csv file containing all of the data.
  - payroll_data_scraper is used to scrape data from baseball-reference.com and merge that data with the Lahman dataset. The scraper is very simple to use, just run each function line by line until you are at the end. Once you are at the end, it will save a .csv file which is used for this experiment.
  
Outputs contains data that was taken from the scripts folder and make the final product look pretty.
- the paper folder contains all of the parts that are crucial for the paper:
  - all_years.csv is the cleaned data that is the output of the payroll_data_scraper
  - moneyball_analysis.pdf and moneyball_analysis.rmd is the output of the report in both .rmd and .pdf form
  - references.bib contains the references used for this analysis.