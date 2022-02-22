import email
from flask import Flask, request, redirect
from flask_cors import CORS
from mysql import connector
import bcrypt
import base64

app = Flask(__name__)
app.run(use_reloader=True)
CORS(app,resources={r'/api/*'})

mydb = connector.connect(
    host="localhost",
    user="root",
    password="Xboxxbox22",
    database="chessandgo"
)

mycursor = mydb.cursor()

@app.route("/api/register",methods=['POST'])
def register():
    data = request.json
    message_bytes = data["email"].encode("ascii")
    base64_bytes = base64.b64encode(message_bytes,altchars=b'-:')
    base64_message = base64_bytes.decode("ascii")
    idUser = ''
    for i in range(9):
        idUser += base64_message[i]
    idUser = "USER"+idUser
    selectQuery = "SELECT idUser,email,username FROM user WHERE email=%s OR username=%s OR idUser=%s"
    selectVal = (data["email"],data["userName"],idUser)
    mycursor.execute(selectQuery, selectVal)
    responce = mycursor.fetchall()
    if(len(responce) == 0):
        hashed = bcrypt.hashpw(data["password"].encode("utf-8"), bcrypt.gensalt())
        query = "INSERT INTO user (idUser,name,famillyName,email,userName,password) values (%s,%s,%s,%s,%s,%s)"
        val = (idUser,data["name"],data["famillyName"],data["email"],data["userName"],hashed)
        mycursor.execute(query, val)
        mydb.commit()
        return ('',202)
    else:
        return('',404)

@app.route("/api/login",methods=['POST'])
def login():
    data = request.json
    selectQuery = "SELECT password FROM user WHERE username=%s"
    selectVal = [data["userName"]]
    mycursor.execute(selectQuery, selectVal)
    responce = mycursor.fetchall()
    print(responce)
    if(len(responce) == 1 and bcrypt.checkpw(data["password"].encode("utf-8"),responce[0][0].encode("utf-8"))):
        return ("good password")#redirect(request.url+"/",202,'letsgo')
    elif(not bcrypt.checkpw(data["password"].encode("utf-8"),responce[0][0].encode("utf-8"))):
        return ("wrong password")
    else:
        return('',404)