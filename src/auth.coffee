'use strict'

module.exports = (app, passport, models) ->

  console.log 'register auth routes'

  app.get '/login', (req, res) ->
    res.send 'Hello World!'
    return

  return
