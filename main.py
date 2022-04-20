from email import message
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
    mycursor.callproc("selection_appt_grandeur")
    size = mycursor.fetchall()
    sql = "SELECT * FROM appartments WHERE SOLD <> TRUE ORDER BY LID"
    mycursor.execute(sql)
    appartment = mycursor.fetchall()
    sql = "SELECT * FROM localisation"
    mycursor.execute(sql)
    localisation = mycursor.fetchall()
    if("userIdConnecetion" not in request.cookies):
        return render_template("index.html",APPARTMENT=appartment,SIZE=size,LOCS=localisation)
    payload = jwt.decode(request.cookies.get(
        "userIdConnecetion"), os.getenv('SECRET'), algorithms="HS256")
    sql = "SELECT firstName,UID FROM user where UID = %s"
    mycursor.execute(sql, payload["IdUser"])
    user = mycursor.fetchone()
    
    return render_template("index.html", USER=user,APPARTMENT=appartment,SIZE=size,LOCS=localisation)


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

@app.route("/api/searchAppartment", methods=['POST'])
def searchAppartment():
    # print(request.form,file=sys.stderr)
    try :
        resp = make_response(
        jsonify({"redirect": "/search","message":request.form}))
        return resp
    except:
        return ("", 404)

@app.route("/search")
def search():
    params=[request.args.get("AID"),request.args.get("loc", default=0, type=int),request.args.get("size"),request.args.get("minP", default=0, type=int),request.args.get("maxP", default=0, type=int)]
    print(params,file=sys.stderr)
    mycursor.callproc("selection_appt_grandeur")
    size = mycursor.fetchall()
    print(params,file=sys.stderr)
    mycursor.callproc("selection_appartment",(params[0],params[1],params[2],params[3],params[4]))
    appartment = mycursor.fetchall()
    sql = "SELECT * FROM localisation"
    mycursor.execute(sql)
    localisation = mycursor.fetchall()
    if("userIdConnecetion" not in request.cookies):
        return render_template("search.html",APPARTMENT=appartment,SIZE=size,LOCS=localisation)
    payload = jwt.decode(request.cookies.get(
        "userIdConnecetion"), os.getenv('SECRET'), algorithms="HS256")
    sql = "SELECT firstName,UID FROM user where UID = %s"
    mycursor.execute(sql, payload["IdUser"])
    user = mycursor.fetchone()
    return render_template("search.html",USER=user,APPARTMENT=appartment,SIZE=size,LOCS=localisation)
    

@app.route("/api/deleteAppartment", methods=['POST'])
def deleteAppatment():
    try :
        sql = "DELETE FROM appartments WHERE AID = %s"
        mycursor.execute(sql,request.form.get('AID') )
        mydb.commit()
        return ("", 202)
    except:
        return ("", 404)

@app.route("/api/louerAppartment", methods=['POST'])
def louerAppartment():
    try :
        sql = "UPDATE appartments SET SOLD = TRUE WHERE AID = %s;"
        mycursor.execute(sql,request.form.get('AID') )
        mydb.commit()
        return ("", 202)
    except:
        return ("", 404)

@app.route("/api/RetirerAppartment", methods=['POST'])
def RetirerAppartment():
    try :
        sql = "UPDATE appartments SET SOLD = FALSE WHERE AID = %s;"
        mycursor.execute(sql,request.form.get('AID') )
        mydb.commit()
        return ("", 202)
    except:
        return ("", 404)

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
