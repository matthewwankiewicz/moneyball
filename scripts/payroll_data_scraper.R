#### PREAMBLE ####
# Creator: Matthew Wankiewicz
# contact: matthew.wankiewicz@mail.utoronto.ca
# This script scrapes tables from Baseball Reference's misc
# data page

library(tidyverse)
library(rvest)


## use the for loop below to get the links for each year's data
end_year <- 2019
years <- rep(NA, end_year - 1920)
j <- 1
for(i in 1920:end_year){
   years[j] <- assign(paste0("url", i), paste0("https://www.baseball-reference.com/leagues/MLB/", i, "-misc.shtml"))
   j = j + 1
}

## get tables for each year, I broke it up into intervals of 20
## to not strain the servers

for(i in 1920:2019){
  for(j in 1:100){
    table[[j]] %>% mutate(yearID = i)
  }
}

for(i in 1:20){
  assign(paste0("table", i), read_html(years[i]) %>% html_table())
}

all_years <- rbind(table1[[1]], table2[[1]], table3[[1]], table4[[1]], table5[[1]], table6[[1]],
                   table7[[1]], table8[[1]], table19[[1]], table10[[1]], table11[[1]], table12[[1]],
                   table13[[1]], table14[[1]], table15[[1]], table16[[1]], table17[[1]], 
                   table18[[1]], table19[[1]], table20[[1]], table21[[1]], table22[[1]], table23[[1]], table24[[1]],
                   table25[[1]], table26[[1]], table27[[1]])
all_years <- all_years %>% 
  mutate(Time = 0)

for(i in 21:40){
  assign(paste0("table", i), read_html(years[i]) %>% html_table())
}

all_years <- rbind(all_years, table28[[1]], table29[[1]],
                   table30[[1]], table31[[1]], table32[[1]], table33[[1]], table34[[1]],
                   table35[[1]], table36[[1]], table37[[1]], table38[[1]], table39[[1]], table40[[1]])

for(i in 41:60){
  assign(paste0("table", i), read_html(years[i]) %>% html_table())
}

all_years <- rbind(all_years, table41[[1]], table42[[1]], table43[[1]], table44[[1]], table45[[1]], 
                   table46[[1]], table47[[1]], table48[[1]], table49[[1]], table50[[1]], table51[[1]], 
                   table52[[1]], table53[[1]], table54[[1]], table55[[1]], table56[[1]], table57[[1]], 
                   table58[[1]], table59[[1]], table60[[1]])

for(i in 61:80){
  assign(paste0("table", i), read_html(years[i]) %>% html_table())
}

all_years <- rbind(all_years, table61[[1]], table62[[1]], table63[[1]], table64[[1]], table65[[1]],
                   table66[[1]], table67[[1]], table68[[1]], table69[[1]], table70[[1]], table71[[1]], table72[[1]],
                   table73[[1]], table74[[1]], table75[[1]], table76[[1]], table77[[1]], table78[[1]], 
                   table79[[1]], table80[[1]])

for(i in 81:100){
  assign(paste0("table", i), read_html(years[i]) %>% html_table())
}

all_years <- rbind(all_years, table81[[1]], table82[[1]], table83[[1]], table84[[1]], table85[[1]],
                   table86[[1]], table87[[1]], table88[[1]], table89[[1]], table90[[1]], table91[[1]],
                   table92[[1]], table93[[1]], table94[[1]])

# remove columns dealing with coach challenges, didnt exist until recently
challenge_era <- rbind(table95[[1]], table96[[1]], table97[[1]],
                       table98[[1]], table99[[1]], table100[[1]])



write.csv(all_years, "all_years.csv")


for(i in 1920:2019){
  for(j in 1:100){
    tab[[j]] %>% mutate(yearID = i)
  }
}


