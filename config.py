import os

class Config(object):
	SECRET_KEY = os.environ.get('BEERRUN') or 'something-else'