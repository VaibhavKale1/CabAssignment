from cab_svc.db_util.db_connection import DBConnection


def login(user_id, password):
    # return valid session_id, token if user is authenticated
    # since we have no db in place, so just adding placeholder
    # Todo: will be added later in case time permits
    token = "dasfasdfaefrfsdsdfsd=v-sdvsdvsdfesd"
    return token


def register_cab(user_id, cab_number, cab_city_id):
    """
    Add/register cab on cab portal
    :param user_id:
    :param cab_number:
    :param cab_city:
    :return: unique cab_id
    """
    db = DBConnection.get_db_con()
    # due to time limit , not creating ORM here.
    sql = """INSERT INTO `cab_svc`.`cab` (`cab_user_id`, `cab_number`, `cab_state`, `cab_city_id`)
                                   VALUES( %s,%s,%s,%s);"""
    val = (user_id, cab_number, "idle", cab_city_id)
    mycursor = db.cursor()
    mycursor.execute(sql, val)
    cab_id = mycursor.lastrowid
    print(cab_id)
    db.commit()
    return cab_id


def register_new_city(city_name, state_name, service_status='true'):
    """
    register new city to start cab service in city
    :return: city_id
    """
    db = DBConnection.get_db_con()
    # due to time limit , not creating ORM here.
    sql = """INSERT INTO `cab_svc`.`city` (`city_name`, `state_name`,`service_available`) VALUES ( %s,%s,%s);"""
    val = (city_name, state_name, service_status)
    mycursor = db.cursor()
    mycursor.execute(sql, val)
    cab_id = mycursor.lastrowid
    print(cab_id)
    db.commit()
    return cab_id


def change_cab_loc(cab_id, lat, long, city_id):
    """
    cab will use this to update its loc at specific time
    :param cab_id:
    :param lat:
    :param long:
    :param city_id:
    :return:
    """
    db = DBConnection.get_db_con()
    sql = """UPDATE `cab_svc`.`cab` SET `cab_city_id` = {}, 
    `cab_lat` = {}, `cab_long` = {} WHERE `cab_id` = {};""".format(city_id,lat, long, cab_id)
    mycursor = db.cursor()
    mycursor.execute(sql)
    cab_id = mycursor.lastrowid
    print(cab_id)
    db.commit()
    return True


def change_cab_state(cab_id, cab_status):
    """
    update cab status
    :return:
    """
    db = DBConnection.get_db_con()
    sql = """UPDATE `cab_svc`.`cab` SET `cab_state` = '{}' WHERE `cab_id` = {};""".format(cab_status,cab_id)
    mycursor = db.cursor()
    mycursor.execute(sql)
    cab_id = mycursor.lastrowid
    print(cab_id)
    db.commit()
    return True

def get_travelled_time(cab_id, for_last=24):
    # return travelled time in hrs in last 24 hrs
    from datetime import datetime, timedelta
    #  d_obj is 24 hrs old date object
    d_obj = datetime.now() - timedelta(hours=for_last)
    till_date = d_obj.strftime("%Y-%m-%d %H:%M:%S")
    sql = """select start_time, end_time from `cab_svc`.`journey` WHERE `cab_id` = {} AND end_time>='{}'""".format(cab_id, till_date)
    db = DBConnection.get_db_con()
    mycursor = db.cursor()
    mycursor.execute(sql)
    travelled_hrs = 0
    for jn in mycursor:
        print(jn, d_obj)
        if jn[0] >= d_obj and jn[1]> d_obj:
            travelled_hrs = travelled_hrs + (jn[1]-jn[0]).seconds/3600
        elif jn[1]> d_obj:
            travelled_hrs = travelled_hrs + (jn[1] - d_obj).seconds/3600
    return travelled_hrs

def select_best_cab(cab_result):
    large_idle_time = 0
    for cab_id in cab_result:
        if cab_result[cab_id]> large_idle_time:
            large_idle_time = cab_result[cab_id]
            best_cab_id = cab_id
    return best_cab_id


def book_cab(customer_id, customer_city_id, end_city_id):
    """
    To book appropriate cab for requested customer based on his city
    :param customer_id:
    :param customer_city_id:
    :return: return journey_id if booked successfully
    """
    # find out all cabs in same city where customer is requesting
    sql = """select cab_id from `cab_svc`.`cab` WHERE `cab_state` = 'idle' AND `cab_city_id` = {}""".format(customer_city_id)
    db = DBConnection.get_db_con()
    mycursor = db.cursor()
    mycursor.execute(sql)
    cab_found = { row[0] : 24 for row in mycursor.fetchall()}
    if not cab_found:
        raise Exception("CabNotFound")

    # calculate idle time for each cab
    for cab_id in cab_found:
        cab_found[cab_id] = 24 - get_travelled_time(cab_id)

    # select cab has more idle time in last 24 hrs
    cab_id = select_best_cab(cab_found)

    # book cab and update cab-status/ add new journey record
    # Todo: before updating status for cab, put lock on row if getting lock is succedded then only update status
    # this is required to avoid same cab getting booked twice
    if change_cab_state(cab_id=cab_id, cab_status="ontrip"):
        sql = """INSERT INTO `cab_svc`.`journey` (`cab_id`,`customer_id`,`start_city_id`, `end_city_id`) VALUES ( %s,%s,%s,%s);"""
        values = (cab_id, customer_id, customer_city_id, end_city_id)
        db = DBConnection.get_db_con()
        mycursor = db.cursor()
        mycursor.execute(sql, values)
        j_id = mycursor.lastrowid
        db.commit()
        return j_id
    else:
        return False
    # print(cab_found)
    # print(cab_id)

if __name__ == "__main__":
    #register_cab(user_id=2, cab_number="MH12 JZ 3244", cab_city_id=2)
    # register_new_city("Akluj", "MH", "true")
    # change_cab_loc(2, 232434,4324323,6)
    book_cab(customer_id=2, customer_city_id=4, end_city_id=3)
    # print(get_travelled_time(cab_id=3, for_last=24))
    pass