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



@app.route('/direktor/<username>')
def direktor_profil(username):
    direktor = function.direktor_username(username)
    if direktor:
        return render_template('direktor.html')


@app.route('/radnik/<username>')
def radnik_profil(username):
    radnik = function.radnik_username(username)
    if radnik:
        radnici = function.prikaz_podataka_radnik(username)
        isplate = function.istorija_isplata(username)
        return render_template('radnik.html', radnici=radnici, isplate=isplate)


if __name__ == '__main__':
    app.run(debug=True)