# Write a program that read this CSV file and stores it into the employees table.

import psycopg2 
import csv

con = psycopg2.connect(
  database="fced_rhaydrick_tavares",             # your database is the same as your username
  user="fced_rhaydrick_tavares",                 # your username
  password="Rhaydrick@0358",             # your password
  host="dbm.fe.up.pt",             # the database host
  options='-c search_path=employee',
  port='5433'  # use the schema you want to connect to
)

with open('employee.csv') as f:
    cur = con.cursor()
    cur.copy_from(f, "employee", sep=",")
    con.commit()