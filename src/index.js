import { Elm } from './Main.elm'
import { subscribe as portFunnelSubscribe } from './js/PortFunnel'
import { init as initWebsocket } from './js/WebSocket'

const app = Elm.Main.init({
  node: document.querySelector('main'),
  flags: {
    devicePixelRatio: window.devicePixelRatio,
    screenDimensions: [window.innerWidth, window.innerHeight],
    webSocketUrl: `ws://${window.location.hostname}:8080`,
  },
})

app.ports.log.subscribe(console.log)

portFunnelSubscribe(app)
initWebsocket()
