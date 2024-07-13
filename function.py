import db

#Funkcija sa kojom proveravamo da li je korisnik Direktor ili Radnik.
def provera_korisnika(username, password):
    db.cursorDirektor.execute('SELECT korisnicko_ime, lozinka FROM direktor WHERE korisnicko_ime = %s AND lozinka = %s', (username, password))
    direktor = db.cursorDirektor.fetchone()
    if direktor:
        return True
    else:
        db.cursorRadnik.execute('SELECT korisnicko_ime, lozinka FROM radnik WHERE korisnicko_ime = %s AND lozinka = %s', (username, password))
        radnik = db.cursorRadnik.fetchone()
        if radnik:
            return False 
        else:
            return None
        

#Funkcija koja uzima usernname od radnika
def radnik_username(username):
    db.cursorRadnik.execute('SELECT korisnicko_ime FROM radnik WHERE korisnicko_ime = %s',(username,))
    return db.cursorRadnik.fetchone()
#Funkcija koja uzima usernname od direktora
def direktor_username(username):
    db.cursorRadnik.execute('SELECT korisnicko_ime FROM direktor WHERE korisnicko_ime = %s',(username,))
    return db.cursorRadnik.fetchone()


#Funkcija za prikaz svih podataka o radniku ali o raniku sa datim username-om
def prikaz_podataka_radnik(username):
    upit = """
SELECT 
    r.radnik_id,
    r.ime,
    r.prezime,
    r.godine,
    r.naziv_slike,
    r.datum_zaposljenja,
    r.opis,
    r.ukupan_br_radnih_sati,
    r.ukupno_zaradjeno,
    r.trenutan_br_radnih_sati,
    r.trenutno_zaradjeno,
    r.korisnicko_ime,
    r.lozinka,
    p.ime_pozicije,
    p.satnica,
    d.direktor_ime_prezime AS direktor
FROM 
    radnik r
INNER JOIN pozicija p ON r.ime_pozicije_id = p.pozicija_id
INNER JOIN direktor d ON r.direktor_id = d.direktor_id
WHERE 
    r.korisnicko_ime = %s
"""
    db.cursorRadnik.execute(upit, (username,))
    return db.cursorRadnik.fetchall()


#Funkcija za prikaz istorije isplata radniku
def istorija_isplata(username):
    upit = """
SELECT 
    r.ime AS 'Ime radnika',
    i.datum_isplate,
    i.suma,
    d.direktor_ime_prezime AS direktor
FROM 
    isplata i
INNER JOIN radnik r ON r.radnik_id = i.radnik_id
INNER JOIN direktor d ON r.direktor_id = d.direktor_id
WHERE 
    r.korisnicko_ime = %s
"""
    db.cursorRadnik.execute(upit, (username,))
    return db.cursorRadnik.fetchall()