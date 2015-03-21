# Bluehub

> Easily deploy your badass Github projects to IBM's Bluemix baby ;)

## Local Development

Local development requires a MongoDb named `bluemix` with a mongo user that
has readWrite role on this DB with username `bluemix` and password `bluemix`.

```bash
$ mongo
MongoDB shell version: 3.0.0
connecting to: test
Welcome to the MongoDB shell.
For interactive help, type "help".
For more comprehensive documentation, see
	http://docs.mongodb.org/
Questions? Try the support group
	http://groups.google.com/group/mongodb-user
> use bluemix
> db.createUser({user: 'bluehub', pwd: 'bluehub', roles: [ {db: 'bluehub', role: 'admin'} ]});
```

## Authors

- Dawson Reid <dreid93@gmail.com>
- Shawn
- Kashif
- Nelson
