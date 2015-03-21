'use strict'

module.exports = (app, passport, models) ->

  console.log 'register auth routes'

  app.get '/', (req, res) ->
    res.send 'Hello World!'
    return

  return
