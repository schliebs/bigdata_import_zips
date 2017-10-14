# install.packages("install.load")
install.load::install_load("dbplyr","dplyr","RSQLite","DBI")

# connect to the sqlite file

mydb <- dbConnect(RSQLite::SQLite(), "simon_realdata.sqlite")

class(mydb)
dbListTables(mydb) #tables in db  
dbListFields(mydb, "Data") #vars


# QUERY VIA SQL-SYNTAX
# Beispiel: Select Time and Bid_Price, order by price and get only first 10(0): unten mit collect wird es noch schneller
dbGetQuery(conn = mydb,statement = "SELECT Time,Bid_Price FROM Data ORDER BY Bid_Price DESC LIMIT 10") # 10
dbGetQuery(conn = mydb,statement = "SELECT Time,Bid_Price FROM Data ORDER BY Bid_Price DESC LIMIT 100") %>% collect()#100

# DO the same thing but save output in R 
in_R <- 
  dbGetQuery(conn = mydb,statement = "SELECT Time,Bid_Price FROM Data ORDER BY Bid_Price DESC LIMIT 50")


# Es geht auch anders: QUERY VIA DPLYR-LOGIC
tbl <- tbl(mydb, "Data")
tbl %>%
  select(Time, Bid_Price) # krass wie schnell, Databases auf jeden Fall way to go

tbl %>%
  head()

# Translate R in SQL: 
show_query(head(tbl, n = 10))


# To finally load data in R, we use "collect" => that speed

in_R2 <- 
  tbl %>%
  select(Time, Bid_Price) %>% 
  head (100000) %>% 
  collect()

# Soweit so gut, damit solltest du für den Anfang was machen können. Melde Dich gerne wenn es noch was gibt. 

# Close the connection to free resources. 
dbDisconnect(mydb)

# Achtung: unlink löscht die Database wieder!
#unlink("simon_realdata.sqlite")
