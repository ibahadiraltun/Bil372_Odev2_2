from flask import Flask, render_template,request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import select, update
from sqlalchemy.orm import Session
import psycopg2
from datetime import datetime

app = Flask(__name__)

#connection to database
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:test@localhost/HW2'
db=SQLAlchemy(app)
session =Session(db.engine)
conn=db.engine.connect()

#tables
City = db.Table('city', db.metadata, autoload=True, autoload_with=db.engine)
User = db.Table('usersinfo', db.metadata, autoload=True, autoload_with=db.engine)
Conf = db.Table('conference', db.metadata, autoload=True, autoload_with=db.engine)


@app.route('/', methods=['POST', 'GET'])
def login():
   if request.method == 'POST':
      email= request.form['email']
      password= request.form['password']
      query= select([User.c.password]).where(User.c.primary_email == email)
      db_password= conn.execute(query).fetchone()
      if(db_password != None and  password == db_password[0] ):
         if(email == 'admin'):
            return redirect(url_for('main'))
         else:
            query= select([User.c.status]).where(User.c.primary_email == email)
            status= conn.execute(query).fetchone()[0]
            if status == 1: return redirect(url_for('user'))
            else:
                error='Need ADMIN approval'
                return render_template('login.html', error=error)
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
         conn.execute(new_user)
         return redirect(url_for('login'))
      else:
         return render_template('signup.html', cities=session.query(City).all(), error = error)   
   else:
      return render_template('signup.html', cities = session.query(City).all() )

def get_users():
   query=select([User]).where(User.c.status == 0)
   return conn.execute(query)

def update_user_status(id, status):
   query = update(User).where(User.c.authenticationid == id).values(status = status)
   conn.execute(query)

def get_confs():
   query=select([Conf]).where(Conf.c.status == 0)
   return conn.execute(query)

def update_conf_status(id, status):
   query = update(Conf).where(Conf.c.confid == id).values(status = status)
   conn.execute(query)

def handle_status_change(form, model):
   is_tick = ('submit_tick' in form)
   new_status = is_tick + (1 - is_tick) * -1
   id = -1

   if is_tick: id = form['submit_tick']
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

@app.route('/conference', methods=['POST', 'GET'])
def conference(): 
   
   if request.method == 'POST':
      confid=request.form['confid']
      name=request.form['name']
      shortname=request.form['shortname']
      year=request.form['year']
      start_date=request.form['start_date']
      end_date=request.form['end_date']
      submission_deadline=request.form['submission_deadline']
      creator_user=request.form['creator_user']
      website=request.form['website']
      Creation_DateTime=request.form['Creation_DateTime']
      dt = datetime.utcnow()
      new_conference= Conf.insert().values(confid=confid,name=name, shortname=shortname,year=year,start_date=start_date,end_date=end_date,submission_deadline=submission_deadline,creator_user=creator_user,website=website,Creation_DateTime=Creation_DateTime)
      conn.execute(new_conference)
      return redirect(url_for('main'))
   else:
      return render_template('conference.html', usersinfos = session.query(User).all() )  

 


if __name__ == '__main__':
   app.run(debug = True)