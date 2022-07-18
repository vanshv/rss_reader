from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin, login_user, LoginManager
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import InputRequired, Length
from flask_bcrypt import Bcrypt
from flask_wtf import FlaskForm

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
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(20), nullable=False, unique=True)
    password = db.Column(db.String(80), nullable=False)
# class RegisterForm(FlaskForm):
#     username = StringField(validators=[InputRequired(), Length(
#         min=4, max=20)], render_kw={"placeholder": "Username"})
#     password = PasswordField(validators=[InputRequired(), Length(
#         min=4, max=20)], render_kw={"placeholder": "Password"})
#     submit = SubmitField("Register")

#     def validate_username(self, username):
#         isExistingUserName = User.query.filter_by(
#             username=username.data).first()
#         if isExistingUserName:
#             return jsonify(["username already exists"])
        
    # check this
    # validate_username(username)

# class LoginForm(FlaskForm):
#     username = StringField(validators=[InputRequired(), Length(
#         min=4, max=20)], render_kw={"placeholder": "Username"})
#     password = PasswordField(validators=[InputRequired(), Length(
#         min=4, max=20)], render_kw={"placeholder": "Password"})
#     submit = SubmitField("Login")

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

if __name__ == "__main__":
    app.run(debug=True)
    
    