from flask import Flask, render_template,request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import select, update, and_
from sqlalchemy.orm import Session
import psycopg2
from datetime import datetime
from sqlalchemy.sql.operators import nullsfirst_op
from flask_pymongo import PyMongo
from pymongo import MongoClient

from datetime import datetime


client = MongoClient('mongodb://localhost:27017/')
app = Flask(__name__)

app.config['MONGO_DBNAME'] = 'local'
app.config['MONGO_URI'] = 'mongodb://localhost:27017/local'

mongo = PyMongo(app)

#connection to database
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:test@localhost/HW2'
db=SQLAlchemy(app)
session =Session(db.engine)
conn=db.engine.connect()

#tables
City = db.Table('city', db.metadata, autoload=True, autoload_with=db.engine)
User = db.Table('usersinfo', db.metadata, autoload=True, autoload_with=db.engine)
UsersLog = db.Table('userslog', db.metadata, autoload=True, autoload_with=db.engine)
Conf = db.Table('conference', db.metadata, autoload=True, autoload_with=db.engine)
ConfRole = db.Table('conferenceroles', db.metadata, autoload=True, autoload_with=db.engine)
ConfUpdate = db.Table('conferenceupdates', db.metadata, autoload=True, autoload_with=db.engine)
Submission = db.Table('submissions', db.metadata, autoload=True, autoload_with=db.engine)

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
            if status == 1: 
               query= select([User.c.authenticationid]).where(User.c.primary_email == email)
               id= conn.execute(query).fetchone()[0]
               return redirect(url_for('user', id=id))
            else: #2 for delete, 0 for inactive
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
def insertUserLogs(id):
   query=select([User]).where(User.c.authenticationid == id)
   user= conn.execute(query).fetchone()  
   values = {
      'authenticationid':user.authenticationid,
      'title':user.title,
      'name':user.name,
      'lname':user.lname,
      'affiliation':user.affiliation,
      'primary_email':user.primary_email,
      'secondary_email':user.secondary_email,
      'phone': user.phone,
      'fax': user.fax,
      'address': user.address,
      'url': user.url,
      'city': user.city,
      'country': user.country,
      'password': user.password,
      'date':user.date,
      'status':user.status
   }
   userlog= UsersLog.insert().values(values)
   conn.execute(userlog)

def get_users():
   query=select([User]).where(User.c.status == 0)
   return conn.execute(query)

def get_valid_users():
   query=select([User]).where(User.c.status > 0)
   return conn.execute(query)

def update_user_status(id, status):
   query = update(User).where(User.c.authenticationid == id).values(status = status)
   conn.execute(query)

def get_confs():
   query = select([Conf]).where(Conf.c.status == 0)
   return conn.execute(query)

def get_valid_confs():
    query = select([Conf]).where(Conf.c.status > 0)
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

def get_submissions_for_user(id):
   query = select([Submission]).where(Submission.c.authenticationid == id)
   query_user = select([User]).where(User.c.authenticationid == id)
   subs = conn.execute(query)
   username = conn.execute(query_user).fetchone().primary_email
   res = []
   for row in subs:
      cur_row = dict(row.items())
      cur_row['username'] = username
      res.append(cur_row)
   return res

def update_mongodb(values):
    mongo.db.submissions.insert(values)

def add_submission_for_user(id, form):
   # userid = request.form['userid']
   # confid = request.form['confid']
   # title = request.form['title']
   # abstract = request.form['abstract']
   # keywords = request.form['keywords']
   # pdf_path = request.form['pdf_path']
   # authors = form['authors']

   confid = form['confid']
   query = select([Submission]).where(
      and_(
         Submission.c.authenticationid == id,
         Submission.c.confid == confid
      )
   )
   subs = conn.execute(query)
   prevsubmissionid = -1
   for sub in subs:
      if prevsubmissionid < sub['submissionid']:
         prevsubmissionid = sub['submissionid']
   
   values = {
      'authenticationid': form['userid'],
      'confid': form['confid'],
      'prevsubmissionid': prevsubmissionid
   }

   new_sub = Submission.insert().values(values)
   conn.execute(new_sub)
   query_subid = select([Submission]).where(
      and_(
         Submission.c.authenticationid == id,
         Submission.c.confid == form['confid'],
         Submission.c.prevsubmissionid == prevsubmissionid
      )
   )
   subid = conn.execute(query_subid).fetchone().submissionid

   now = datetime.now()
   dt_string = now.strftime("%d/%m/%Y %H:%M:%S")

   author_infos = []
   for aut in form.getlist('authors'):
      id = int(aut.split(' - ')[2])
      query_aut = select([User]).where(User.c.authenticationid == id)
      infos = conn.execute(query_aut).fetchone()
      infos_dict = dict(infos)
      author_infos.append(infos_dict)

   values_mongodb = {
      'prevsubmissionid': str(prevsubmissionid),
      'submissionid': str(subid),
      'title': form['title'],
      'abstract': form['abstract'],
      'keywords': str(form['keywords'].split(',')),
      'authors': author_infos,
      'submitted_by': str(id),
      'corresponding author': str(id),
      'pdf_path': form['pdf_path'],
      'type': 'article',
      'submission_date_time': dt_string,
      'status': '1',
      'active': '0'
   }

   update_mongodb(values_mongodb)

