from setuptools import setup
from setuptools import find_packages

# entry_points = {
#     'console_scripts': [
#         'listener = prodigy.listener.__main__:main',
#         'processor = prodigy.processor.__main__:processor'
#     ]
# }

runtime = {
    'Flask=2.1.2',
    'gunicorn==19.7.1',
}

develop = {
    'flake8',
    'pytest',
    'pytest-cov',
}


setup(
    name='cab_service',
    version='0.1',
    description='Cab service apis',
    packages=find_packages(),
    package_data={'': ['*.j2', '*.yml']},
    install_requires=list(runtime ),
    extras_require={
        'develop': list(runtime | develop)
    },
    #entry_points=entry_points
)
