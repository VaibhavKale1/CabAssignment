from flask import jsonify
import logging


logger = logging.getLogger(__name__)


class ApiError(Exception):
    def __init__(self, message, status_code=400):
        Exception.__init__(self)
        self.message = message
        self.status_code = status_code
        logger.warning(message + str(status_code))

    def to_dict(self):
        return {'message': self.message}


def handle_error(error):
    response = jsonify(error.to_dict())
    response.status_code = error.status_code
    logger.warning(response)
    return response


def not_found_error(error):
    response = jsonify({'message': error.description})
    response.status_code = error.code
    logger.warning(response)
    return response


class InvalidContent(Exception):
    def __init__(self, msg):
        super(InvalidContent, self).__init__(msg)
