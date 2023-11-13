from flask import Flask
from config.default import Config
from config.production import ProductionConfig
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from database import db
from models import *


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
        return Character.create_character()

    return app
