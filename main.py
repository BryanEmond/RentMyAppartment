from flask import Flask, jsonify, make_response, request, redirect, render_template, url_for
# from flask_cors import CORS
import pymysql
# import bcrypt
# import base64
import sys

app = Flask(__name__)
# app.run(use_reloader=True)
# CORS(app,resources={r'/api/*'})
app.run(debug=True)
mydb = pymysql.connect(
    host="localhost",
    user="root",
    password="Xboxxbox22",
    database="rentmyappartment"
)

mycursor = mydb.cursor()

@app.route("/")
def register():
    if("userIdConnecetion" not in request.cookies):
        return render_template("index.html")
    #if there's a user send it in the html but the password shouldn't be include
    return render_template("index.html")

@app.route("/api/login",methods=['POST'])
def login():
    print(request.values,file=sys.stderr)
    resp = make_response(jsonify({'redirect': "/"}))
    resp.set_cookie('userIdConnecetion', "user1")
    return resp

@app.route("/api/create_account",methods=['POST'])
def create_account():
    print(request.values,file=sys.stderr)
    return('',404)