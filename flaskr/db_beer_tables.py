from flask_table import Table, Col

class SearchResultsTable(Table):
    name = Col('Name')
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