test <- list(table1[[1]], table2[[1]], table3[[1]], table4[[1]], table5[[1]], table6[[1]],
             table7[[1]], table8[[1]], table19[[1]], table10[[1]], table11[[1]], table12[[1]],
             table13[[1]], table14[[1]], table15[[1]], table16[[1]], table17[[1]], 
             table18[[1]], table19[[1]], table20[[1]], table21[[1]], table22[[1]], table23[[1]], table24[[1]],
             table25[[1]], table26[[1]], table27[[1]], table28[[1]], table29[[1]],
             table30[[1]], table31[[1]], table32[[1]], table33[[1]], table34[[1]],
             table35[[1]], table36[[1]], table37[[1]], table38[[1]], table39[[1]], table40[[1]],
             table41[[1]], table42[[1]], table43[[1]], table44[[1]], table45[[1]], 
             table46[[1]], table47[[1]], table48[[1]], table49[[1]], table50[[1]], table51[[1]], 
             table52[[1]], table53[[1]], table54[[1]], table55[[1]], table56[[1]], table57[[1]], 
             table58[[1]], table59[[1]], table60[[1]], table61[[1]], table62[[1]], table63[[1]], table64[[1]], table65[[1]],
             table66[[1]], table67[[1]], table68[[1]], table69[[1]], table70[[1]], table71[[1]], table72[[1]],
             table73[[1]], table74[[1]], table75[[1]], table76[[1]], table77[[1]], table78[[1]], 
             table79[[1]], table80[[1]], table81[[1]], table82[[1]], table83[[1]], table84[[1]], table85[[1]],
             table86[[1]], table87[[1]], table88[[1]], table89[[1]], table90[[1]], table91[[1]],
             table92[[1]], table93[[1]], table94[[1]], table95[[1]], table96[[1]], table97[[1]],
             table98[[1]], table99[[1]], table100[[1]])

# add years for each table
year = 1920
for(i in 1:100){
  test[[i]] <- test[[i]] %>% mutate(yearID = year)
  year = year + 1
}

# remove extra columns from challenge era
for(i in 95:100){
  test[[i]] <- test[[i]] %>% select(-c(Chall, Succ, `Succ%`))
}

# add time column that will be 0, it will be removed later anyways
for(i in 1:27){
  test[[i]] <- test[[i]] %>% mutate(Time = 0)
}

all_years <- do.call("rbind", test)


# convert money with $ to a numeric
all_years$`Est. Payroll` <- as.numeric(gsub('\\$|,', '', all_years$`Est. Payroll`))

# replace NAs in payroll with the average payroll for that year
all_years <- all_years %>% 
  group_by(yearID) %>% 
  mutate(payroll = ifelse(is.na(`Est. Payroll`), 
                          mean(`Est. Payroll`, na.rm=TRUE), `Est. Payroll`))


# rename Tm column to match the Lahman data
all_years_payroll <- all_years %>% 
  rename("teamIDBR" = Tm)

# filter from 1920 and on, contract data is only avaiable there
all_years_stats <- Lahman::Teams %>% 
  filter(yearID >= 1920)

# merge the data
all_years <- merge(all_years_payroll, all_years_stats, by = c("teamIDBR", "yearID"))


# filter out these years, unfortunately they have many missing values present
# and can't hack a way to get an entry

all_years <- all_years %>% 
  filter(yearID != 1975,
         yearID != 1976, 
         yearID != 1978,
         yearID != 1979,
         yearID != 1984)


# replace any NAs present with 0s
# these occur because some years didn't record certain stats or
# some rules changed over the years, meaning the league never tracked for those rules
all_years[is.na(all_years)] <- 0

# make a binary variable determining if a team made the playoffs or not
# this is done by taking if they made the World Series finals and then
# moving backwards and seeing if the won their Division or got in through
# the wild card.
all_years <- all_years %>% 
  mutate(playoffs = ifelse(LgWin == "Y", 1,
                           ifelse(DivWin == "Y", 1, 
                                  ifelse(WCWin == "Y", 1, 0))))

# read in Fangraphs csv for FIP constant

fangraphs <- read_csv("scripts/FanGraphs Leaderboard.csv")
fangraphs <- fangraphs %>% 
  filter(Season >= 1920)
fip_constant <- mean(fangraphs$cFIP)

# create some advanced stats, the ones used for the analysis
# will be explained in the paper
all_years <- all_years %>% 
  mutate(X1B = H - X2B - X3B - HR,
         OBP = round(((H+BB+HBP)/(AB+BB+HBP+SF)), digits = 3),
         SLG = round(((X1B+2*X2B+3*X3B+4*HR)/AB), digits = 3),
         wOBA = round((OBP*2 + SLG)/3, digits = 3),
         FIP = round((13*HRA + 3*BBA - 2*SOA)/((IPouts/3)) + fip_constant, digits = 3),
         BA = round(H/AB, digits = 3)
)


write.csv(all_years, "outputs/paper/all_years.csv")

