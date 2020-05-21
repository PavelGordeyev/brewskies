from flask_table import Table, Col

class IngredientsTable(Table):
    name = Col('Name')
    unit = Col('Unit')

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