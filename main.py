from flask import Flask, jsonify, make_response, request, redirect, render_template, url_for
from dotenv import load_dotenv
# from flask_cors import CORS
import pymysql
import bcrypt
import base64
import os
import sys
import jwt


load_dotenv()
app = Flask(__name__)
# app.run(use_reloader=True)
# CORS(app,resources={r'/api/*'})

mydb = pymysql.connect(
    host="localhost",
    user=os.getenv('DBPUSER'),
    password=os.getenv('DBPASSWORD'),
    database="rentmyappartment"
)

mycursor = mydb.cursor()


@app.route("/")
def register():
    sql = "SELECT * FROM appartments ORDER BY LID"
    mycursor.execute(sql)
    appartment = mycursor.fetchall()
    sql = "SELECT * FROM localisation"
    mycursor.execute(sql)
    localisation = mycursor.fetchall()
    if("userIdConnecetion" not in request.cookies):
        return render_template("index.html",APPARTMENT=appartment,LOCS=localisation)
    # if there's a user send it in the html but the password shouldn't be include
    payload = jwt.decode(request.cookies.get(
        "userIdConnecetion"), os.getenv('SECRET'), algorithms="HS256")
    sql = "SELECT firstName,UID FROM user where UID = %s"
    mycursor.execute(sql, payload["IdUser"])
    user = mycursor.fetchone()
    
    return render_template("index.html", USER=user,APPARTMENT=appartment,LOCS=localisation)


@app.route("/api/login", methods=['POST'])
def login():
    try:
        sql = "SELECT select_user(%s)"
        mycursor.execute(sql, request.form.get('email'))
        pw = mycursor.fetchone()
        if bcrypt.checkpw(request.form.get('password').encode('utf-8'), pw[0].encode('utf-8')):
            resp = make_response("", 200)
            encoded = jwt.encode({"IdUser": request.form.get('email')}, os.getenv('SECRET'))
            resp.set_cookie('userIdConnecetion', encoded)
            return resp
    except:
        return ("", 404)


@app.route("/api/create_account", methods=['POST'])
def create_account():
    try:
        # print(request.form.get('name'),file=sys.stderr)
        password = bytes(request.form.get('password'), encoding='utf-8')
        hashed = bcrypt.hashpw(password, bcrypt.gensalt())
        sql = "CALL new_account(%s,%s,%s,%s,%s)"
        mycursor.callproc("new_account",(request.form.get('email'), request.form.get('name'),request.form.get('lastName'),request.form.get('middleName'),hashed))
        mydb.commit()
        return('', 200)
    except:
        return ("", 404)

@app.route("/api/CreateAd", methods=['POST'])
def CreateAd():
    base64_byte = base64.b64encode(request.form.get('AID').encode("ascii"))
    base64_string = base64_byte.decode("ascii")
    sql = "INSERT INTO appartments VALUES (%s,%s,%s,%s,%s,%s,%s)"
    print((request.form.get('AID'), int(request.form.get('price')), request.form.get('description'), request.form.get('UID'),request.form.get('town'), request.form.get('size')),file=sys.stderr)
    mycursor.execute(sql, (request.form.get('AID'), int(request.form.get('price')), request.form.get('description'), request.form.get('UID'),int(request.form.get('town')), request.form.get('size'),False))
    mydb.commit()
    return ("", 202)

@app.route("/api/sign_out", methods=['POST'])
def sign_out():
    if("userIdConnecetion" in request.cookies):
        resp = make_response("", 200)
        resp.set_cookie('userIdConnecetion', '', expires=0)
        return resp
    return('', 404)


@app.route("/api/redirectToAdManager", methods=['POST'])
def redirectToAdManager():
    resp = make_response(
        jsonify({"redirect": "/manageAd"}), request.form.get('UID'))
    return resp


@app.route("/manageAd")
def manageAd():
    if("userIdConnecetion" not in request.cookies):
        return render_template("index.html")
    payload = jwt.decode(request.cookies.get(
        "userIdConnecetion"), os.getenv('SECRET'), algorithms="HS256")
    sql = "SELECT firstName,UID FROM user where UID = %s"
    mycursor.execute(sql, payload["IdUser"])
    user = mycursor.fetchone()
    sql = "SELECT * FROM appartments where UID = %s"
    mycursor.execute(sql, payload["IdUser"])
    appartment = mycursor.fetchall()
    mycursor.callproc("selection_appt_grandeur")
    size = mycursor.fetchall()
    sql = "SELECT * FROM localisation"
    mycursor.execute(sql)
    localisation = mycursor.fetchall()
    return render_template("manageAd.html", USER=user, APPARTMENT=appartment,SIZE=size,LOCS=localisation)


if __name__ == "__main__":
    app.run(debug=True)
