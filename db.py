import mysql.connector

#Kreiranje kursora za admina:
dbDirektor = mysql.connector.connect(
    host = 'localhost',
    user = 'root',
    password = '',
    database = 'obracun_plata'
)
cursorDirektor = dbDirektor.cursor()


#Kreiranje kursora za usera
dbRadnik = mysql.connector.connect(
    host = 'localhost',
    user = 'root',
    password = '',
    database = 'obracun_plata'
)
cursorRadnik = dbRadnik.cursor()