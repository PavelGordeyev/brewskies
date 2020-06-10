from flask import session
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField, SelectField, IntegerField, FloatField, Form
from wtforms.validators import InputRequired
from flaskr import db_connect

# class LoginForm(FlaskForm):
#     username = StringField('Username', validators=[DataRequired()])
#     password = PasswordField('Password', validators=[DataRequired()])
#     remember_me = BooleanField('Remember Me')
#     submit = SubmitField('Sign In')

class SearchForm(FlaskForm):
	searchText = StringField('Search Text')
	searchType = SelectField('Search Type',
		choices = [('beer','Beer'),('style','Style'),('brewery','Brewery')])
	submit = SubmitField("Search")

class AddBeerForm(FlaskForm):

	name = StringField('Beer Name')
	abv = FloatField('abv')
	price = FloatField('price')
	type_id = SelectField('Beer Type', coerce=str)
	submit = SubmitField("Add Beer")


# class AddBeerTypeForm(FlaskForm):
# 	searchText = StringField('Search Text')
# 	searchType = SelectField('Search Type',
# 		choices = [('beer','Beer'),('style','Style'),('brewery','Brewery')])
# 	submit = SubmitField("Search")


# 	type_id int(11) NOT NULL AUTO_INCREMENT,
# 	name varchar(255) NOT NULL,
# 	origin varchar(255),
# 	family varchar(255) NOT NULL,
# 	inactive smallint DEFAULT 0,

