'use strict'

module.exports = (app, passport, models) ->

  # list user repos
  app.get '/repos', (req, res) ->
    return

  # get repo info
  app.get '/repos/:id', (req, res) ->
    return

  # create Bluemix config files
  app.post '/repos/:id', (req, res) ->
    return

  # get the repos current status
  app.get '/repos/:id/status', (req, res) ->
    return

  # deploy the repo to Bluemix
  app.post '/repos/:id/deploy', (req, res) ->
    return

  return
