from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
import psycopg2

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:test@localhost/HW2'
db=SQLAlchemy(app)

      
@app.route('/')
def login():
   return render_template('login.html')

@app.route('/signup')
def signup():
   return render_template('signup.html')   

if __name__ == '__main__':
   app.run(debug = True)