from flask import Flask, render_template
from flask import request, redirect

app = Flask(__name__)

@app.route('/')
def index():
	return render_template('index.html', title='A Non-Comprehensive Catalog of Brewskies')

@app.route('/home')
def home():
	return render_template('home.html', title='Home')

@app.route('/beers')
def beers():
	beer_name = "Heinken"
	brewery = "Heinken"
	brewer_location = "Amsterdam"
	rating = 4.3
	return render_template('beers.html', title='Brewskies', beer_name=beer_name,brewery=brewery,brewer_location=brewer_location,rating=rating)

@app.route('/breweries')
def breweries():
	return render_template('breweries.html', title='Breweries')

@app.route('/ratings')
def ratings():
	return render_template('ratings.html', title='Brewsky Ratings')

@app.errorhandler(404)
def pageNotFound(error):
	return render_template('404.html', title='Brewsky Not Found')

@app.errorhandler(500)
def pageNotFound(error):
	return render_template('500.html', title='Major Brewsky Error')