@app.route('/main', methods=['POST', 'GET'])
def main():
   if request.method == 'POST':
      if (request.form['form_type'] == 'user'):
         return handle_status_change(form = request.form, model = 'User')
      return handle_status_change(form = request.form, model = 'Conference')
   else:
      return render_template('main.html', users = get_users(), confs = get_confs())

@app.route('/conference/<userid>', methods=['POST', 'GET'])
def conference(userid):   
   if request.method == 'POST':
      name=request.form['name']
      shortname=request.form['shortname']
      year=request.form['year']
      start_date=request.form['start_date']
      end_date=request.form['end_date']
      submission_deadline=request.form['submission_deadline']
      creator_user=userid
      website=request.form['website']
      confid='_' + shortname + '_' + year
      query=select([Conf]).where(Conf.c.confid == confid)
      result= conn.execute(query).fetchone()
      if result != None:
         karakter = "_"
         a = confid.rfind(karakter) + 2
         length = len(confid)
         if(a == length):
            num = int(confid[-1]) + 1
            confid = confid[0:len(confid)-1] + str(num)
         else:
            confid = confid + "_2"  
      Creation_DateTime = datetime.utcnow()
      new_conference= Conf.insert().values(confid=confid,name=name, shortname=shortname,year=year,start_date=start_date,end_date=end_date,submission_deadline=submission_deadline,creator_user=creator_user,website=website,creation_datetime=Creation_DateTime,status=0)
      conn.execute(new_conference)
      return redirect(url_for('user', id=userid))
   else: 
      return render_template('conference.html', usersinfos = session.query(User).all() )  

@app.route('/user/<int:id>')
def user(id):
   query= select([Conf, ConfRole.c.confid_role]).where(and_(Conf.c.confid==ConfRole.c.confid,ConfRole.c.authenticationid == id) )
   conferences= conn.execute(query).fetchall() 
   return  render_template('user.html', conferences=conferences, userid=id  )

@app.route('/user_changeInfo/<int:id>', methods=['POST', 'GET'])
def user_changeInfo(id):
   if request.method == 'POST':
      city_country=request.form['city']
      tmp = city_country.split("-")
      city=tmp[0].strip()
      country=tmp[1].strip()  
      values = {
      'title': request.form['title'],
      'name': request.form['name'],
      'lname': request.form['lastname'],
      'affiliation': request.form['affiliation'],
      'primary_email': request.form['p_email'],
      'secondary_email': request.form['s_email'],
      'phone': request.form['phone'],
      'fax': request.form['fax'],
      'address': request.form['address'],
      'url': request.form['URL'],
      'city': city,
      'country': country,
      'password': request.form['password']
      }
      insertUserLogs(id)
      query = update(User).where(User.c.authenticationid == id).values(values)
      conn.execute(query)
      return redirect(url_for('user', id=id))
   query=select([User]).where(User.c.authenticationid == id)
   user= conn.execute(query).fetchone()
   return render_template('changeInfo.html', user=user, cities=session.query(City).all())


@app.route('/submissions/<int:userid>')
def submissions(userid):
   return render_template('submissions.html', userid=userid, submissions=get_submissions_for_user(userid))

@app.route('/newSubmissions/<int:userid>', methods=['POST', 'GET'])
def newSubmission(userid):
   if request.method == 'POST':
      add_submission_for_user(id = userid, form = request.form)
      return render_template('submissions.html', userid=userid, submissions=get_submissions_for_user(userid))
   return render_template('newSubmission.html', userid=userid, users = get_valid_users(), confs=get_valid_confs())

@app.route('/update/<confid>/<int:userid>' , methods=['POST', 'GET'])
def user_update_conf(confid,userid):
   if request.method =='POST':
      name=request.form['name']
      sname=request.form['shortname']
      year=request.form['year']
      start_date=request.form['start_date']
      end_date=request.form['end_date']
      submission_deadline=request.form['submission_deadline']
      website=request.form['website']
      query= ConfUpdate.insert().values(confid=confid,name=name, shortname=sname,year=year,start_date=start_date,end_date=end_date,submission_deadline=submission_deadline,website=website)
      conn.execute(query)
      return redirect(url_for('user', id=userid))
   else:
      query=select([Conf]).where(Conf.c.confid == confid)
      conference= conn.execute(query).fetchone()
      return render_template('updateConference.html', conf=conference)

@app.route('/delete/<confid>/<int:userid>')
def user_delete_conf(confid,userid):
   query = update(Conf).where(Conf.c.confid == confid).values(status = 2)
   conn.execute(query)
   return redirect(url_for('user', id=userid))

if __name__ == '__main__':
   app.run(debug = True)