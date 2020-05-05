from flask import Flask, render_template
from flask import request, redirect

app = Flask(__name__)

@app.route('/')
def index():
	return render_template('index.html', title='Home')

@app.route('/beers')
def beers():
	return render_template('brewskies.html', title='Brewskies')

@app.route('/breweries')
def breweries():
	return render_template('breweries.html', title='Breweries')

@app.route('/ratings')
def ratings():
	return render_template('ratings.html', title='Brewsky Ratings')