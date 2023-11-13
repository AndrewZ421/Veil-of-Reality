import random
from faker import Faker
from database import db

COUNTRY_PATH = 'data/country_codes.csv'


def genearte_parents_name(child_name: str, locale='en_US'):
    fake = Faker()
    child_name = child_name.split(' ')
    child_last_name = child_name[-1]
    father_first_name = fake.first_name_male()
    mother_name = fake.name_female()
    father_name = f'{father_first_name} {child_last_name}'
    return father_name, mother_name


def generate_name(country_code):
    fake = Faker(country_code)
    return fake.name()


