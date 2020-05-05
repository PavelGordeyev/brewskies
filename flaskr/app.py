from flask import Flask, render_template
from flask import request, redirect
from flask_table import Table, Col

app = Flask(__name__)

class IngredientsTable(Table):
    name = Col('Name')
    unit = Col('Unit')

# Define ingredients
class Ingredient(object):
	def __init__(self, name, unit):
		self.name = name
		self.unit = unit

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

	ingredients = [Ingredient('water', 'gallons'),
					Ingredient('hops', 'oz'),
         			Ingredient('barley', 'LBS'),
         			Ingredient('yeast',"1 packet")]
	
	ing_table = IngredientsTable(ingredients)

	return render_template('beers.html', title='Brewskies', beer_name=beer_name,brewery=brewery,brewer_location=brewer_location,rating=rating,ing_table=ing_table)

@app.route('/beerTypes')
def beerTypes():
	return render_template('beer_types.html', title='Beer Types')

@app.route('/brewers')
def brewers():
	return render_template('brewers.html', title='Brewers')

@app.route('/ratings')
def ratings():
	return render_template('star_ratings.html', title='Ratings')

@app.route('/add')
def add():
	return render_template('add.html', title='Add elements')

@app.errorhandler(404)
def pageNotFound(error):
	return render_template('404.html', title='Brewsky Not Found')

@app.errorhandler(500)
def pageNotFound(error):
	return render_template('500.html', title='Major Brewsky Error')