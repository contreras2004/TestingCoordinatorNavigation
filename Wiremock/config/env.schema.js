'use strict'

const Joi = require('@hapi/joi')

module.exports = Joi.object(
  {
    NODE_ENV: Joi.string().allow('development', 'test', 'production').default('production'),

    /**
     * WireMock
     */
    WIREMOCK_DATA: Joi.string().default('wiremock/data'),
    WIREMOCK_HOST: Joi.string().default('http://localhost'),
    WIREMOCK_PORT: Joi.string().default('3000'),
    WIREMOCK_PROXYALL_URL: Joi.string().optional(),

    /**
     * Reloader
     */
    RELOADER_MAX_HTTP_SOCKETS: Joi.number().default(1)
  })
  .unknown(true)
  .options({ abortEarly: false })
  .label('Env Vars')
