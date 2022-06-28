import { Elm } from './Main.elm'
import Sockette from 'sockette'

const app = Elm.Main.init({
  node: document.querySelector('main'),
  flags: {
    devicePixelRatio: window.devicePixelRatio,
    screenDimensions: [window.innerWidth, window.innerHeight],
  },
})

app.ports.log.subscribe(console.log)

const wsPort = app.ports.wsSub

const ws = new Sockette(`ws://${window.location.hostname}:8080`, {
  timeout: 15e3,
  onopen (e) {
    wsPort.send({ event: 'open' })
  },
  onmessage ({ data }) {
    try {
      const msg = JSON.parse(data)
      wsPort.send({ event: 'msg', msg })
    } catch (e) {
      wsPort.send({
        event: 'error',
        error: {
          type: 'json',
          data,
        },
      })
    }
  },
  onreconnect (e) {
    console.log('reconnecting')
  },
  onclose ({ code, reason, wasClean }) {
    wsPort.send({
      event: 'close',
      code,
      reason,
      wasClean,
    })
  },
  onerror: e => {
    wsPort.send({
      event: 'error',
      error: {
        type: 'ws',
      },
    })
  }
})

app.ports.sendMsg.subscribe(json => {
  ws.json(json)
})
