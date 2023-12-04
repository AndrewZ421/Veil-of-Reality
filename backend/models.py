# models.py
import enum
import random

from flask import jsonify

from database import db
import utils

import enum


class EventType(enum.Enum):
    social = 'Social'
    career = 'Career'
    health = 'Health'
    love = 'Love'
    family = 'Family'


class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(64), index=True, unique=True)
    email = db.Column(db.String(120), index=True, unique=True)
    password_hash = db.Column(db.String(128))

    def __repr__(self):
        return f'<User {self.username}>'


class Character(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64), index=True)
    age = db.Column(db.Integer)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    citizenship = db.Column(db.String(64))
    mother_name = db.Column(db.String(64))
    father_name = db.Column(db.String(64))

    def __repr__(self):
        return f'<Character {self.name}>'

    def __init__(self, name, age, user_id, citizenship, mother_name, father_name, gender, occupation):
        self.name = name
        self.age = age
        self.user_id = user_id
        self.citizenship = citizenship
        self.mother_name = mother_name
        self.father_name = father_name
        self.gender = gender
        self.occupation = occupation
        self.smart = random.randint(0, 100)
        self.salary = 0
        self.wealth = random.randint(0, 100)
        self.job = "unemployed"

    def to_dict(self):
        # 将性别和职业转换为字符串

        # 将 Character 实例转换为字典
        return {
            "id": self.id,
            "name": self.name,
            "age": self.age,
            "citizenship": self.citizenship,
            "gender": self.gender,
            "occupation": self.occupation,
            "mother_name": self.mother_name,
            "father_name": self.father_name,
            "smarts": self.smart,
            "salary": self.salary,
            "wealth": self.wealth,
            "job": self.job,
            "health": random.randint(0, 100),
            "happiness": random.randint(0, 100),
            "popularity": random.randint(0, 100),
        }

    @staticmethod
    def generate_citizenship():
        count = Country.query.count()
        random_index = random.randint(0, count - 1)
        country = Country.query.offset(random_index).first()
        return country.original_code, country.country_name, country.country_code

    @staticmethod
    def create_character():
        # 生成角色信息
        citizenship, citizenship_string, _ = Character.generate_citizenship()
        name = utils.generate_name(citizenship)
        user_id = 1
        father_name, mother_name = utils.genearte_parents_name(name, locale=citizenship)

        # Generate random gender
        gender = random.randint(0, 1)
        string_gender = ""
        if gender == 0:
            string_gender = "male"
        else:
            string_gender = "female"

        # 创建新的 Character 实例
        new_character = Character(
            name=name,
            age=0,
            user_id=user_id,
            citizenship=citizenship,
            mother_name=mother_name,
            father_name=father_name,
            gender=string_gender,
            occupation="unemployed",

        )

        # 将新实例添加到数据库会话
        db.session.add(new_character)

        # 提交会话以保存更改
        try:
            db.session.commit()
            new_character.citizenship = citizenship_string
            return jsonify(new_character.to_dict())
        except Exception as e:
            db.session.rollback()
            raise e

    def update_character(self, new_character):
        self.age = new_character["age"]
        self.smart = new_character["smart"]
        self.salary = new_character["salary"]
        self.wealth = new_character["wealth"]
        self.job = new_character["job"]
        self.occupation = new_character["occupation"]
        try:
            db.session.commit()
            return jsonify(self.to_dict())
        except Exception as e:
            db.session.rollback()
            raise e

    def random_update_character(self, charater):
        self.age += 1
        self.smart += random.randint(-5, 5)
        self.salary += random.randint(-5, 5)
        self.wealth += random.randint(-5, 5)
        try:
            db.session.commit()
            return jsonify(self.to_dict())
        except Exception as e:
            db.session.rollback()
            raise e

class Event(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(128), nullable=False)
    description = db.Column(db.Text, nullable=False)
    type = db.Column(db.Enum(EventType), nullable=False)
    choices = db.relationship('Choice', backref='event', lazy=True)

    def __init__(self, name, description, event_type):
        self.name = name
        self.description = description
        self.type = event_type

    def __repr__(self):
        return f'<Event {self.name}>'

    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description,
            "type": self.type.name,  # Assuming EventType is an enum
            "choices": [choice.to_dict() for choice in self.choices]
        }

    @staticmethod
    def get_random_event():
        count = Event.query.count()
        random_index = random.randint(0, count - 1)
        event = Event.query.offset(random_index).first()
        return jsonify(event.to_dict())


class Choice(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    description = db.Column(db.Text, nullable=False)
    event_id = db.Column(db.Integer, db.ForeignKey('event.id'), nullable=False)

    def __init__(self, description, event_id):
        self.description = description
        self.event_id = event_id

    def __repr__(self):
        return f'<Choice {self.description}>'

    def to_dict(self):
        return {
            "id": self.id,
            "description": self.description,
            "event_id": self.event_id
        }


class Country(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    original_code = db.Column(db.String(50))
    country_code = db.Column(db.String(50))
    country_name = db.Column(db.String(100))

    def __repr__(self):
        return f'<Country {self.country_name}>'
