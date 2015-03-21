
express = require('express')
app     = express()

cfenv       = require("cfenv")
mongoose    = require('mongoose')
cors        = require('cors')
bodyParser  = require('body-parser')

if process.env.VCAP_SERVICES
  env = JSON.parse(process.env.VCAP_SERVICES);
  mongo = env['mongodb-2.4'][0].credentials;
else
  mongo =
    "username": "user1",
    "password": "secret",
    "url": "mongodb://localhost:27017/test"

# express middleware
app.use(bodyParser.json())
app.use(cors({
  allowedOrigins: [
    'localhost:9000'
  ]
}))

appEnv    = cfenv.getAppEnv()
instance  = appEnv.app.instance_index || 0

# start the server
server = app.listen(appEnv.port, ->
  host = server.address().address
  port = server.address().port
  console.log 'Bluehub API listening at http://%s:%s', host, port
  return
)

# register authentication routes
require('./auth')(app)
