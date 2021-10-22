//////////////////////////////////////////////////////////////////////
//
// PortFunnel.js
// JavaScript runtime code for billstclair/elm-port-funnel
// Copyright (c) 2018-2019 Bill St. Clair <billstclair@gmail.com>
// Some rights reserved.
// Distributed under the MIT License
// See LICENSE
//
// Modified by Nikita Gaidakov
//
//////////////////////////////////////////////////////////////////////

const modules = {} // modules[funnelName].cmd set by module JS.
let sub = null

export function subscribe(app, options = {}) {
  const { subPort = 'subPort', cmdPort = 'cmdPort' } = options

  sub = app.ports[subPort]

  app.ports[cmdPort].subscribe(function(command) {
    const returnValue = commandDispatch(command)
    if (returnValue) {
      sub.send(returnValue)
    }
  })
}

export function registerModule(name, cmd) {
  modules[name] = cmd
}

export function send(msg) {
  sub.send(msg)
}

// command is of the form:
//    { module: 'moduleName',
//      tag: 'command name for module',
//      args: {name: value, ...}
//    }
function commandDispatch(command) {
  if (typeof(command) == 'object') {
    var moduleName = command.module;
    var module = modules[moduleName];
    if (module) {
      var cmd = module.cmd;
      if (cmd && !queue[moduleName]) {
        var tag = command.tag;
        var args = command.args;
        return cmd(tag, args);
      } else {
        var list = queue[moduleName];
        if (!list) list = [];
        list.push(command);
        queue[moduleName] = list;
        if (!queueDrainOutstanding) {
          scheduleQueueDrain();
        }
      }
    }
  }
}

// queue[moduleName] = an array of commands passed to commandDispatch
// before the JavaScript module was installed.
const queue = {};
let queueDrainOutstanding = false;

function scheduleQueueDrain() {
  queueDrainOutstanding = true;
  setTimeout(drainQueue, 10);  // is 0.01 second too short?
}

function drainQueue() {
  var needReschedule = false;
  for (var moduleName in queue) {
    var module = modules[moduleName];
    if (!module) {
      // Can't happen, but handle it anyway
      delete queue[moduleName];
    } else {
      if (!module.cmd) {
        needReschedule = true;
      } else {
        var list = queue[moduleName];
        delete queue[moduleName];
        for (var i in list) {
          var command = list[i];
          var returnValue = commandDispatch(command);
          if (returnValue) {
            sub.send(returnValue);
          }
        }
      }
      if (needReschedule) {
        scheduleQueueDrain();
      } else {
        queueDrainOutstanding = false;
      }
    }
  }
}
