from flask import Flask, render_template
from flask import request, redirect

webapp = Flask(__name__)

@webapp.route('/hello')
def index():
	return "Hello World!"