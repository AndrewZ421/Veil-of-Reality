from flask import Flask, request

app = Flask(__name__)


@app.route('/', methods=['GET'])
def hello_world():
    return 'Hello World!'


@app.route('/', methods=['POST'])
def get_choice():
    # 这里可以从 request 中获取发送的数据
    # 比如使用 request.json 来获取 JSON 数据
    data = request.json
    print(data)
    # 处理数据并返回响应
    return "Event received", 200


if __name__ == '__main__':
    app.run(port=5000)
