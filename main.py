from base64 import encode
import base64
from multiprocessing import connection
from tkinter import INSERT
from flask import Flask, jsonify, make_response, request, redirect, render_template, url_for
from dotenv import load_dotenv
# from flask_cors import CORS
import pymysql
import bcrypt
# import base64
import os
import jwt

load_dotenv()
app = Flask(__name__)
# app.run(use_reloader=True)
# CORS(app,resources={r'/api/*'})

mydb = pymysql.connect(
    host="localhost",
    user="root",
    password=os.getenv('DBPASSWORD'),
    database="rentmyappartment"
)

mycursor = mydb.cursor()

@app.route("/")
def register():
    if("userIdConnecetion" not in request.cookies):
        return render_template("index.html")
    #if there's a user send it in the html but the password shouldn't be include
    payload = jwt.decode(request.cookies.get("userIdConnecetion"),os.getenv('SECRET'), algorithms="HS256")
    sql = "SELECT name,email FROM user where UID = %s"
    mycursor.execute(sql,payload["IdUser"])
    user = mycursor.fetchone()
    # print(user,file=sys.stderr)
    return render_template("index.html",USER =user)

@app.route("/api/login",methods=['POST'])
def login():
    # print(request.values,file=sys.stderr)
    sql = "SELECT UID,PID FROM user where email = %s"
    mycursor.execute(sql,request.form.get('email'))
    result = mycursor.fetchone()
    sql = "SELECT password FROM password where PID = %s"
    mycursor.execute(sql,result[1])
    pw = mycursor.fetchone()
    # print(result[0],file=sys.stderr)
    if bcrypt.checkpw(request.form.get('password').encode('utf-8'), pw[0].encode('utf-8')):
        resp = make_response(jsonify({'redirect': "/"}))
        encoded = jwt.encode({"IdUser": result[0]},os.getenv('SECRET'))
        resp.set_cookie('userIdConnecetion', encoded)
        return resp
    return ("",404)

@app.route("/api/create_account",methods=['POST'])
def create_account():
    # print(request.form.get('name'),file=sys.stderr)
    password = bytes(request.form.get('password'), encoding='utf-8')
    hashed = bcrypt.hashpw(password, bcrypt.gensalt())
    base64_byte = base64.b64encode(request.form.get('email').encode("ascii"))
    base64_string = base64_byte.decode("ascii")
    sql = "INSERT INTO password VALUES (%s,%s)"
    mycursor.execute(sql,("PID"+base64_string[9:15],hashed))
    sql = "INSERT INTO user VALUES (%s,%s,%s,%s)"
    mycursor.execute(sql,("UID"+base64_string[0:9],request.form.get('name'),request.form.get('email'),"PID"+base64_string[9:15]))
    mydb.commit()
    return('',202)


if __name__ == "__main__":
    app.run(debug=True)
