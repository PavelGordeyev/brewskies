from flaskr import app
from flask import render_template, request, redirect, jsonify, url_for, flash, session
from flaskr import db_connect
from flaskr.db_beer_tables import SearchResultsTable, SearchResultsTable2, BeersTable, BeerBrewersTable, StarTable, CartTable, HistoryTable
from flaskr.db_beer_objects import Ingredient, StarRow, Beer, Brewer, BeerBrewer
from flaskr.forms import SearchForm

@app.route('/')
def index():
	session['customer_id'] = 1
	return render_template('index.html', title='A Non-Comprehensive Catalog of Brewskies')

@app.route('/home', methods=['GET','POST'])
def home():

	form = SearchForm(request.form)

	if request.method == 'POST':

		# Set form values to session cookie
		session['searchType'] = form.searchType.data
		session['searchText'] = form.searchText.data

		return redirect(url_for('searchResults'))
	 
	return render_template('home.html', title='Home', form=form)

@app.route('/addToOrder', methods=['POST'])
def addToOrder():

	# Get the beer id from the request
	beer_id = int(request.args.get('beer_id'));

	# Get the customer who is logged in
	customer_id = session.get('customer_id', None);

	# Check if an open order exists for the customer
	query = """SELECT order_id FROM orders WHERE customer_id=%s AND status_id=1;""" %(customer_id)

	# Submit query
	results = db_connect.execute_query(query)

	# Check if there is an existing open order
	if len(results) == 0:

		# Insert new order into orders table
		newOrderQuery = """INSERT INTO orders (customer_id, status_id) VALUES (%s, 1);""" %(customer_id)
		results = db_connect.execute_query(newOrderQuery)

		# Get the order id that was inserted for the customer
		results = db_connect.execute_query(query)

		# Initialize quantity results 
		quantityResults = 0

	else: # Order exists

		# Get the current quantity for the specific beer chosen
		quantityQuery = """SELECT quantity FROM order_items WHERE order_id=%s AND beer_id=%s;""" %(results[0][0], beer_id)
		quantityResults = db_connect.execute_query(quantityQuery)

		if(len(quantityResults) != 0):
			quantityResults = quantityResults[0][0] + 1
		else:
			quantityResults = 0

	# Add beer to order_items
	newOrderItemQuery = """INSERT INTO order_items (order_id, beer_id, quantity) VALUES (%s, %s, 1) ON DUPLICATE KEY UPDATE quantity=%s""" %(results[0][0], beer_id, quantityResults)

	results = db_connect.execute_query(newOrderItemQuery)

	flash('You added a beer! Congrats!')

	return redirect(url_for('searchResults'))

@app.route('/searchResults', methods=['GET', 'POST'])
def searchResults():
	
	# Determine beer, style or brewery to query
	if session.get('searchType', None) == "beer":
		searchType = "beers.name"
	elif session.get('searchType', None) == "style":
		searchType = """beer_types.name"""
	else:
		searchType = """brewers.name"""

	searchText = """'%""" + session.get('searchText', None) + """%'"""

	query = """SELECT beers.beer_id,beers.name,beers.abv,beer_types.name,brewers.name,brewers.city,brewers.country,AVG(beer_ratings.rating) as Rating FROM beers INNER JOIN beer_types on beers.type_id = beer_types.type_id INNER JOIN brewers on beers.brewer_id = brewers.brewer_id LEFT JOIN beer_ratings on beers.beer_id = beer_ratings.beer_id WHERE UPPER( %s ) LIKE ( %s ) GROUP BY beers.beer_id ORDER BY beer_ratings.rating DESC;""" %(searchType, searchText.upper())
	
	# Submit query
	results = db_connect.execute_query(query)

	# Create object for data returned
	payload = []
	content = {}
	
	for result in results:
		abv = result[2] * 100
		abvStr = str(abv) + '%'

		if(result[7] != None):
			rating = round(result[7],1)
		else:
			rating = "N/A"

		content = {'beer_id': result[0], 'name': result[1], 'abv': abvStr, 'style': result[3], 'brewer': result[4], 'city': result[5], 'country': result[6], 'rating': rating, 'order': '+'}
		payload.append(content)

	results_table = SearchResultsTable(payload)

	session['searched'] = 1

	return render_template('results.html', title='BrewskyDB - Search Results',results_table=results_table)

