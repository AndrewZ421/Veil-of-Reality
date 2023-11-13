from flask import Flask, request
from app import create_app



# app = create_app()
app = create_app()
@app.route('/')
def abc():
    return "Hello, World!"

if __name__ == '__main__':
    app.run()









