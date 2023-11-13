import csv
from app import db, create_app  # 确保从您的app模块中导入create_app
from models import Country

def load_csv_to_db(filename):
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

# 在应用程序上下文中执行函数
with app.app_context():
    load_csv_to_db('./data/country_codes.csv')
