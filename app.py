from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
import psycopg2

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:@localhost/odev2'
db=SQLAlchemy(app)

user_requests = []
for i in range(0, 20):
    user_requests.append({
        'name': 'user' + str(i),
        'id': i
    })

conf_requests = []
for i in range(0, 20):
    conf_requests.append({
        'name': 'conf' + str(i),
        'id': i
    })

@app.route('/')
def login():
    return render_template('login.html')

@app.route('/signup')
def signup():
    return render_template('signup.html')   

@app.route('/main')
def main():
    return render_template('main.html', users = user_requests, confs = conf_requests)

@app.route('/conference')
def conference():
    return render_template('conference.html')  

if __name__ == '__main__':
   app.run(debug = True)