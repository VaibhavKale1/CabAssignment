
import mysql.connector


class DBConnection:
    db_con = None
    def __init__(self):
        mydb = mysql.connector.connect(
            host="localhost",
            user="root", # Todo : put all db config/creds in config files, for now will complete the main part
            password="openstack1",
            database="cab_svc"
        )
        DBConnection.db_con = mydb

    @classmethod
    def get_db_con(cls):
        if cls.db_con:
            return cls.db_con
        else:
            DBConnection()
            return cls.db_con

if __name__ == "__main__":
    db = DBConnection.get_db_con()
    # add dummy users...
    sql = """INSERT INTO `cab_svc`.`user` ( `user_full_name`, `user_address`, `user_phone`, `user_role`)
                                  VALUES ( %s,%s,%s,%s);"""
    values = [("vaibhav kale", "akluj", "8888888", "customer"),
              ("vaibhav kale", "akluj", "8888888", "driver"),
              ("abc", "akluj", "8888888", "admin"),
            ]
    mycursor = db.cursor()
    for val in values:
        mycursor.execute(sql, val)
    print(mycursor.lastrowid)

    # add dummy cities
    sql = """INSERT INTO `cab_svc`.`city` (`city_name`, `state_name`, `service_available`) 
                             VALUES (%s, %s, %s)"""
    values = [("Solapur", "MH", "true"),
              ("Pune", "MH", "true"),
              ("Mumbai", "MH", "true"),
              ]
    for val in values:
        mycursor.execute(sql, val)
    print(mycursor.lastrowid)
    db.commit()