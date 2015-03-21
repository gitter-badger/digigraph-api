
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

console.log "mongo credentials : #{JSON.stringify(mongo)}"

# connect to mongoose
mongoose.connect(mongo.url, mongo)
mongoose.connection.on('error', console.error.bind(console, 'connection error:'))
mongoose.connection.once('open', (callback) ->
  console.log 'connected to mongo'

  # express middleware
  app.use bodyParser.json()
  app.use cors({
    allowedOrigins: [
      'localhost:9000'
      'http://thebluehub.mybluemix.net'
    ]
  })

  # setup passport
  passport        = require('passport')
  GitHubStrategy  = require('passport-github').Strategy

  GITHUB_CLIENT_ID = "17177c6909df67f38bd6"
  GITHUB_CLIENT_SECRET = "f6a2caf0695a68cf8a1d26b4400bc25ae055bacd";

  passport.serializeUser (user, done) ->
    console.log "serialize user : #{user}"
    done(null, user)

  passport.deserializeUser (obj, done) ->
    console.log "deserialize user : #{user}"
    done(null, obj)

  passport.use new GitHubStrategy({
      clientID: GITHUB_CLIENT_ID,
      clientSecret: GITHUB_CLIENT_SECRET,
      callbackURL: "http://127.0.0.1:3000/auth/github/callback"
    }, (accessToken, refreshToken, profile, done) ->
      process.nextTick ->
        console.log 'GitHubStrategy nextTick'
        return done(null, profile);
    ) # end passport.use

  # passport middleware
  app.use passport.initialize()
  app.use passport.session()

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

  # register routes
  require('./auth')(app, passport, {
    'User': User
  })
  require('./api')(app, passport, {
    'User': User
  })

  # test route
  app.get '/', (req, res) ->
    res.write 'Hello World!'
) # end mongoose open
