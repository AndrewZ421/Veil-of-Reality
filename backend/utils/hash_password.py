import bcrypt

def hash_password(password):
    # 将密码转换为字节
    password_bytes = password.encode('utf-8')

    # 生成盐
    salt = bcrypt.gensalt()

    # 创建哈希
    hashed_password = bcrypt.hashpw(password_bytes, salt)

    return hashed_password

# 使用函数的例子
password = "123"
hashed = hash_password(password)
print(hashed)
