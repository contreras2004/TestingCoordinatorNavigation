'use strict'

require('dotenv').config()

const Spawn = require('child_process').spawn
const Program = require('commander')
const Config = require('./config')

const SHELL_OPTIONS = { stdio: 'inherit', shell: true }

const argv = process.argv
if (argv.length <= 2) argv.push('--help')

Program.version(Config.version).description('Mock API Tool-Kit')

const initReloader = () => Spawn('node', ['wiremock-auto-reloader/index.js'], SHELL_OPTIONS)

Program
  .command('mock')
  .description('Start default mock tool kit')
  .action(() => {
    initReloader()
    Spawn('java',
      ['-jar', 'wiremock/wiremock.jar', `--root-dir=${Config.wiremock.dataDir}`, `--port=${Config.wiremock.port}`, '--verbose'],
      SHELL_OPTIONS)
  })

Program
  .command('mock-proxy')
  .description('Start mock tool kit with WireMock in proxy-all mode. The proxy-all URL must be set via environment variable or with your local .env file')
  .action(() => {
    initReloader()
    Spawn('java',
      ['-jar', 'wiremock/wiremock.jar', `--root-dir=${Config.wiremock.dataDir}`, `--port=${Config.wiremock.port}`, '--verbose', `--proxy-all=${Config.wiremock.proxyTo}`],
      SHELL_OPTIONS)
  })

Program.parse(argv)
