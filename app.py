from flask import Flask, render_template, request, redirect, url_for, flash
import function


app = Flask(__name__)
app.secret_key = 'neki_tajni_kljuc'

#Preskakanje pocetne putanje(/) i setovanje login putanje kao pocetnu(login.html)
@app.route('/')
def index():
    return redirect(url_for('login'))

#Kreiranje logina i forme za login
@app.route('/login', methods=['GET','POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        korisnik = function.provera_korisnika(username, password)
        if korisnik is True:
            direktor = function.direktor_username(username) #cuvanje korisnickog imena
            if direktor:
                return redirect(url_for('direktor_profil', username=username)) #prosledjivanje korisnickog imena
        elif korisnik is False:
            radnik = function.radnik_username(username)  
            if radnik:
                return redirect(url_for('radnik_profil', username=username))  
            else:
                return redirect(url_for('404'))
        else:
            flash('Pogrešno korisničko ime ili lozinka')
    return render_template('login.html')


#Ruta za radnika (posle logina)
@app.route('/radnik/<username>')
def radnik_profil(username):
    radnik = function.radnik_username(username)
    if radnik:
        radnici = function.prikaz_podataka_radnik(username)
        isplate = function.istorija_isplata(username)
        return render_template('radnik.html', radnici=radnici, isplate=isplate)
    

#Ruta za direktora (posle logina)
@app.route('/direktor/<username>')
def direktor_profil(username):
    direktor = function.direktor_username(username)
    if direktor:
        radnici = function.prikaz_podataka_radnici()
        return render_template('direktor.html', radnici=radnici)


#Prikaz svih funkcija i podataka o radniku (Direktor)
@app.route('/detalji/<radnik_id>')
def direktor_radnik_detalji(radnik_id):
    radnici = function.prikaz_podataka_radnik_id(radnik_id)
    if radnici:
        return render_template('direktor_radnik_prikaz.html', radnici=radnici)
    else:
        return 'Radnik not found', 404



if __name__ == '__main__':
    app.run(debug=True)