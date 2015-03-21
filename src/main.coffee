
express = require('express')
app     = express()

cfenv       = require("cfenv")
mongoose    = require('mongoose')
cors        = require('cors')
bodyParser  = require('body-parser')

# setup models
mongoose  = require('mongoose')
User = mongoose.model 'User', require('./models/user')

# read mongo configuration
mongo = null
if process.env.VCAP_SERVICES
  env = JSON.parse(process.env.VCAP_SERVICES)
  mongo = env['mongodb-2.4'][0].credentials
else
  mongo =
    "username": "bluehub",
    "password": "bluehub",
    "url": "mongodb://localhost:27017/bluehub"

# connect to mongoose
mongoose.connect(mongo.url, mongo)

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

# register routes
require('./auth')(app, {
  'User': User
})
require('./api')(app, {
  'User': User
})
