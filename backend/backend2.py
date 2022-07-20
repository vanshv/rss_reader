from flask import Flask, jsonify, request, sessions
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin, login_required, login_user, LoginManager
from requests import session
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import InputRequired, Length
from flask_bcrypt import Bcrypt
from flask_wtf import FlaskForm
from sqlalchemy import Column, ForeignKey, Integer, Table
from sqlalchemy.orm import declarative_base, relationship


app = Flask(__name__)
bcrypt = Bcrypt(app)
db = SQLAlchemy(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'
app.config['SECRET_KEY'] = 'welcometobackends'

loginManager = LoginManager()
loginManager.init_app(app)
loginManager.login_view = "login"

@loginManager.user_loader
def load_user(userId):
    return User.query.get(int(userId))

class User(db.Model, UserMixin):
    __tablename__ = "User"
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(20), nullable=False, unique=True)
    password = db.Column(db.String(80), nullable=False)
    children = relationship("Feeds")

class Feeds(db.Model, UserMixin):
    __tablename__ = "Feeds"
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
                login_user(user)
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
@login_required
#something to do with this login
def addfeed():
    if request.method == "POST":
        ffeed = request.form['feed']
        uname = session['username']
        newFeed = Feeds(username = uname, feed = ffeed)
        db.session.add(newFeed)
        db.session.commit()
        return jsonify(["AddFeed success"])
    return jsonify(["AddFeed failure"])

if __name__ == "__main__":
    app.run(debug=True)
    
    