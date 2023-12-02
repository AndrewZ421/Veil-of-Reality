import csv
from app import db, create_app
from models import Country, Event, Choice, EventType

def load_country_to_db(filename):
    with open(filename, 'r') as file:
        reader = csv.reader(file)
        next(reader)  # 跳过标题行
        for row in reader:
            country = Country(
                original_code=row[0],
                country_code=row[1],
                country_name=row[2]
            )
            db.session.add(country)
        db.session.commit()






# 创建 Flask 应用实例
app = create_app()

# # 在应用程序上下文中执行函数
# with app.app_context():
#     load_country_to_db('./data/country_codes.csv')

def load_event_to_db(filename):
    # 打开CSV文件并读取数据
    with open(filename, 'r') as csv_file:
        csv_reader = csv.reader(csv_file)
        next(csv_reader)  # 跳过标题行

        for row in csv_reader:
            # 解析CSV行中的数据
            name, description, event_type, choices_str = row
            event_type = EventType[event_type.lower()]  # 使用适当的方式将字符串转换为Enum类型

            # 创建Event对象并添加到数据库
            event = Event(name=name, description=description, event_type=event_type)
            db.session.add(event)
            db.session.flush()  # 获取Event的自动生成ID

            # 解析choices_str并创建Choice对象
            choices = choices_str.strip('[]').split(', ')
            for choice_description in choices:
                choice = Choice(description=choice_description, event_id=event.id)
                db.session.add(choice)

        # 提交更改到数据库
        db.session.commit()

with app.app_context():
    load_event_to_db('./data/updated_events.csv')
    load_country_to_db('./data/country_codes.csv')