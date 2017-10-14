# install.packages("install.load")
install.load::install_load("dbplyr","dplyr","RSQLite","DBI")

# connect to the sqlite file

mydb <- dbConnect(RSQLite::SQLite(), "simon.sqlite")

class(mydb)
dbListTables(mydb) #tables in db  
dbListFields(mydb, "Data") #vars


# QUERY VIA SQL-SYNTAX
# Beispiel: Select Seats und Country 
dbGetQuery(conn = mydb,statement = "SELECT Seats,country FROM Data ORDER BY Seats DESC")

# QUERY VIA DPLYR-LOGIC
tbl <- tbl(mydb, "Data")
tbl %>%
  select(Seats, country)

# Translate R in SQL: 
show_query(head(tbl, n = 10))


# To finally load data in R, we use "collect"

in_r <- 
  tbl %>%
  select(Seats, country) %>% 
  collect()

# Drop Columns (WHAT YOU WANT!)

mydb2 <- dbSendQuery(mydb, "SELECT * FROM Data WHERE total_population > 500000000")
dbFetch(mydb)

con <- dbConnect(RSQLite::SQLite(), "simon2.sqlite")
sqliteCopyDatabase(res, con)

RSQLite::


# habe noch nicht ganz rausgefunden, was dashier macht:
dbDisconnect(mydb)
unlink("simon.sqlite")