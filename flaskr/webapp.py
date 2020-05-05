from flask import Flask, render_template
from flask import request, redirect

webapp = Flask(__name__)

@webapp.route('/')
def index():
	return render_template('index.html', title='Home')

@webapp.route('/beers')
def beers():
	return render_template('brewskies.html', title='Brewskies')

@webapp.route('/breweries')
def breweries():
	return render_template('breweries.html', title='Home')

@webapp.route('/ratings')
def ratings():
	return render_template('ratings.html', title='Brewsky Ratings')