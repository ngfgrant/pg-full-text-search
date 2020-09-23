import datetime
import json
import uuid
from faker import Faker

fake = Faker()
MAX_RANGE = 10000000

# geneate JSON
with open('data-large.json', 'w') as f:
    for i in range(0, MAX_RANGE):
        f.write(json.dumps({
            'id': str(uuid.uuid4()),
            'first_name': fake.first_name(),
            'last_name': fake.last_name(),
            'email': fake.email(),
            'date_of_birth': str(fake.date_of_birth()),
            'address': fake.street_address(), 
        }) + "\n")
