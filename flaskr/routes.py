from flaskr import app
from flask import render_template, request, redirect, jsonify, url_for, flash, session
from flaskr import db_connect
from flaskr.db_beer_tables import SearchResultsTable, SearchResultsTable2, BeersTable, BeerBrewersTable, StarTable
from flaskr.db_beer_objects import Ingredient, StarRow, Beer, Brewer, BeerBrewer
from flaskr.forms import SearchForm

# class ItemTable(Table):
# 	name = Col('Name')
# 	description = Col('description')

@app.route('/')
def index():
	return render_template('index.html', title='A Non-Comprehensive Catalog of Brewskies')

@app.route('/home', methods=['GET','POST'])
def home():

	form = SearchForm(request.form)

	if request.method == 'POST':

		# Set form values to session cookie
		session['searchType'] = form.searchType.data
		session['searchText'] = form.searchText.data

		return redirect(url_for('beers'))
	 
	return render_template('home.html', title='Home', form=form)

@app.route('/beers', methods=['GET', 'POST'])
def beers():
	##### OLD QUERY for search
	# if session.get('searchType', None) == "beer":
	# 	searchType = "beers.name"
	# elif session.get('searchType', None) == "style":
	# 	searchType = """beer_types.name"""
	# else:
	# 	searchType = """brewers.name"""
	# searchText = """'%""" + session.get('searchText', None) + """%'"""
	#OLD QUERY query = """SELECT beers.beer_id,beers.name,beer_types.name,brewers.name,brewers.city,brewers.country FROM beers INNER JOIN brewers ON beers.brewer_id = brewers.brewer_id INNER JOIN beer_types ON beers.type_id = beer_types.type_id WHERE %s LIKE ( %s );""" %(searchType, searchText)
	# Any values like the beer, style or brewery input
	#searchVal = """%""" + session.get('searchText', None) + """%"""

	#get the beer id from the request
	beer_id = int(request.args.get('beer_id'))

	# Use the beer_id from the GET command.
	query = """SELECT beers.beer_id,beers.name,beer_types.name,brewers.name,brewers.city,brewers.country FROM beers INNER JOIN brewers ON beers.brewer_id = brewers.brewer_id INNER JOIN beer_types ON beers.type_id = beer_types.type_id WHERE beers.beer_id=%d;""" %(beer_id)

	# Submit query
	results = db_connect.execute_query(query)

	# Create object for data returned
	payload = []
	content = {}
	
	for result in results:
		content = {'beer_id': result[0], 'name': result[1], 'style': result[2], 'brewer': result[3], 'city': result[4], 'country': result[5]}
		payload.append(content)
	results_table = SearchResultsTable2(payload)
	
	#query for beer average
	avg_query = """SELECT AVG(beer_ratings.rating) as 'Rating' FROM beers JOIN beer_ratings on beers.beer_id = beer_ratings.beer_id WHERE beers.beer_id = %d;""" %(beer_id)
	# store the table as an object
	avg_query_result = db_connect.execute_query(avg_query)
	# get the top left object from the table
	rating = avg_query_result[0][0]
	#round to one decimal place
	rating = round(rating, 1)


	return render_template('beers.html', title='Brewskies',rating=rating,results_table=results_table)

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