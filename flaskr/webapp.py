from flask import Flask, render_template
from flask import request, redirect

webapp = Flask(__name__)

@webapp.route('/')
def index():
	return "Hello World!"

@webapp.route('/beers')
def beers():
	return "Hello World!"

@webapp.route('/breweries')
def breweries():
	return "Hello World!"

@webapp.route('/ratings')
def ratings():
	return "Hello World!"