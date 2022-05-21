from flask import Flask
from flask import jsonify, redirect
from flask import request
from requests.status_codes import codes

from cab_svc.helper import register_cab, register_new_city, change_cab_loc, book_cab
from cab_svc.api_common.exception import ApiError, InvalidContent, handle_error, not_found_error


app = Flask(__name__)

app.errorhandler(ApiError)(handle_error)
app.errorhandler(codes.not_found)(not_found_error)

@app.route('/version')
def get_version():
    return jsonify({'version': "1.1"})


@app.route('/cab', methods=["POST", "PUT"])
def cab_oprn():
    data = request.json
    if request.method == "POST":
        try:
            return jsonify(register_cab(data['user_id'], data['cab_number'], data['cab_city_id']))
        except KeyError:
            raise ApiError("please provide user_id, cab_number, cab_city_id in json format", 400)
        # Todo: add custom very specific exceptions later if time permits
        except Exception as err:
            # logger.error(err)
            raise ApiError("Could not process request due to: {}".format(str(err)), 500)
    else:
        try:
            return jsonify(change_cab_loc(data['cab_id'], data['lat'], data['long'], data['city_id']))
        except KeyError:
            raise ApiError("please provide cab_id, lat, long, city_id in json format", 400)
        # Todo: add custom very specific exceptions later if time permits
        except Exception as err:
            # logger.error(err)
            raise ApiError("Could not process request due to: {}".format(str(err)), 500)


@app.route('/city', methods=["POST"])
def add_city():
    data = request.json
    try:
        return jsonify(register_new_city(data['city_name'], data['state_name'], data['service_status']))
    except KeyError:
        raise ApiError("please provide city_name, state_name, service_status in json format", 400)
    # Todo: add custom very specific exceptions later if time permits
    except Exception as err:
        # logger.error(err)
        raise ApiError("Could not process request due to: {}".format(str(err)), 500)


@app.route('/journey', methods=["POST"])
def book_oprn():
    # Todo: added support for ?action=book only, need to add support for action=start_journey and action=stop_journey
    data = request.json
    try:
        # customer_id, customer_city_id, end_city_id
        j_id = book_cab(data['customer_id'], data['customer_city_id'], data['end_city_id'])
        if j_id:
            return jsonify({"journey_id": j_id})
        else:
            raise ApiError("Could not perform booking, due to some techincal issue", 500)
    except KeyError:
        raise ApiError("please provide customer_id, customer_city_id, end_city_id in json format", 400)
    # Todo: add custom very specific exceptions later if time permits
    except Exception as err:
        # logger.error(err)
        raise ApiError("Could not process request due to: {}".format(str(err)), 500)


@app.route('/bill/<j_id>', methods=["GET"])
def bill_oprn():
    pass
    # Todo: will be added later


app.run()
