from faker import Faker

def genearte_parents_name(child_name: str):
    fake = Faker('en_US')
    child_name = child_name.split(' ')
    child_last_name = child_name[-1]
    father_first_name = fake.first_name_male()
    mother_name = fake.name_female()
    father_name = f'{father_first_name} {child_last_name}'
    return father_name, mother_name

father_name, mother_name = genearte_parents_name('John Smith')
print(father_name, mother_name)
def generate_name():
    pass


def generate_country():
    pass


