<h1>Setup Project</h1>
<h3>Installation dependencies</h3>
pip install flask PyMySQL bcrypt python-dotenv jw

<h3>ENV file</h3>
touch .env
<h7>add to the .env file<h7>
DBPASSWORD=YOUR_DATABASE_PASSWORD
 SECRET=YOUR_JWT_SECRET

<h3>Setup MySQL</h3>
mysql -u root -p
source ./backend_glo_2005/sql/dbcommand.sql

<h3>To use Flask</h3>
export FLASK_APP=main
export FLASK_ENV=development
flask run
