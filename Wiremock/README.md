# Wiremock Toolkit
[![Build Status](https://travis-ci.org/vitorsalgado/wiremock-toolkit.svg?branch=master)](https://travis-ci.org/vitorsalgado/wiremock-toolkit)  

This repository contains a tool kit to start using [WireMock](http://wiremock.org/) in a development environment.  
It comes with a tool which restarts WireMock every time a mapping or payload file is changed, making development process easier.  

## Requirements
**Node.js** + **Java** or **Docker**.

## How To
The preferred way to use this toolkit is using the Node.js CLI application in project root.  
First install required dependencies:
```
npm install --production
```
Check `Makefile` or `package.json` scripts section for all available commands.  

## Configuration
To change/configure **WireMock** host, port and data folder configurations, you can use a **.env** file that must be placed on project root directory.  
Check **.env.sample** file for a sample of how to configure your **.env** file.

## Reloader Tool
The reloader tool is built with *Node.js* and is located on folder `wiremock-auto-reloader`. 

## License
This project is available under Apache Public License version 2.0. See [LICENSE](LICENSE).
 