from flask import Flask, render_template
from flask import request, redirect
from flask_table import Table, Col
import MySQLdb as mariadb
from db_credentials import host, user, pw, db

app = Flask(__name__)

class IngredientsTable(Table):
    name = Col('Name')
    unit = Col('Unit')

# Define ingredients
class Ingredient(object):
	def __init__(self, name, unit):
		self.name = name
		self.unit = unit

# Define ratings
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

# Define beer/brewers
class BeerBrewersTable(Table):
	beer = Col('Beer')
	brewery = Col('Brewery')
	location = Col('Location')

class Brewer(object):
	def __init__(self, name, location):
		self.name = name
		self.location = location

class BeerBrewer(object):
	def __init__(self, beer, brewery, location):
		self.beer = beer
		self.brewery = brewery
		self.location = location

def execute_query(db_connection,query):

	if db_connection is None:
		print("No connection to the database found! Have you called connect_to_database() first?")
		return None

	if query is None or len(query.strip()) == 0:
		print("query is empty! Please pass a SQL query in query")
		return None
	
	cursor = db_connection.cursor()
	cursor.execute(query)
	db_connection.commit()
	return cursor


@app.route('/')
def index():
	return render_template('index.html', title='A Non-Comprehensive Catalog of Brewskies')

@app.route('/home')
def home():

	db_connection = mariadb.connect(host,user,pw,db)
	query = "SELECT * FROM client"
	result = execute_query(db_connection, query).fetchall()
	print(result)
	 
	return render_template('home.html', title='Home')

@app.route('/beers')
def beers():
	beer_name = "Heineken"
	brewer = "Heineken"
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

	type_name = "IPA"
	origin = "Deep back woods of Washington"
	family = "Pale Ale"


	beers = [Beer('Space Dust IPA','IPA'),
			Beer('Lush','IPA'),
			Beer('Hazelicous','IPA')]

	brewers = [Brewer('Elysian','Seattle'),
				Brewer('Fremont Brewing Company','Seattle'),
				Brewer("Rueben's Brews",'Seattle')]


	beer_brewer = [BeerBrewer(beers[0].name,brewers[0].name,brewers[0].location),
					BeerBrewer(beers[1].name,brewers[1].name,brewers[1].location),
					BeerBrewer(beers[2].name,brewers[2].name,brewers[2].location)]

	beer_brewer_table = BeerBrewersTable(beer_brewer)

	return render_template('beer_types.html', title='Beer Types', type_name=type_name,origin=origin,family=family,beer_brewer_table=beer_brewer_table)

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