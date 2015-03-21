
express = require('express')
app     = express()

cfenv       = require("cfenv")
cors        = require('cors')
bodyParser  = require('body-parser')

# express middleware
app.use bodyParser.json()
###
app.use cors({
  allowedOrigins: [
    'localhost:9000'
    'http://thebluehub.mybluemix.net'
  ]
})
###
app.use cors()

appEnv    = cfenv.getAppEnv()
instance  = appEnv.app.instance_index || 0

console.log "app env : #{JSON.stringify(appEnv)}"

# start the server
server = app.listen(appEnv.port, ->
  host = server.address().address
  port = server.address().port
  console.log 'Bluehub API listening at http://%s:%s', host, port
  return
)

# register API
require('./api')(app)

# test route
app.get '/', (req, res) ->
  res.write 'Hello World!'
