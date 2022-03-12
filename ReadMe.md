Installation dependencies
pip install flask PyMySQL bcrypt python-dotenv jw

ENV file
touch .env
add to the .env file
{
    DBPASSWORD=YOUR_DATABASE_PASSWORD
    SECRET=YOUR_JWT_SECRET
}

Setup MySQL
mysql -u root -p
source ./backend_glo_2005/sql/dbcommand.sql

To use Flask
export FLASK_APP=main
export FLASK_ENV=development
flask run
