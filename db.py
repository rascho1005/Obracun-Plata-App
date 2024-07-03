import mysql.connector

#Kreiranje kursora za admina:
dbDirektor = mysql.connector.connect(
    host = 'localhost',
    user = 'direktor',
    password = 'direktor123',
    database = 'obracun plata'
)
cursorDirektor = dbDirektor.cursor()


#Kreiranje kursora za usera
dbRadnik = mysql.connector.connect(
    host = 'localhost',
    user = 'radnik',
    password = 'radnik123',
    database = 'obracun plata'
)
cursorRadnik = dbRadnik.cursor()