@app.route('/beers', methods=['GET', 'POST'])
def beers():
	# Get the beer id from the request
	beer_id = int(request.args.get('beer_id'))
	# Get customer id from the session
	customer_id = session.get('customer_id')

	if request.method == 'POST':
		#if it's a post, get the rating
		rating = request.form.get('rating')
		insert_query = """INSERT INTO beer_ratings (beer_id, customer_id, rating) VALUES ({0}, {1}, {2}) ON DUPLICATE KEY UPDATE rating={2}""".format(beer_id, customer_id, rating)
		db_connect.execute_query(insert_query)

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
	
	# query for beer average
	avg_query = """SELECT AVG(beer_ratings.rating) as 'Rating' FROM beers JOIN beer_ratings on beers.beer_id = beer_ratings.beer_id WHERE beers.beer_id = %d;""" %(beer_id)
	
	# store the table as an object
	avg_query_result = db_connect.execute_query(avg_query)
	
	# get the top left object from the table
	rating = avg_query_result[0][0]
	# round to one decimal place
	if(rating):
		rating = round(rating, 1)
	else:
		rating = 'N/A'

	return render_template('beers.html', title='Brewskies',rating=rating,results_table=results_table, beer_id=beer_id)

@app.route('/cart')
def cart():
	customer_id = session.get('customer_id')

	#get the customers open order

	cart_query = """SELECT beers.beer_id, order_items.order_id, beers.name, order_items.quantity, beers.price FROM order_items JOIN orders on order_items.order_id = orders.order_id JOIN customers on orders.customer_id = customers.customer_id JOIN beers on order_items.beer_id = beers.beer_id JOIN order_status on orders.status_id = order_status.status_id WHERE customers.customer_id = %d AND order_status.name IN ('OPEN');""" %(customer_id)
	cart_result = db_connect.execute_query(cart_query)

	#create object ofr data returned
	payload = []
	content = {}
	total = 0

	for result in cart_result:
		# print("beer_id {0}, name {1}, quantity {2}, price {3}".format(result[0], result[2], result[3], result[4]))
		content = {'beer_id': result[0], 'name': result[2], 'quantity': result[3], 'price': result[4]}
		payload.append(content)
		total += result[3] * result[4]

	results_table = CartTable(payload)

	return render_template('cart.html', title='Cart', results_table=results_table, total=total)

@app.route('/order_history')
def order_history():
	customer_id = session.get('customer_id')

	#get the customers order history
	order_query = """SELECT orders.order_date as 'Order Date', order_status.name as 'Status', SUM(order_items.quantity * beers.price) AS 'Order Total' FROM order_items JOIN orders on order_items.order_id = orders.order_id JOIN customers on orders.customer_id = customers.customer_id JOIN beers on order_items.beer_id = beers.beer_id JOIN order_status on orders.status_id = order_status.status_id WHERE customers.customer_id = %d AND order_status.name != 'OPEN' GROUP BY orders.order_id ORDER BY orders.order_date;""" %(customer_id)
	order_result = db_connect.execute_query(order_query)

	#create object ofr data returned
	payload = []
	content = {}

	for result in order_result:
		content = {'order_date': result[0], 'name':result[1], 'total': result[2]}
		payload.append(content)
	
	results_table = HistoryTable(payload)

	return render_template('order_history.html', title='Order History', results_table=results_table)
	
@app.route('/star_ratings')
def star_ratings():
	customer_id = session.get('customer_id')

	#get all the beers ordered by rating
	star_query = """SELECT beers.beer_id,beers.name,beers.abv,beer_types.name,brewers.name,brewers.city,brewers.country,AVG(beer_ratings.rating) as Rating FROM beers INNER JOIN beer_types on beers.type_id = beer_types.type_id INNER JOIN brewers on beers.brewer_id = brewers.brewer_id LEFT JOIN beer_ratings on beers.beer_id = beer_ratings.beer_id GROUP BY beers.beer_id ORDER BY CASE WHEN AVG(beer_ratings.rating) IS NULL THEN 0 END, AVG(beer_ratings.rating) DESC;"""
	star_results = db_connect.execute_query(star_query)
	# Create object for data returned
	payload = []
	content = {}
	
	for result in star_results:
		abv = result[2] * 100
		abvStr = str(abv) + '%'

		if(result[7] != None):
			rating = round(result[7],1)
		else:
			rating = "N/A"

		content = {'beer_id': result[0], 'name': result[1], 'abv': abvStr, 'style': result[3], 'brewer': result[4], 'city': result[5], 'country': result[6], 'rating': rating, 'order': '+'}
		payload.append(content)

	results_table = SearchResultsTable(payload)
	
	return render_template('star_ratings.html', title='Star Ratings',results_table=results_table)

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