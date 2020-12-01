from flask import Flask, render_template,request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
#from sqlalchemy.ext.automap import automap_base
#from sqlalchemy import create_engine
from sqlalchemy import select, update
from sqlalchemy.orm import Session
import psycopg2
from datetime import datetime

app = Flask(__name__)


app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://ibahadiraltun:test@localhost/bil372-hw2'
#engine = create_engine("postgresql+psycopg2://postgres:test@localhost/HW2")
db=SQLAlchemy(app)
#Base = automap_base()
#Base.prepare(engine, reflect=True)
session =Session(db.engine)  
City = db.Table('city', db.metadata, autoload=True, autoload_with=db.engine)
User = db.Table('usersinfo', db.metadata, autoload=True, autoload_with=db.engine)
Conf = db.Table('conference', db.metadata, autoload=True, autoload_with=db.engine)
#city = Base.classes.city 
   

conf_requests = []
for i in range(0, 20):
   conf_requests.append({
      'name': 'conf' + str(i),
      'confid': i
   })

@app.route('/', methods=['POST', 'GET'])
def login():
   if request.method == 'POST':
      email= request.form['email']
      password= request.form['password']
      query= select([User.c.password]).where(User.c.primary_email == email)
      db_password= db.engine.connect().execute(query).fetchone()[0]
      if(password == db_password ):
         if(email == 'admin'):
            return redirect(url_for('main'))
         else:
            return render_template('user.html')
      else:
         error = 'Wrong password or email'
         return render_template('login.html', error=error)
   else:   
      return render_template('login.html')



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
      error=''
      if(password != confirmpassword):
         error = 'Passwords do not match!!' 
      
      if(error == ''):
         dt = datetime.utcnow()
         new_user= User.insert().values(title=title, name=name, lname=lastname,affiliation=affiliation,primary_email=p_email,secondary_email=s_email,password=password,phone=phone,fax=fax,address=address,url=url,city=city,country=country,date=dt,status=0)
         db.engine.connect().execute(new_user)
         return redirect(url_for('login'))
      else:
         return render_template('signup.html', cities=session.query(City).all(), error = error)   
   else:
      return render_template('signup.html', cities = session.query(City).all() )

def get_users():
   query=select([User]).where(User.c.status == 0)
   return db.engine.connect().execute(query)

def update_user_status(id, status):
   query = update(User).where(User.c.authenticationid == id).values(status = status)
   db.engine.connect().execute(query)

def get_confs():
   query=select([Conf]).where(Conf.c.status == 0)
   return db.engine.connect().execute(query)

def update_conf_status(id, status):
   query = update(Conf).where(Conf.c.confid == id).values(status = status)
   db.engine.connect().execute(query)

def handle_status_change(form, model):
   id, new_status = None, None
   is_tick = ('submit_tick' in form)
   new_status = is_tick + (1 - is_tick) * -1

   if is_tick:id = form['submit_tick']
   else: id = form['submit_cross']

   if model == 'User': update_user_status(id, new_status)
   else: update_conf_status(id, new_status)
   
   return render_template('main.html', users = get_users(), confs = get_confs())

@app.route('/main', methods=['POST', 'GET'])
def main():
   if request.method == 'POST':
      if (request.form['form_type'] == 'user'):
         return handle_status_change(form = request.form, model = 'User')
      return handle_status_change(form = request.form, model = 'Conference')
   else:
      return render_template('main.html', users = get_users(), confs = get_confs())

@app.route('/conference')
def conference():
   return render_template('conference.html')  


if __name__ == '__main__':
   app.run(debug = True)