from flask import Flask, render_template,request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
#from sqlalchemy.ext.automap import automap_base
#from sqlalchemy import create_engine
from sqlalchemy.orm import Session
import psycopg2
from datetime import datetime

app = Flask(__name__)


app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:test@localhost/HW2'
#engine = create_engine("postgresql+psycopg2://postgres:test@localhost/HW2")
db=SQLAlchemy(app)
#Base = automap_base()
#Base.prepare(engine, reflect=True)
session =Session(db.engine)  
City = db.Table('city', db.metadata, autoload=True, autoload_with=db.engine)
User = db.Table('usersinfo', db.metadata, autoload=True, autoload_with=db.engine)
#city = Base.classes.city 
   

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


#checkings will be added, it is just a structure.
@app.route('/signup', methods=['POST', 'GET'])
def signup():

   if request.method == 'POST':
      title=request.form['title']
      name=request.form['name']
      lastname=request.form['lastname']
      affiliation=request.form['affiliation']
      p_email=request.form['p_email']
      s_email=request.form['s_email']
      phone=request.form['phone']
      fax=request.form['fax']
      address=request.form['address']
      url=request.form['URL']
      city_country=request.form['city']
      tmp = city_country.split("-")
      city=tmp[0].strip()
      country=tmp[1].strip()
      password=request.form['password']
      confirmpassword=request.form['confirmpassword']
      dt = datetime.utcnow()
      new_user= User.insert().values(title=title, name=name, lname=lastname,affiliation=affiliation,primary_email=p_email,secondary_email=s_email,password=password,phone=phone,fax=fax,address=address,url=url,city=city,country=country,date=dt,status=0)
      db.engine.connect().execute(new_user)
      return redirect(url_for('login'))
   else:
      return render_template('signup.html', cities = session.query(City).all() )   

       

@app.route('/main')
def main():
   return render_template('main.html', users = user_requests, confs = conf_requests)

@app.route('/conference')
def conference():
   return render_template('conference.html')  


if __name__ == '__main__':
   app.run(debug = True)