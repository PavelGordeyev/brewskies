from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField, SelectField
from wtforms.validators import DataRequired

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

