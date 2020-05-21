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

class Beer(object):
	def __init__(self, name, beerType):
		self.name = name
		self.beerType = beerType

class Brewer(object):
	def __init__(self, name, location):
		self.name = name
		self.location = location

class BeerBrewer(object):
	def __init__(self, beer, brewery, location):
		self.beer = beer
		self.brewery = brewery
		self.location = location