# Cab services

## Summery
It contains set of Cab services, provides REST apis to book intercity cabs 

## DB Schema design
- db_schema.sql and Dump file are also added in project repo. 
  
## Tables

cab:
- cab_id
- cab_user_id
- cab_number
- cab-state: booked, ontrip, idle, not_functioning
- cab_city_id
- cab-lati
- cab-long


city:
- city_id
- city_name
- state_name
- service_available: true/false


user:
- user_id
- user_full_name
- user_address
- user_phone
- user_role: customer/admin/driver


journey
- j_id
- cab-id
- customer_id/user_id
- booked_time
- start_time
- end_time
- start_city_id
- end_city_id
- start_lat
- start_long
- end_lat
- end_long
- travelled_dist
- bill_amount


## System Requirements

* Python 3.8* 
## Getting Started with development env

* Clone the repository, and run the following commands into code's root directory to set up the tool:

```bash
python3 -m venv senv
source senv/bin/activate
pip install -e .[develop]
python cab_svc/api.py # starts development server which serves rest apis
```
## System apis
1.   login()
2. register_cab()
3. register_city()
4. change_cab_loc(cab_id, lat, long, city)--> will only update in cab table
5. book_cab(customer_id, customer_city)  --> will update in journey and return j_id and will be pushed on driver's app
- Todo/ remaining apis:   
    - start_journey(j_id, cab_id, start_lan, start_long) --> will update in journey
    - end_journey(cab_id, end_lan, end_long) --> will update in journey
    - calculate_bill(j_id)
   
## Planned REST apis:
* POST /login: allows logins to customers, cab-driver, admin
* POST /cab: register new cab only called by admin/cab-driver role

* POST /city: onboard new city only called by admin

* POST /journey?action=book/start/end:  
* GET /bill 

# Todo: Unit test are not added due to time limit 