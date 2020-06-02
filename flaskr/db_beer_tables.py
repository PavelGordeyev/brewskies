from flask_table import Table, Col, LinkCol, ButtonCol

class SearchResultsTable(Table):
	classes = ['table-hover']
	beer_id = Col('beer_id', show=False)
	name = LinkCol('Name', '.beers', url_kwargs=dict(beer_id='beer_id'), attr='name')
	abv = Col('ABV')
	style = Col('Style')
	brewer = Col('Brewer')
	city = Col('City')
	country = Col('Country')
	rating = Col('Rating')
	route = Col('route', show=False)
	order = ButtonCol('', 'addToOrder', url_kwargs=dict(beer_id='beer_id',route='route'), attr='order', button_attrs={'class': 'btn btn-success'})

class RandomTable(Table):
	classes = ['table-hover']
	beer_id = Col('beer_id', show=False)
	name = LinkCol('Name', '.beers', url_kwargs=dict(beer_id='beer_id'), attr='name')
	abv = Col('ABV')
	style = Col('Style')
	brewer = Col('Brewer')
	route = Col('route', show=False)
	order = ButtonCol('', 'addToOrder', url_kwargs=dict(beer_id='beer_id',route='route'), attr='order', button_attrs={'class': 'btn btn-success'})

class BrewersTable(Table):
	classes = ['table-hover']
	beer_id = Col('beer_id', show=False)
	name = LinkCol('Name', '.beers', url_kwargs=dict(beer_id='beer_id'), attr='name')
	abv = Col('ABV')
	style = Col('Style')
	route = Col('route', show=False)
	rmBeer = ButtonCol('', 'rmBeerDB', url_kwargs=dict(beer_id='beer_id',route='route'), attr='rmBeer', button_attrs={'class': 'btn btn-danger'})

class SearchResultsTable2(Table):
	beer_id = Col('beer_id', show=False)
	name = LinkCol('Name', '.beers', url_kwargs=dict(beer_id='beer_id'), attr='name')
	style = Col('Style')
	brewer = Col('Brewer')
	city = Col('City')
	country = Col('Country')
	route = Col('route', show=False)
	order = ButtonCol('', 'addToOrder', url_kwargs=dict(beer_id='beer_id',route='route'), attr='order', button_attrs={'class': 'btn btn-success'})


class CartTable(Table):
	beer_id = Col('beer_id', show=False)
	name = LinkCol('Name', '.beers', url_kwargs=dict(beer_id='beer_id'), attr='name')
	quantity = Col('Quantity')
	price = Col('Price')
	remove = ButtonCol('Remove From Order', 'cart', url_kwargs=dict(beer_id='beer_id'), button_attrs={'class': 'btn btn-danger'})

	# subtotal = Col('Subtotal')

class HistoryTable(Table):
	order_date = Col('Order Date')
	name = Col('Status')
	total = Col('Total')

class StarTable(Table):
	star = Col('Avg Stars')
	name = Col('Beer')
	brewer = Col('Brewer')
	beer_type = Col('Beer Type')

class BeersTable(Table):
	name = Col('Name')
	beerType = Col('Style')

class BeerBrewersTable(Table):
	beer = Col('Beer')
	brewery = Col('Brewery')
	location = Col('Location')