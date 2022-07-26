from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin, current_user, login_user, LoginManager, current_user
from flask_bcrypt import Bcrypt
from sqlalchemy import ForeignKey
from sqlalchemy.orm import relationship
import feedparser

app = Flask(__name__)
bcrypt = Bcrypt(app)
db = SQLAlchemy(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'
app.config['SECRET_KEY'] = 'welcometobackends'

loginManager = LoginManager()
loginManager.init_app(app)
loginManager.login_view = "login"

@loginManager.user_loader
def load_user(user_id):
    try:
        return User.query.get(user_id)
    except:
        return None

def get_current_user():
    return current_user

class User(db.Model, UserMixin):
    __tablename__ = "User"
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(20), nullable=False, unique=True)
    password = db.Column(db.String(80), nullable=False)
    children = relationship("Feed")

class Feed(db.Model):
    __tablename__ = "Feed"
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(20), ForeignKey("User.username"), nullable=False)
    feed = db.Column(db.String(40), nullable=False)


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method =="POST":
        uname = request.form['username']
        pword = request.form['password']
        user = User.query.filter_by(username=uname).first()
        if user is None:
            return jsonify(["no user found"])
        else:
            if bcrypt.check_password_hash(user.password, pword):
                login_user(user, remember=True)
                return jsonify(["success"])
            else:
                return jsonify(["Wrong password"])
    

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method =="POST":
        username = request.form['username']
        password = request.form['password']
        hashedPassword = bcrypt.generate_password_hash(password)
        newUser = User(username=username, password=hashedPassword)
        db.session.add(newUser)
        db.session.commit()
        return jsonify(["Register success"])
    else:
        return jsonify(["Registration failed"])
    
    
@app.route('/addfeed', methods=['GET', 'POST'])
def addfeed():
    if request.method == "POST":
        ffeed = request.form['feed']
        uname = request.form['username']
        feed = Feed.query.filter_by(username=uname, feed=ffeed).first()
        if feed is not None:
            return jsonify(["feed already added"])
        newFeed = Feed(username = uname, feed = ffeed)
        db.session.add(newFeed)
        db.session.commit()
        return jsonify(["AddFeed success"])
    else:
        return jsonify(["AddFeed failure"])
    
def retdate(item):
    return item['published_parsed'];
    
@app.route('/getallfeeds', methods=['GET', 'POST'])
def getallfeeds():
    if request.method == "POST":
        uname = request.form['username']
        feedObjects = Feed.query.filter_by(username=uname)
        
        first = 'https://rss.art19.com/apology-line'
        all = feedparser.parse(first)
        
        urlStrings = []
        for feedObject in feedObjects:
            urlStrings.append(feedObject.feed)
       
        rssFeeds = [] 
        for urlString in urlStrings:
            rssFeeds.append(feedparser.parse(urlString))

        for rssFeed in rssFeeds:
            for rssItem in rssFeed.entries:
                all.entries.append(rssItem)
                
        all.entries.sort(key=retdate)
        
        count = 0;
        for item in all.entries:
            count += 1
        all["itemcount"] = count
        
        return jsonify(all)
            
    else:
        return jsonify(["GetAllFeed failure"])

if __name__ == "__main__":
    app.run(debug=True)
    
    