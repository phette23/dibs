from datetime import datetime, timedelta
from decouple import config
from peewee import SqliteDatabase

from dibs import Item, Loan, Recent, Person

db = SqliteDatabase(config('DATABASE_FILE', default='dibs.db'))

# Peewee autoconnects to the database if doing queries but not other ops.
db.connect()
db.create_tables([Item, Loan, Recent, Person])

# Random books found in TIND.
Item.create(barcode    = '35047019492099',
            title      = 'Vector Calculus',
            author     = 'Marsden and Tromba',
            tind_id    = '735973',
            year       = '2012',
            edition    = '6th ed',
            thumbnail  = 'https://m.media-amazon.com/images/I/71krL5nKamL._AC_UY218_.jpg',
            num_copies = 1,
            duration   = 2,
            ready      = True
)

Item.create(barcode    = '35047019626837',
            title      = 'Fundamentals of geophysics',
            author     = 'Lowrie',
            tind_id    = '990468',
            year       = '2020',
            edition    = 'Third edition',
            thumbnail  = 'https://m.media-amazon.com/images/I/512ooxj+l4L._AC_UY218_.jpg',
            num_copies = 1,
            duration   = 6,
            ready      = True
)

Item.create(barcode    = '35047019626829',
            title      = 'GIS for science',
            author     = 'Wright',
            tind_id    = '990456',
            year       = '2019',
            edition    = '',
            thumbnail  = 'https://m.media-amazon.com/images/I/A1XWvnDDNTL._AC_UY218_.jpg',
            num_copies = 2,
            duration   = 24,
            ready      = False
)

Item.create(barcode    = '350470000611207',
            title      = 'Pack my bag',
            author     = 'Green',
            tind_id    = '466498',
            year       = '1940',
            edition    = '',
            thumbnail  = '',
            num_copies = 1,
            duration   = 1,
            ready      = True
)

Loan.create(item = Item.select().where(Item.barcode == '350470000611207'),
            user = 'someone@caltech.edu',
            started = datetime.now(),
            endtime = datetime.now() + timedelta(hours = 1)
)

print('-'*50)
print('Now use people-manager to add users')
print('-'*50)
