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

class StarRow(object):
	def __init__(self, star, name, brewer, beer_type):
		self.star = star
		self.name = name
		self.brewer = brewer
		self.beer_type = beer_type


class StarTable(Table):
	star = Col('Avg Stars')
	name = Col('Beer')
	brewer = Col('Brewer')
	beer_type = Col('Beer Type')

# Define beers
class BeersTable(Table):
	name = Col('Name')
	beerType = Col('Style')

class Beer(object):
	def __init__(self, name, beerType):
		self.name = name
		self.beerType = beerType


@app.route('/')
def index():
	return render_template('index.html', title='A Non-Comprehensive Catalog of Brewskies')

@app.route('/home')
def home():
	return render_template('home.html', title='Home')

@app.route('/beers')
def beers():
	beer_name = "Heinken"
	brewer = "Heinken"
	brewer_location = "Amsterdam"
	rating = 4.3

	ingredients = [Ingredient('water', 'gallons'),
					Ingredient('hops', 'oz'),
         			Ingredient('barley', 'LBS'),
         			Ingredient('yeast',"1 packet")]
	
	ing_table = IngredientsTable(ingredients)

	return render_template('beers.html', title='Brewskies', beer_name=beer_name,brewer=brewer,brewer_location=brewer_location,rating=rating,ing_table=ing_table)

@app.route('/beerTypes')
def beerTypes():
	return render_template('beer_types.html', title='Beer Types')

@app.route('/brewers')
def brewers():
	brewer = "Elysian"
	brewer_location = "Seattle, WA"

	beers = [Beer('Space Dust IPA','IPA'),
			Beer('Contact Haze','Hazy IPA'),
			Beer('SuperFuzz','Blood Orange Pale')]

	beers_table = BeersTable(beers)

	return render_template('brewers.html', title='Brewers',brewer=brewer,brewer_location=brewer_location,beers_table=beers_table)

@app.route('/ratings')
def ratings():

	starrows = [StarRow('5', 'Milwaukee\'s best', 'Miller Brewing Company', 'Pale Lager'),
				StarRow('5', 'Bud Light Lime', 'AB Inbev', 'Gross Fake Fruit Beer')]
	
	star_table = StarTable(starrows)

	return render_template('star_ratings.html', title='Ratings', star_table=star_table)

@app.route('/add')
def add():
	return render_template('add.html', title='Add elements')

@app.errorhandler(404)
def pageNotFound(error):
	return render_template('404.html', title='Brewsky Not Found')

@app.errorhandler(500)
def pageNotFound(error):
	return render_template('500.html', title='Major Brewsky Error')