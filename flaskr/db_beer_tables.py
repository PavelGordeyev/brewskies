from flask_table import Table, Col, LinkCol

class SearchResultsTable(Table):
	name = Col('Name')
	style = Col('Style')
	brewer = Col('Brewer')
	city = Col('City')
	country = Col('Country')

class SearchResultsTable2(Table):
	beer_id = Col('beer_id', show=False)
	name = LinkCol('Name', '.beers', url_kwargs=dict(beer_id='beer_id'), attr='name')
	style = Col('Style')
	brewer = Col('Brewer')
	city = Col('City')
	country = Col('Country')

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