'use strict';

const apickli = require('apickli');
const { Before } = require('@cucumber/cucumber');

Before(async function() {
  this.apickli = new apickli.Apickli('http', 'localhost:5000');
  this.apickli.addRequestHeader('Content-Type', 'application/json');
  this.apickli.addRequestHeader('Cache-Control', 'no-cache');
  await new Promise(resolve => setTimeout(resolve, 1000));
});