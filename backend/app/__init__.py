from flask import Flask
from config.default import Config
from config.production import ProductionConfig
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from database import db
from models import *
from flask import request


def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(config_class)
    migrate = Migrate()
    print("What is app: ", app)
    # Initialize extensions with the application instance
    db.init_app(app)
    migrate.init_app(app, db)

    @app.route('/')
    def index():
        return "Hello, World!"

    @app.route('/create_character', methods=['GET'])
    def get_character_route():
        character = Character.create_character()
        print("What is character: ", character.data)
        return character




    @app.route('/get_event', methods=['GET'])
    def get_event_route():
        return Event.get_random_event()

    @app.route('/update_character', methods=['POST'])
    def update_character_route(charater: Character):
        return charater.update_character(charater)

    @app.route('/random_update_character', methods=['POST'])
    def random_update_character_route(charater: Character):
        return charater.random_update_character(charater)


    return app
