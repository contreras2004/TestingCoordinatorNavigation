
'use strict'

const Joi = require('@hapi/joi')

const Package = require('../package.json')
const EnvSchema = require('./env.schema')

const EnvVars = Joi.attempt(process.env, EnvSchema)

module.exports = {
  env: EnvVars.NODE_ENV,
  version: Package.version,

  isProduction: EnvVars.NODE_ENV === 'production',
  isTest: EnvVars.NODE_ENV === 'test',

  reloader: {
    maxHttpSockets: EnvVars.RELOADER_MAX_HTTP_SOCKETS
  },

  wiremock: {
    host: EnvVars.WIREMOCK_HOST,
    port: EnvVars.WIREMOCK_PORT,
    dataDir: EnvVars.WIREMOCK_DATA,
    proxyTo: EnvVars.WIREMOCK_PROXYALL_URL
  }
}
