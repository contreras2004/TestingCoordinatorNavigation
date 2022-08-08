'use strict';

const Request = require('request-promise').defaults({ pool: { maxSockets: process.env.RELOADER_MAX_HTTP_SOCKETS || 1 } });
const Chokidar = require('chokidar');
const IP = require('ip');

const WIREMOCK_DATA = process.env.WIREMOCK_DATA || './data';
const WIREMOCK_HOST = process.env.WIREMOCK_HOST || 'wiremock';
const WIREMOCK_PORT = process.env.WIREMOCK_PORT || 3000;
const WIREMOCK_BASE_URI = `${WIREMOCK_HOST}:${WIREMOCK_PORT}`

const watcher = Chokidar.watch(WIREMOCK_DATA, { ignored: [/(^|[\/\\])\../], persistent: true, ignoreInitial: true });

const onFileChange = (event, path) => {
  const valid = path && path.substr(path.length - 5) === '.json' && path.length > 5;

  if (!valid) {
    return;
  }

  console.log(`\x1b[33mStub change detected [${event}]. Reseting WireMock mappings ...\x1b[0m`);

  Request({ uri: `${WIREMOCK_BASE_URI}/__admin/mappings/reset`, method: 'POST' })
    .then(() => console.log('\x1b[32mWireMock mappings reseted!', '\x1b[0m'))
    .catch(err => console.error('\x1b[31mWireMock is unavailable now!', err, '\x1b[0m'));
};

watcher
  .on('ready', () => console.log(
    `\x1b[32mWireMock Reloader Tool ready!\nContext: ${process.cwd()}\nWireMock: ${WIREMOCK_BASE_URI}\nListening for changes on: ${WIREMOCK_DATA}\nChange your API Base URI to: http://${IP.address()}:${WIREMOCK_PORT}\n\n`, '\x1b[0m'))
  .on('error', error => console.error(error))
  .on('add', path => onFileChange('add', path))
  .on('change', path => onFileChange('change', path))
  .on('unlink', path => onFileChange('unlink', path));
